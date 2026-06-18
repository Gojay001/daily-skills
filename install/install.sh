#!/usr/bin/env bash
# daily-skills installer — symlink skills into agent directories.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MANIFEST="$REPO_ROOT/manifest.yaml"
HOSTS_FILE="$REPO_ROOT/install/hosts.yaml"

HOST=""
SCOPE=""
PROJECT_PATH=""
SKILLS=""
ALL=0
CMD="install"

usage() {
  cat <<'EOF'
Usage: install.sh [command] [options]

Commands:
  install     Link skills (default)
  uninstall   Remove daily-* symlinks
  list        Show registered skills
  doctor      Check repo + manifest + paths

Install options:
  --host HOST       cursor | claude | codex | opencode
  --scope SCOPE     global | project
  --path PATH       Project root (required for --scope project)
  --skills IDS      Comma-separated skill ids (e.g. hello-skill,a,b)
  --all             Install every skill in manifest.yaml

Examples:
  ./install/install.sh --host cursor --scope global --all
  ./install/install.sh --host cursor --scope global --skills hello-skill
  ./install/install.sh --host cursor --scope project --path ../my-app --skills hello-skill
  ./install/install.sh list
  ./install/install.sh doctor
EOF
}

log() { echo "daily-skills: $*"; }
err() { echo "daily-skills: error: $*" >&2; exit 1; }

expand_home() {
  local p="$1"
  if [[ "$p" == "~/"* ]]; then
    echo "${HOME}/${p:2}"
  else
    echo "$p"
  fi
}

get_prefix() {
  local line
  line=$(grep -E '^prefix:' "$MANIFEST" 2>/dev/null | head -1 | sed 's/^prefix:[[:space:]]*//' | tr -d '"' | tr -d "'")
  echo "${line:-daily}"
}

get_host_path() {
  local host="$1"
  local scope="$2"
  local key="global"
  [ "$scope" = "project" ] && key="project"

  local in_block=0
  local line key_line val
  while IFS= read -r line; do
    if [[ "$line" =~ ^[[:space:]]*${host}:[[:space:]]*$ ]]; then
      in_block=1
      continue
    fi
    if [ "$in_block" -eq 1 ] && [[ "$line" =~ ^[[:space:]]+[a-z] ]]; then
      if [[ ! "$line" =~ ^[[:space:]]+(global|project): ]]; then
        break
      fi
    fi
    if [ "$in_block" -eq 1 ] && [[ "$line" =~ ^[[:space:]]*${key}:[[:space:]]*(.+)$ ]]; then
      val="${BASH_REMATCH[1]}"
      expand_home "$val"
      return 0
    fi
  done < "$HOSTS_FILE"
  return 1
}

