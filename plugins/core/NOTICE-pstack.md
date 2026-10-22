# Third-party notice — pstack

`interrogate/` and `blast-radius/` are adapted from `pstack` in
https://github.com/cursor/plugins (path `pstack/skills/`), MIT License,
Copyright (c) 2026 Lauren Tan.

Adaptations: vendor-specific parts removed (`~/.cursor/rules/pstack-models.mdc`,
Task tool, Cursor model slugs, companion skills `how`/`why`/`unslop`/`arena`/
`poteto-mode`) and replaced with runtime-neutral wording (generic subagent
spawning, model tiers instead of slugs, no plugin namespace). `interrogate/references/`
is verbatim.
