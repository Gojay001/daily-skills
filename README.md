# daily-skills

个人/团队常用 Agent Skills 集合。一个 Git 仓库管理源码，通过 symlink 可插拔安装到各 Agent 的全局或项目目录。

## 与 gstack 的关系

| 层 | 用途 | 安装方式 |
|----|------|----------|
| [gstack](https://github.com/garrytan/gstack) | 重型工程流程（review / qa / ship …） | `~/.cursor/skills/gstack` 单独维护 |
| **daily-skills** | 轻量自定义 skills | 本仓库 `install/install.sh` |
| 项目级 | 项目特有规范 | `--scope project` |

## 快速开始

```bash
# 检查仓库
./install/install.sh doctor

# 列出已登记 skills
./install/install.sh list

# 安装到 Cursor 全局（本机所有项目可用）
./install/install.sh --host cursor --scope global --all

# 只装一个 skill
./install/install.sh --host cursor --scope global --skills hello-skill

# 安装到某个项目的 .cursor/skills/
./install/install.sh --host cursor --scope project --path /path/to/your-repo --skills hello-skill
```

安装后 symlink 名称带 `daily-` 前缀，例如 `~/.cursor/skills/daily-hello-skill`。

**Cursor**：新开 Agent 对话后，说「运行 hello skill」或「test daily-skills」验证。

## 支持的 Agent

| Agent | `--host` | 全局目录 | 项目目录 |
|-------|----------|----------|----------|
| Cursor | `cursor` | `~/.cursor/skills/` | `.cursor/skills/` |
| Claude Code | `claude` | `~/.claude/skills/` | `.claude/skills/` |
| Codex | `codex` | `~/.codex/skills/` | `.agents/skills/` |
| OpenCode | `opencode` | `~/.config/opencode/skills/` | `.opencode/skills/` |

## 添加新 skill

1. 创建目录 `skills/<skill-id>/SKILL.md`（含 YAML frontmatter：`name`、`description`）
2. 在 `manifest.yaml` 登记 `id` 和 `path`
3. `./install/install.sh doctor`
4. 重新安装：`./install/install.sh --host cursor --scope global --skills <skill-id>`

## 卸载

```bash
./install/install.sh uninstall --host cursor --scope global --skills hello-skill
./install/install.sh uninstall --host cursor --scope global --all
```

## 目录结构

```
daily-skills/
├── manifest.yaml       # skill 注册表
├── skills/             # canonical SKILL.md 源码
├── install/
│   ├── install.sh
│   └── hosts.yaml      # 各 agent 路径映射
└── README.md
```
