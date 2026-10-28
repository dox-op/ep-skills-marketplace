# Third-party notice — mattpocock

All skills in `skills/` come from [`mattpocock/skills`](https://github.com/mattpocock/skills),
MIT License, Copyright (c) 2026 Matt Pocock. See `LICENSE`.

- Source: https://github.com/mattpocock/skills
- Upstream version: `1.3.1`
- Vendored from commit `59db609eb1e18aaf59b63284d0e52255aff0c63c` (2026-10-27).

## What is shipped

The 27 official skills listed in the upstream plugin manifest, copied **verbatim**
(including their supporting files: `agents/openai.yaml`, scripts and reference `.md`):

- **engineering** (20): `ask-matt`, `code-review`, `codebase-design`, `diagnosing-bugs`,
  `domain-modeling`, `grill-with-docs`, `implement`, `implement-spec`,
  `improve-codebase-architecture`, `pr`, `prototype`, `research`, `retro`,
  `setup-matt-pocock-skills`, `tdd`, `to-spec`, `to-tickets`, `triage`, `wayfinder`, `wizard`
- **productivity** (7): `grill-me`, `grilling`, `handoff`, `teach`, `to-questionnaire`,
  `wait-what`, `writing-for-agents`

## Not shipped

The upstream `skills/deprecated/`, `skills/in-progress/`, `skills/misc/` buckets and the
repository-level tooling (`docs/`, `scripts/`, `.changeset/`, `package.json`) are not
included — only the released engineering and productivity skills.

## Changes vs upstream

None to the skill contents. Only packaging: the skills are placed under a `mattpocock`
plugin so they install namespaced as `/mattpocock:<skill>` from the `enricopezzini`
marketplace, with an explicit `skills` array in `.claude-plugin/plugin.json`.
