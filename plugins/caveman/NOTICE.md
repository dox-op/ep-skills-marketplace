# Third-party notice — caveman

All skills in `skills/` come from [`JuliusBrussee/caveman`](https://github.com/JuliusBrussee/caveman),
Apache License 2.0, Copyright 2026 Julius Brussee. See `LICENSE`, `NOTICE` and `LICENSE-MIT`
(upstream notices, copied verbatim).

- Source: https://github.com/JuliusBrussee/caveman
- Vendored from commit `9b68f7ed12b05e7efaff18e65c5a3fc2849fd0a4` (2026-10-28).

## What is shipped

The 22 skill folders found under upstream `skills/` (every folder containing a `SKILL.md`),
copied **verbatim** with their supporting files (scripts, tests, agents/openai.yaml, README).

## Not shipped

Upstream `skills/generated/`, `skills/native/` and the build tooling in `skills/`
(`compile.mjs`, `registry.json`, ...), plus the rest of the repository (engine, proxy, CLI, ...).

## Changes vs upstream

None to the skill contents. Only packaging: the skills are placed under a `caveman`
plugin so they install namespaced as `/caveman:<skill>` from the `enricopezzini` marketplace.

## Local addition (not from upstream)

`skills/core-caveman/` is **not** part of `JuliusBrussee/caveman`: it is a personal variant of the
caveman skill (intensity levels `lite|full|ultra|wenyan-*`), kept here so it installs as
`/caveman:core-caveman`. The 22 upstream skills above remain verbatim.
