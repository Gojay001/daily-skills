---
name: headroom
description: >-
  Guide Headroom context compression setup and usage with Cursor and other agents.
  Use when the user mentions headroom, token savings, compressing tool outputs/logs,
  context window pressure, or asks to reduce LLM token usage. Covers install,
  headroom wrap cursor, proxy, and MCP integration.
---

# Headroom — Context Compression for AI Agents

[Headroom](https://github.com/headroomlabs-ai/headroom) compresses tool outputs, logs, files, RAG chunks, and conversation history **before** they reach the LLM. Typical savings: **60–95% tokens**, with reversible compression (CCR).

## When to use this skill

- User asks about **headroom**, **token savings**, or **context compression**
- Tool outputs / logs are bloating the context window
- User wants to wire Headroom into **Cursor**, Claude Code, Codex, or MCP workflows
- Long sessions hit context limits or cost spikes

## Prerequisites check

```bash
command -v headroom >/dev/null 2>&1 && headroom --version || echo "HEADROOM_NOT_INSTALLED"
python3 -m pip show headroom-ai 2>/dev/null | head -2 || true
```

If not installed:

```bash
pip install headroom-ai
# or: pip install 'headroom-ai[all]'   # all optional extras
```

## Cursor integration (recommended path)

### Option A: One-command wrap

```bash
headroom wrap cursor
```

This starts the local proxy and prints Cursor configuration lines. User pastes once:

1. **Settings → Models → OpenAI API Key → Override OpenAI Base URL** → use printed OpenAI base URL
2. For Anthropic models, set the printed Anthropic base URL similarly
3. API keys remain the user's own OpenAI / Anthropic keys

Re-run from a project directory to attribute savings to that project.

### Option B: Manual proxy

```bash
headroom proxy --port 8787
```

Point Cursor model base URLs at `http://127.0.0.1:8787` (OpenAI-compatible and Anthropic-compatible endpoints).

### Option C: MCP server

Add Headroom MCP tools (`headroom_compress`, `headroom_retrieve`, `headroom_stats`) in Cursor MCP settings. See [MCP docs](https://headroom-docs.vercel.app/docs/mcp).

## Agent behavior when Headroom is active

1. **Prefer compressed context** — large tool outputs, build logs, and file dumps are candidates for compression before re-injecting into the prompt.
2. **Use CCR retrieval when needed** — if compressed context hides a detail the user asks about, retrieve originals via Headroom rather than re-fetching everything raw.
3. **Do not disable compression silently** — if quality degrades, say so and offer to retrieve specific originals.
4. **Monitor pressure** — when context is tight, suggest Headroom for the next large read (test output, grep flood, RAG dump).

## Common commands

| Command | Purpose |
|---------|---------|
| `headroom wrap cursor` | Start proxy + print Cursor setup |
| `headroom proxy --port 8787` | Standalone local proxy |
| `headroom mcp` | Run MCP server |
| `headroom stats` | View compression statistics |

## Python library (inline compression)

```python
from headroom import compress

compressed = compress(large_tool_output, content_type="auto")
```

Use when building custom scripts or middleware outside the proxy.

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `headroom: command not found` | `pip install headroom-ai` |
| Cursor not routing through proxy | Re-check base URL override in Settings → Models |
| Compressed output missing detail | Use CCR retrieve; lower compression level |
| Telemetry concern | `HEADROOM_TELEMETRY=off` |

## References

- Repo: https://github.com/headroomlabs-ai/headroom
- Docs: https://headroom-docs.vercel.app/docs
- Quickstart: https://headroom-docs.vercel.app/docs/quickstart
- License: Apache-2.0