manifest_skill_ids() {
  awk '
    /^[[:space:]]*- id:/ { gsub(/.*id:[[:space:]]*/, ""); gsub(/["'\'' ]/, ""); print }
  ' "$MANIFEST"
}

skill_path_for_id() {
  local id="$1"
  awk -v id="$id" '
    $0 ~ "- id: " id { found=1; next }
    found && /path:/ {
      gsub(/.*path:[[:space:]]*/, ""); gsub(/["'\'' ]/, ""); print; exit
    }
  ' "$MANIFEST"
}

validate_skill() {
  local id="$1"
  local rel
  rel=$(skill_path_for_id "$id")
  [ -n "$rel" ] || err "unknown skill id: $id (not in manifest.yaml)"
  [ -f "$REPO_ROOT/$rel/SKILL.md" ] || err "missing SKILL.md: $REPO_ROOT/$rel/SKILL.md"
}

link_skill() {
  local target_dir="$1"
  local id="$2"
  local prefix="$3"
  local rel dest name

  rel=$(skill_path_for_id "$id")
  validate_skill "$id"
  name="${prefix}-${id}"
  dest="$target_dir/$name"
  mkdir -p "$target_dir"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    err "$dest exists and is not a symlink — remove manually or pick another name"
  fi
  ln -snf "$REPO_ROOT/$rel" "$dest"
  log "linked $name -> $REPO_ROOT/$rel"
}

unlink_skill() {
  local target_dir="$1"
  local id="$2"
  local prefix="$3"
  local dest="${target_dir}/${prefix}-${id}"

  if [ -L "$dest" ]; then
    rm -f "$dest"
    log "removed $dest"
  elif [ -e "$dest" ]; then
    log "skip $dest (not a symlink)"
  fi
}

resolve_target_dir() {
  local host="$1"
  local scope="$2"
  local project="$3"
  local base

  base=$(get_host_path "$host" "$scope") || err "unknown host '$host' in install/hosts.yaml"
  if [ "$scope" = "project" ]; then
    [ -n "$project" ] || err "--path is required for --scope project"
    [ -d "$project" ] || err "project path not found: $project"
    echo "$(cd "$project" && pwd)/${base#./}"
  else
    expand_home "$base"
  fi
}

parse_skill_list() {
  local raw="$1"
  local ids=()
  if [ "$ALL" -eq 1 ]; then
    while IFS= read -r id; do
      [ -n "$id" ] && ids+=("$id")
    done < <(manifest_skill_ids)
  else
    IFS=',' read -ra ids <<< "$raw"
  fi
  if [ "${#ids[@]}" -eq 0 ]; then
    err "no skills selected — use --skills id1,id2 or --all"
  fi
  echo "${ids[@]}"
}

cmd_list() {
  local id rel
  echo "Registered skills (prefix: $(get_prefix)):"
  while IFS= read -r id; do
    [ -z "$id" ] && continue
    rel=$(skill_path_for_id "$id")
    echo "  - $id  ($rel)"
  done < <(manifest_skill_ids)
}

cmd_doctor() {
  [ -f "$MANIFEST" ] || err "missing manifest.yaml"
  [ -f "$HOSTS_FILE" ] || err "missing install/hosts.yaml"
  local id rel
  local ok=1
  while IFS= read -r id; do
    [ -z "$id" ] && continue
    rel=$(skill_path_for_id "$id")
    if [ -f "$REPO_ROOT/$rel/SKILL.md" ]; then
      log "OK  $id"
    else
      log "MISSING  $id ($REPO_ROOT/$rel/SKILL.md)"
      ok=0
    fi
  done < <(manifest_skill_ids)
  for h in cursor claude codex opencode; do
    if get_host_path "$h" global >/dev/null 2>&1; then
      log "host $h global -> $(get_host_path "$h" global)"
    fi
  done
  [ "$ok" -eq 1 ] || exit 1
  log "doctor passed"
}

cmd_install() {
  [ -n "$HOST" ] || err "missing --host"
  [ -n "$SCOPE" ] || err "missing --scope"
  local target prefix ids id
  target=$(resolve_target_dir "$HOST" "$SCOPE" "$PROJECT_PATH")
  prefix=$(get_prefix)
  read -ra ids <<< "$(parse_skill_list "$SKILLS")"
  log "installing to $target (host=$HOST scope=$SCOPE prefix=$prefix)"
  for id in "${ids[@]}"; do
    id="${id// /}"
    [ -n "$id" ] || continue
    link_skill "$target" "$id" "$prefix"
  done
  log "done (${#ids[@]} skill(s))"
}

cmd_uninstall() {
  [ -n "$HOST" ] || err "missing --host"
  [ -n "$SCOPE" ] || err "missing --scope"
  local target prefix ids id
  target=$(resolve_target_dir "$HOST" "$SCOPE" "$PROJECT_PATH")
  prefix=$(get_prefix)
  read -ra ids <<< "$(parse_skill_list "$SKILLS")"
  for id in "${ids[@]}"; do
    id="${id// /}"
    [ -n "$id" ] || continue
    unlink_skill "$target" "$id" "$prefix"
  done
  log "uninstall done"
}

# Parse args
while [ $# -gt 0 ]; do
  case "$1" in
    install|uninstall|list|doctor)
      CMD="$1"; shift ;;
    --host) HOST="$2"; shift 2 ;;
    --host=*) HOST="${1#*=}"; shift ;;
    --scope) SCOPE="$2"; shift 2 ;;
    --scope=*) SCOPE="${1#*=}"; shift ;;
    --path) PROJECT_PATH="$2"; shift 2 ;;
    --path=*) PROJECT_PATH="${1#*=}"; shift ;;
    --skills) SKILLS="$2"; shift 2 ;;
    --skills=*) SKILLS="${1#*=}"; shift ;;
    --all) ALL=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) err "unknown argument: $1 (try --help)" ;;
  esac
done

case "$CMD" in
  list) cmd_list ;;
  doctor) cmd_doctor ;;
  install) cmd_install ;;
  uninstall) cmd_uninstall ;;
esac
