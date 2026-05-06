# mattpocock-skills marketplace

A Claude Code marketplace catalog for
[mattpocock/skills](https://github.com/mattpocock/skills).

## Why this exists

The upstream `mattpocock/skills` repo does not ship a
`.claude-plugin/marketplace.json`, which is the file Claude Code needs to
discover and install skills via its built-in marketplace UI. This is tracked in
[mattpocock/skills#21](https://github.com/mattpocock/skills/issues/21). This
repo is a thin catalog that points at the upstream skills — no skill files are
duplicated here.

Once issue #21 is resolved and the upstream repo ships its own
`marketplace.json`, this repo will be archived.

## Install

In Claude Code, run:

```
/plugin marketplace add dox-op/mattpockock-skills-marketplace
```

Then install the plugin(s) you want:

```
/plugin install mattpocock-engineering@mattpocock-skills
/plugin install mattpocock-productivity@mattpocock-skills
```

All skill content is fetched live from `mattpocock/skills` main branch.

## Available plugins

### `mattpocock-engineering`

Skills are invoked as `/mattpocock-engineering:<skill-name>`.

| Skill | Description |
|-------|-------------|
| `diagnose` | Disciplined diagnosis loop for hard bugs and performance regressions |
| `grill-with-docs` | Grilling session that challenges your plan against the existing domain model |
| `triage` | Triage issues through a state machine driven by triage roles |
| `improve-codebase-architecture` | Find deepening opportunities in a codebase |
| `setup-matt-pocock-skills` | Scaffold per-repo config before using the other engineering skills |
| `tdd` | Test-driven development with a red-green-refactor loop |
| `to-issues` | Break any plan or PRD into independently-grabbable issues |
| `to-prd` | Turn the current conversation context into a PRD |
| `zoom-out` | Get broader context or a higher-level perspective on unfamiliar code |
| `prototype` | Build a throwaway prototype to flush out a design |

### `mattpocock-productivity`

Skills are invoked as `/mattpocock-productivity:<skill-name>`.

| Skill | Description |
|-------|-------------|
| `caveman` | Ultra-compressed communication mode, cuts token usage ~75% |
| `grill-me` | Get relentlessly interviewed about a plan or design |
| `write-a-skill` | Create new skills with proper structure and bundled resources |

## Structure

This repo contains a single file:

```
.claude-plugin/marketplace.json
```

Skills are consolidated into two plugins by category. Each uses `source.git-subdir`
to fetch the category directory from `mattpocock/skills` at `ref: main`, with
`strict: false` and `skills: ["."]` so Claude Code discovers each skill
subdirectory automatically — without requiring an upstream `plugin.json`.
