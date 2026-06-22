# daily-skills

个人/团队常用 Agent Skills 集合。一个 Git 仓库管理源码，通过 symlink 可插拔安装到各 Agent 的全局或项目目录。

## Skill 目录

安装后 symlink 名为 `daily-<id>`（如 `daily-brainstorming`）。

| ID | 作用 | 来源 | License | 依赖 |
|----|------|------|---------|------|
| [brainstorming](skills/brainstorming/) | 实现前先澄清需求、提出方案、写设计 doc；**禁止**未经批准写代码 | [obra/superpowers](https://github.com/obra/superpowers) `skills/brainstorming` | MIT | — |
| [create-skill](skills/create-skill/) | 创建/优化 Agent Skill（`SKILL.md` 结构、frontmatter、触发词） | Cursor 内置 `skills-cursor/create-skill` | Cursor 内置 | — |
| [caveman](skills/caveman/) | 极简沟通模式，压缩 token（lite / full / ultra / 文言文） | [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | MIT | — |
| [frontend-design](skills/frontend-design/) | 构建/重塑 UI 的视觉设计指导，强调辨识度，避免模板化审美 | [anthropics/skills](https://github.com/anthropics/skills) `skills/frontend-design` | Apache-2.0 | — |
| [headroom](skills/headroom/) | 压缩 tool output / 日志 / 文件上下文，节省 60–95% token；Cursor 集成与 MCP | [headroomlabs-ai/headroom](https://github.com/headroomlabs-ai/headroom)（curated skill） | Apache-2.0 | **headroom-ai** CLI |
| [office-hours](skills/office-hours/) | YC Office Hours 产品诊断：六个 forcing questions，输出设计文档 | [garrytan/gstack](https://github.com/garrytan/gstack) `office-hours` | MIT | **gstack** |

每个 skill 目录下的 `SOURCE.md` 记录上游路径、同步日期和注意事项。

### 触发示例

| Skill | 怎么说 |
|-------|--------|
| brainstorming | 「先 brainstorm 一下这个功能」「写代码前先设计」 |
| create-skill | 「帮我写一个 skill」「SKILL.md 怎么写」 |
| caveman | 「caveman mode」「少说点 token」 |
| frontend-design | 「帮我设计这个页面」「不要 AI slop 审美」 |
| headroom | 「用 headroom 压缩上下文」「token 太多了」 |
| office-hours | 「office hours」「帮我想想这个产品值不值得做」 |

## 项目级 Skills（外部引用）

以下 skills **不在本仓库注册**，适合按项目 clone 或 symlink 到目标仓库的 Agent 项目目录（如 `.cursor/skills/`）。详细用法见各仓库 README。

| 作用 | 链接 |
|------|------|
| 整理并精读论文（论文入库、逻辑链精读等） | [paper-with-code-skills](https://github.com/Gojay001/paper-with-code-skills) |

## 快速开始

```bash
# 检查仓库
./install/install.sh doctor

# 列出已登记 skills
./install/install.sh list

# 安装全部到 Cursor 全局
./install/install.sh --host cursor --scope global --all

# 只装 planning 相关
./install/install.sh --host cursor --scope global --skills brainstorming,office-hours

# 安装到某个项目的 .cursor/skills/
./install/install.sh --host cursor --scope project --path /path/to/your-repo --all
```

## 支持的 Agent

| Agent | `--host` | 全局目录 | 项目目录 |
|-------|----------|----------|----------|
| Cursor | `cursor` | `~/.cursor/skills/` | `.cursor/skills/` |
| Claude Code | `claude` | `~/.claude/skills/` | `.claude/skills/` |
| Codex | `codex` | `~/.codex/skills/` | `.agents/skills/` |
| OpenCode | `opencode` | `~/.config/opencode/skills/` | `.opencode/skills/` |

## 添加 / 同步 skill

1. 将上游 `SKILL.md` 放入 `skills/<id>/`，并写 `SOURCE.md` 记录来源
2. 在 `manifest.yaml` 登记（含 `summary`、`source`、`tags`）
3. 更新本 README 的 Skill 目录表
4. `./install/install.sh doctor`
5. `./install/install.sh --host cursor --scope global --skills <id>`

## 卸载

```bash
./install/install.sh uninstall --host cursor --scope global --all
```

## 目录结构

```
daily-skills/
├── manifest.yaml       # skill 注册表（含来源元数据）
├── skills/
│   └── <id>/
│       ├── SKILL.md
│       └── SOURCE.md   # 上游来源与同步说明
├── install/
│   ├── install.sh
│   └── hosts.yaml
└── README.md
```
