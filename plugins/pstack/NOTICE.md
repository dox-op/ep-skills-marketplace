# Third-party notice — pstack

All skills in `skills/` come from `pstack` in https://github.com/cursor/plugins
(path `pstack/skills/`), MIT License, Copyright (c) 2026 Lauren Tan. See `LICENSE`.

Adaptations (vendor-neutral rewrite, no behavior change intended):
- model slugs and the Cursor-only `~/.cursor/rules/pstack-models.mdc` replaced by tiers
  (`strongest`, `fast`, `inherit`) read from a `pstack models` section in the agent instructions;
- Task-tool / `generalPurpose` wording replaced by generic subagent wording;
- hardcoded `.cursor/` and `~/.cursor/` paths replaced by `<skills-dir>` / runtime-neutral transcript discovery;
- Cursor built-ins and `cursor-team-kit` skills replaced by "equivalent skill if installed";
- companion `agents/` and `docs/` of upstream are not shipped; links point to the upstream repository.

Verbatim: the `references/` of `interrogate` and `create-verification-skill`, and the principle/typed skills
that had no vendor reference.
