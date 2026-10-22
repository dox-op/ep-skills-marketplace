# Third-party notice — pstack

`interrogate/`, `blast-radius/` and `create-verification-skill/` are adapted from `pstack` in
https://github.com/cursor/plugins (path `pstack/skills/`), MIT License,
Copyright (c) 2026 Lauren Tan.

Adaptations: vendor-specific parts removed (`~/.cursor/rules/pstack-models.mdc`,
Task tool, Cursor model slugs, companion skills `how`/`why`/`unslop`/`arena`/
`poteto-mode`) and replaced with runtime-neutral wording (generic subagent
spawning, model tiers instead of slugs, no plugin namespace). `interrogate/references/`
and `create-verification-skill/references/` are verbatim. In `create-verification-skill`, the hardcoded `.cursor/skills/` output path became a resolved `<skills-dir>`.
