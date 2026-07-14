# daily-skills

个人/团队常用 Agent Skills 集合。一个 Git 仓库管理源码，通过 symlink 可插拔安装到各 Agent 的全局或项目目录。

## Skill 目录

安装后 symlink 名为 `daily-<id>`（如 `daily-brainstorming`）。

| ID | 作用 | 来源 | License | 依赖 |
|----|------|------|---------|------|
| [agent-reach](skills/agent-reach/) | 给 Agent 互联网能力：搜/读 Twitter、Reddit、YouTube、GitHub、B站、小红书等 | [Panniantong/agent-reach](https://github.com/Panniantong/agent-reach) `agent_reach/skill` | MIT | **agent-reach** CLI |
| [brainstorming](skills/brainstorming/) | 实现前先澄清需求、提出方案、写设计 doc；**禁止**未经批准写代码 | [obra/superpowers](https://github.com/obra/superpowers) `skills/brainstorming` | MIT | — |
| [create-skill](skills/create-skill/) | 创建/优化 Agent Skill（`SKILL.md` 结构、frontmatter、触发词） | Cursor 内置 `skills-cursor/create-skill` | Cursor 内置 | — |
| [caveman](skills/caveman/) | 极简沟通模式，压缩 token（lite / full / ultra / 文言文） | [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | MIT | — |
| [fireworks-tech-graph](skills/fireworks-tech-graph/) | 自然语言 → 技术架构图 SVG+PNG（8 风格 / 14 图类型 / UML） | [yizhiyanhua-ai/fireworks-tech-graph](https://github.com/yizhiyanhua-ai/fireworks-tech-graph) | MIT | **cairosvg**（推荐） |
| [frontend-design](skills/frontend-design/) | 构建/重塑 UI 的视觉设计指导，强调辨识度，避免模板化审美 | [anthropics/skills](https://github.com/anthropics/skills) `skills/frontend-design` | Apache-2.0 | — |
| [headroom](skills/headroom/) | 压缩 tool output / 日志 / 文件上下文，节省 60–95% token；Cursor 集成与 MCP | [headroomlabs-ai/headroom](https://github.com/headroomlabs-ai/headroom)（curated skill） | Apache-2.0 | **headroom-ai** CLI |
| [office-hours](skills/office-hours/) | YC Office Hours 产品诊断：六个 forcing questions，输出设计文档 | [garrytan/gstack](https://github.com/garrytan/gstack) `office-hours` | MIT | **gstack** |
| [writing-plans](skills/writing-plans/) | 有 spec 后、写代码前，产出 bite-sized 实现计划（TDD、逐步 commit） | [obra/superpowers](https://github.com/obra/superpowers) `skills/writing-plans` | MIT | — |

每个 skill 目录下的 `SOURCE.md` 记录上游路径、同步日期和注意事项。

### 触发示例

| Skill | 怎么说 |
|-------|--------|
| agent-reach | 「帮我调研一下 X」「搜搜推特/小红书上大家怎么说」 |
| brainstorming | 「先 brainstorm 一下这个功能」「写代码前先设计」 |
| create-skill | 「帮我写一个 skill」「SKILL.md 怎么写」 |
| caveman | 「caveman mode」「少说点 token」 |
| fireworks-tech-graph | 「画个架构图」「生成 Mem0 记忆系统图」 |
| frontend-design | 「帮我设计这个页面」「不要 AI slop 审美」 |
| headroom | 「用 headroom 压缩上下文」「token 太多了」 |
| office-hours | 「office hours」「帮我想想这个产品值不值得做」 |
| writing-plans | 「写实现计划」「spec 有了，帮我拆任务」 |

## Addy Osmani Agent Skills

生产级工程技能包（24 个），覆盖 DEFINE → PLAN → BUILD → VERIFY → REVIEW → SHIP。

| 来源 | License |
|------|---------|
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | MIT |

安装后 symlink 为 `daily-<id>`。装全部：

```bash
./install/install.sh --host cursor --scope global --skills api-and-interface-design,browser-testing-with-devtools,ci-cd-and-automation,code-review-and-quality,code-simplification,context-engineering,debugging-and-error-recovery,deprecation-and-migration,documentation-and-adrs,doubt-driven-development,frontend-ui-engineering,git-workflow-and-versioning,idea-refine,incremental-implementation,interview-me,observability-and-instrumentation,performance-optimization,planning-and-task-breakdown,security-and-hardening,shipping-and-launch,source-driven-development,spec-driven-development,test-driven-development,using-agent-skills
```

| ID | 作用 |
|----|------|
| [api-and-interface-design](skills/api-and-interface-design/) | Guides stable API and interface design |
| [browser-testing-with-devtools](skills/browser-testing-with-devtools/) | Tests in real browsers via Chrome DevTools MCP |
| [ci-cd-and-automation](skills/ci-cd-and-automation/) | Automates CI/CD pipeline setup |
| [code-review-and-quality](skills/code-review-and-quality/) | Conducts multi-axis code review |
| [code-simplification](skills/code-simplification/) | Simplifies code for clarity |
| [context-engineering](skills/context-engineering/) | Optimizes agent context setup |
| [debugging-and-error-recovery](skills/debugging-and-error-recovery/) | Guides systematic root-cause debugging |
| [deprecation-and-migration](skills/deprecation-and-migration/) | Manages deprecation and migration |
| [documentation-and-adrs](skills/documentation-and-adrs/) | Records decisions and documentation |
| [doubt-driven-development](skills/doubt-driven-development/) | Subjects every non-trivial decision to a fresh-context adversarial rev... |
| [frontend-ui-engineering](skills/frontend-ui-engineering/) | Builds production-quality, accessible, responsive user-facing UIs |
| [git-workflow-and-versioning](skills/git-workflow-and-versioning/) | Structures git workflow practices |
| [idea-refine](skills/idea-refine/) | Refines raw ideas into sharp, actionable concepts through structured d... |
| [incremental-implementation](skills/incremental-implementation/) | Delivers changes incrementally |
| [interview-me](skills/interview-me/) | Extracts what the user actually wants instead of what they think they ... |
| [observability-and-instrumentation](skills/observability-and-instrumentation/) | Instruments code so production behavior is visible and diagnosable |
| [performance-optimization](skills/performance-optimization/) | Optimizes application performance across frontend, backend, queries, a... |
| [planning-and-task-breakdown](skills/planning-and-task-breakdown/) | Breaks work into ordered tasks |
| [security-and-hardening](skills/security-and-hardening/) | Hardens code against vulnerabilities |
| [shipping-and-launch](skills/shipping-and-launch/) | Prepares production launches |
| [source-driven-development](skills/source-driven-development/) | Grounds every implementation decision in official documentation |
| [spec-driven-development](skills/spec-driven-development/) | Creates specs before coding |
| [test-driven-development](skills/test-driven-development/) | Drives development with tests |
| [using-agent-skills](skills/using-agent-skills/) | Discovers and invokes agent skills |

## ARIS Research Skills

科研自动化技能包（[ARIS](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep)，80 个 canonical skills）。覆盖 idea → experiment → paper → review。

| 来源 | License | 说明 |
|------|---------|------|
| [wanshuiyin/Auto-claude-code-research-in-sleep](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep) | MIT | 另含 `skills/shared-references/`（共享契约，非独立 skill） |

Cursor 适配见上游 [docs/CURSOR_ADAPTATION.md](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep/blob/main/docs/CURSOR_ADAPTATION.md)。完整目录：[docs/SKILLS_CATALOG.md](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep/blob/main/docs/SKILLS_CATALOG.md)。

常用入口：`research-pipeline`、`idea-discovery`、`experiment-bridge`、`paper-write`、`auto-review-loop`。

| ID | 作用 |
|----|------|
| [ablation-planner](skills/ablation-planner/) | Use when main results pass result-to-claim (claim_supported=yes or ... |
| [alphaxiv](skills/alphaxiv/) | Quick single-paper lookup via AlphaXiv LLM-optimized summaries with... |
| [analyze-results](skills/analyze-results/) | Analyze ML experiment results, compute statistics, generate compari... |
| [arxiv](skills/arxiv/) | Search, download, and summarize academic papers from arXiv |
| [auto-paper-improvement-loop](skills/auto-paper-improvement-loop/) | Autonomously improve a generated paper via GPT-5 |
| [auto-review-loop](skills/auto-review-loop/) | Autonomous multi-round research review loop |
| [auto-review-loop-llm](skills/auto-review-loop-llm/) | Autonomous research review loop using any OpenAI-compatible LLM API |
| [auto-review-loop-minimax](skills/auto-review-loop-minimax/) | Autonomous multi-round research review loop using MiniMax API |
| [citation-audit](skills/citation-audit/) | Zero-context verification that every bibliographic entry in the pap... |
| [claims-drafting](skills/claims-drafting/) | Draft patent claims for an invention |
| [comm-lit-review](skills/comm-lit-review/) | Communications-domain literature review with Claude-style knowledge... |
| [deepxiv](skills/deepxiv/) | Search and progressively read open-access academic papers through D... |
| [dse-loop](skills/dse-loop/) | Autonomous design space exploration loop for computer architecture ... |
| [embodiment-description](skills/embodiment-description/) | Write detailed embodiment descriptions for patent specifications |
| [exa-search](skills/exa-search/) | AI-powered web search via Exa with content extraction |
| [experiment-audit](skills/experiment-audit/) | Audit experiment integrity before claiming results |
| [experiment-bridge](skills/experiment-bridge/) | Workflow 1 |
| [experiment-plan](skills/experiment-plan/) | Turn a refined research proposal or method idea into a detailed, cl... |
| [experiment-queue](skills/experiment-queue/) | SSH job queue for multi-seed/multi-config ML experiments with OOM-a... |
| [feishu-notify](skills/feishu-notify/) | Send notifications to Feishu/Lark |
| [figure-description](skills/figure-description/) | Process user-provided patent figures and generate formal drawing de... |
| [figure-spec](skills/figure-spec/) | Generate deterministic publication-quality architecture, workflow, ... |
| [formula-derivation](skills/formula-derivation/) | Structures and derives research formulas when the user wants to 推导公... |
| [gemini-search](skills/gemini-search/) | Search research papers via Gemini for broad literature discovery |
| [grant-proposal](skills/grant-proposal/) | Draft a structured grant proposal from research ideas and literature |
| [idea-creator](skills/idea-creator/) | Generate and rank research ideas given a broad direction |
| [idea-discovery](skills/idea-discovery/) | Workflow 1: Full idea discovery pipeline to go from a broad researc... |
| [idea-discovery-robot](skills/idea-discovery-robot/) | Workflow 1 adaptation for robotics and embodied AI |
| [integrity-forensics](skills/integrity-forensics/) | Run the Anti-Autoresearch integrity-forensics sweep (span-anchored ... |
| [interview-cheatsheet](skills/interview-cheatsheet/) | Generate a long-form Chinese interview-prep cheat sheet on a specif... |
| [invention-structuring](skills/invention-structuring/) | Structure a raw invention idea into a formal invention disclosure |
| [jurisdiction-format](skills/jurisdiction-format/) | Compile patent application into jurisdiction-specific filing format |
| [kill-argument](skills/kill-argument/) | Two-thread adversarial review: a fresh reviewer constructs the stro... |
| [mermaid-diagram](skills/mermaid-diagram/) | Generate Mermaid diagrams from user requirements |
| [meta-apply](skills/meta-apply/) | Privileged applier that LANDS meta-optimize / corpus-audit patches ... |
| [meta-optimize](skills/meta-optimize/) | Analyze ARIS usage logs and propose optimizations to SKILL |
| [monitor-experiment](skills/monitor-experiment/) | Monitor running experiments, check progress, collect results |
| [novelty-check](skills/novelty-check/) | Verify research idea novelty against recent literature |
| [openalex](skills/openalex/) | Search academic papers via OpenAlex API for open citation data, ins... |
| [overleaf-sync](skills/overleaf-sync/) | Two-way sync between a local paper directory and an Overleaf projec... |
| [paper-claim-audit](skills/paper-claim-audit/) | Zero-context verification that every number, comparison, and scope ... |
| [paper-compile](skills/paper-compile/) | Compile LaTeX paper to PDF, fix errors, and verify output |
| [paper-figure](skills/paper-figure/) | Generate publication-quality figures and tables from experiment res... |
| [paper-illustration](skills/paper-illustration/) | Generate publication-quality AI illustrations for academic papers u... |
| [paper-illustration-image2](skills/paper-illustration-image2/) | Generate publication-quality academic illustrations through a local... |
| [paper-plan](skills/paper-plan/) | Generate a structured paper outline from review conclusions and exp... |
| [paper-poster](skills/paper-poster/) | DEPRECATED — superseded by /paper-poster-html |
| [paper-poster-html](skills/paper-poster-html/) | DEFAULT poster pipeline — build an academic conference poster (ICML... |
| [paper-slides](skills/paper-slides/) | Generate conference presentation slides (beamer LaTeX → PDF + edita... |
| [paper-talk](skills/paper-talk/) | End-to-end conference talk pipeline: paper → slide outline → Beamer... |
| [paper-write](skills/paper-write/) | Draft LaTeX paper section by section from an outline |
| [paper-writing](skills/paper-writing/) | Workflow 3: Full paper writing pipeline that goes from a narrative ... |
| [patent-novelty-check](skills/patent-novelty-check/) | Assess patent novelty and non-obviousness against prior art |
| [patent-pipeline](skills/patent-pipeline/) | Full patent drafting pipeline from invention description to jurisdi... |
| [patent-review](skills/patent-review/) | Get an external patent examiner review of a patent application |
| [pixel-art](skills/pixel-art/) | Generate pixel art SVG illustrations for READMEs, docs, or slides |
| [prior-art-search](skills/prior-art-search/) | Search patent databases and academic literature for prior art relev... |
| [proof-checker](skills/proof-checker/) | Rigorous mathematical proof verification and fixing workflow |
| [proof-writer](skills/proof-writer/) | Writes rigorous mathematical proofs for ML/AI theory |
| [qzcli](skills/qzcli/) | Manage GPU compute jobs on the Qizhi (启智) platform using qzcli — a ... |
| [rebuttal](skills/rebuttal/) | Workflow 4: Submission rebuttal pipeline |
| [render-html](skills/render-html/) | Render an ARIS Markdown / JSON artifact (IDEA_REPORT, AUTO_REVIEW, ... |
| [research-lit](skills/research-lit/) | Search and analyze research papers, find related work, summarize ke... |
| [research-pipeline](skills/research-pipeline/) | Full end-to-end research pipeline: from a broad research direction ... |
| [research-refine](skills/research-refine/) | Turn a vague research direction into a problem-anchored, elegant, f... |
| [research-refine-pipeline](skills/research-refine-pipeline/) | Run an end-to-end workflow that chains `research-refine` and `exper... |
| [research-review](skills/research-review/) | Get a deep critical review of research from an external reviewer ba... |
| [research-wiki](skills/research-wiki/) | Persistent research knowledge base that accumulates papers, ideas, ... |
| [resubmit-pipeline](skills/resubmit-pipeline/) | Workflow 5: orchestrate a text-only resubmit of a polished paper to... |
| [result-to-claim](skills/result-to-claim/) | Use when experiments complete to judge what claims the results supp... |
| [run-experiment](skills/run-experiment/) | Deploy and run ML experiments on local, remote, Vast |
| [semantic-scholar](skills/semantic-scholar/) | Search published venue papers (IEEE, ACM, Springer, etc |
| [serverless-modal](skills/serverless-modal/) | Run GPU workloads on Modal — training, fine-tuning, inference, batc... |
| [slides-polish](skills/slides-polish/) | Per-page Codex review + targeted python-pptx / Beamer fixes for aca... |
| [specification-writing](skills/specification-writing/) | Write the full patent specification from claims and invention discl... |
| [system-profile](skills/system-profile/) | Profile a target (script, process, GPU, memory, interconnect) for p... |
| [training-check](skills/training-check/) | Periodically check WandB metrics during training to catch problems ... |
| [vast-gpu](skills/vast-gpu/) | Rent, manage, and destroy GPU instances on vast |
| [wiki-enrich](skills/wiki-enrich/) | Fill in the per-paper TODO sections of research-wiki/papers/<slug> |
| [writing-systems-papers](skills/writing-systems-papers/) | Paragraph-level structural blueprint for 10-12 page systems papers ... |

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
