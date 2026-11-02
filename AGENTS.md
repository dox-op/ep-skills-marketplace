# AGENTS.md

Guidance for AI coding agents working in this repository (agent-agnostic).

## What this repo is

A **plugin marketplace** for agent skills (Claude Code plugin format) (name `enricopezzini`, remote `dox-op/ep-skills-marketplace`), not an application: no build, no tests. Content is Markdown skills plus JSON manifests. The README (in Italian) documents install/update flows; keep docs and commit messages in Italian.

## Commands

```bash
./scripts/check-duplicates.sh      # only check: fails if two SKILL.md in the SAME plugin share a `name:`
./scripts/update-local.sh [marketplace] [plugin]   # git pull + marketplace update + reinstall (PowerShell twin: update-local.ps1)
claude plugin marketplace add "<repo path>"        # test locally without pushing
```

`gh` may not be on PATH in agent shells: use `"/c/Program Files/GitHub CLI/gh.exe"`.

## Architecture

- `.claude-plugin/marketplace.json` lists every plugin with a relative `source` (`./plugins/<name>`). **Adding a plugin = new folder under `plugins/` AND an entry in this file**, otherwise it is not installable.
- Each plugin: `plugins/<name>/.claude-plugin/plugin.json` + `skills/<skill>/SKILL.md`. Start new ones from `plugins/skill-template/`.
- Skills are namespaced by plugin: `/<plugin>:<skill>`. The same skill name in different plugins is intentional (`/pstack:tdd` vs `/mattpocock:tdd`); duplicates within one plugin are not. There is deliberately no generic `core` plugin: a plugin name must describe its contents (a personal skill gets its own plugin, e.g. `llm-council`, or lives in a themed one, e.g. `core-caveman` in `caveman`).
- `plugin.json` omits `version` on purpose: every commit is a new version via git SHA. If a version is ever added, it must be bumped each release or accounts see "already up to date".
- Install skills only as plugins, never copied into flat `.claude/skills/` dirs (the prefix would be lost).

## Third-party plugins (`pstack`, `mattpocock`, `caveman`)

Vendored from upstream repos (MIT / Apache-2.0), with `LICENSE`/`NOTICE.md` recording source commit and changes. `mattpocock` and `caveman` are copied **verbatim**; `pstack` is rewritten to be runtime-agnostic. Don't edit vendored skills casually: record any deviation from upstream in the plugin's `NOTICE.md`. Personal additions to them (e.g. `caveman/skills/core-caveman`) are the exception to "verbatim" and are noted there.

## Gotchas

- `plugin/` at the repo root is git-ignored leftover (empty dirs); the real plugins are in `plugins/`.
- `claude` CLI calls in scripts must run with stdin closed (`< /dev/null`), otherwise they hang and fail with a misleading "Not logged in".
- `README.md` lists plugin/skill counts and the repo tree by hand: update it when plugins change.
