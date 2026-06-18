---
name: hello-skill
description: >-
  Sanity-check skill from the daily-skills repo. Use when verifying that
  daily-skills was installed correctly, testing symlink wiring, or when the
  user says "hello skill" or "test daily-skills".
---

# Hello Skill

You are running a skill from the **daily-skills** collection.

## When invoked

1. Confirm the skill loaded by stating: `daily-skills hello-skill OK`.
2. Report where this skill lives on disk (the resolved path to this `SKILL.md`).
3. If the user asked to test install, remind them:
   - Global install: `~/.cursor/skills/daily-hello-skill/` (Cursor) or equivalent for other agents
   - Re-install: `./install/install.sh --host cursor --scope global --skills hello-skill`
4. Keep the response under 10 lines unless the user asks for more.

## Do not

- Start unrelated implementation work
- Modify files unless the user explicitly asks to extend this skill
