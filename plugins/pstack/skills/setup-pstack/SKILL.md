---
name: setup-pstack
description: Configure which models pstack uses per role and at what reasoning budget. Detects the models your runtime lets a subagent use and writes a `pstack models` section into your agent instructions that overrides the skill defaults. Use for /setup-pstack, "configure pstack models", "pstack budget", or changing pstack's model choices.
---

# Setup pstack

Write or update a `## pstack models` section in the user's or project's agent instructions, which sets pstack's model per role. Roles use tiers, not model slugs: `strongest` (the most capable model, for judgment and prose), `fast` (a quick, cheaper model, for tooling and bulk work; prefer a different model family than `strongest`), and `inherit` (omit the model override so the subagent runs on the parent model).

If the runtime cannot choose a model per subagent, every role runs on the parent model. Say so, write every role as `inherit`, and skip the model questions.

## Steps

### 1. Detect available models

Enumerate the models you can pass to a subagent in this session, using the runtime's subagent mechanism. That is the dependable source. If the runtime also exposes a models API or CLI that lists the user's entitled models, prefer it for completeness. If you cannot detect any, ask the user to name the models they have access to. Never assign a model you have not confirmed is available. The tier `inherit` is always valid even though it is not a detected model.

### 2. Locate the target and load current state

Decide where the section lives. Ask the user which they want when unclear: user-level or project-level. Typical targets are the project's `AGENTS.md`, the runtime's rules or instructions file, or the user-level instructions file. If a `## pstack models` section already exists in one of them, read it, update it in place, and treat its `budget` line and its role values as the current choices. Otherwise start from the defaults in the shape shown in step 5 below. A line whose role is not in step 5, such as `how critics`, is from a retired role. Drop it.

### 3. Budget, map, and confirm

**(a) Ask for a budget.** Prefer the runtime's structured question tool over free text. Offer these four options with these exact labels, and name the current budget when the section records one. With no section, say that `large` matches the skill defaults.

- `unlimited — max reasoning`
- `large — xhigh reasoning`
- `medium — high reasoning`
- `small — medium reasoning`

**(b) Apply it.** Build the working table from the skill defaults, and on a re-run keep any role you changed to a different tier, a specific model, or a list. The budget sets the reasoning-effort target (`max`, `xhigh`, `high`, or `medium`) that pstack asks for on each subagent, panel entries included. The effort ladder is `max` > `xhigh` > `high` > `medium` > `low`. If the runtime exposes effort as a model variant or a spawn parameter, use the detected setting with the highest effort at or below the target. If the runtime has no effort control, record the budget anyway and apply it only where the runtime allows. `inherit` does not change. Resolve each tier to a detected model: `strongest` is the most capable detected model, and `fast` is a fast detected model, preferably from a different family. If no suitable model is detected for a tier, mark the role as needing a choice.

**(c) Show the roles and confirm.** Show every role with its tier and the model it resolves to, marking any role whose tier has no detected model as needing a choice. Also list each line step 2 dropped. Ask whether to accept as-is or change specific roles, offering the detected models plus `inherit` (the role runs on the parent model) as the options. Prefer the runtime's structured question tool over free text. For panel roles (arena runners, architect runners, interrogate reviewers) the value is a list, and one subagent runs per entry, `inherit` entries included, so the list length sets the count. `arena cross-judge pool` is also a list, but Arena selects one value from it whose model family differs from the parent's when possible. `swarm workers` is the default model for every worker unless a race or comparison assigns another model per arm.

### 4. Validate

Every model written must be in the detected set. `inherit` always passes. If a chosen model is not available, stop and ask again.

### 5. Write the section

Write the `## pstack models` section into the target file, with a `budget` line carrying the chosen label and its target effort, and one line per role, using the same labels poteto-mode uses. Replace only that section and leave the rest of the file untouched, so re-runs stay idempotent. If the file does not exist, create it with just this section. Shape:

```
## pstack models

pstack per-role model choices (overrides skill defaults). One line per role. Delete a line to fall back to the skill default.
Tiers: `strongest`, `fast`, or `inherit` (omit the model override; the role runs on the parent model). A model name is allowed when you want a specific model. `inherit` entries in a panel list still count toward its fan-out.

budget: large (xhigh)
feature, refactoring: fast
bug-fix: fast
perf-issue: fast
hillclimb: fast
judgment and prose: strongest
hardest tasks: strongest
how explorer: fast
how explainer: strongest
why investigators: fast
why synthesizer: strongest
reflect tooling: fast
reflect judgment, divergent, synthesizer: strongest
arena runners: strongest, fast
arena cross-judge pool: strongest, fast
swarm workers: fast
architect runners: strongest, fast
interrogate reviewers: strongest, fast
```

### 6. Confirm

Tell the user the rule was written and that it applies to new sessions. Re-running this skill updates it.

### 7. Offer a verification skill (optional)

Check whether the project has a way to drive the real app for proof (a `verify-*` skill, or an existing harness). If not, offer once: "want a project-local verification skill, so agents can drive the app the way a user does and prove changes work? I can generate one with /create-verification-skill." On yes, invoke `/create-verification-skill` (resolves wherever pstack is installed: workspace, user, or plugin). On no, move on without pushing.

### 8. Offer a formal verification skill (optional)

Check whether the project already has a formal verification skill (a project skill that runs a model checker, a proof, or another verifier against the code). If not, offer once: "want a formal verification skill, so agents can prove a key property of your code holds in every case in scope, not only the cases tests reach? I can generate one with /create-formal-verification-skill." On yes, invoke `/create-formal-verification-skill` (resolves wherever pstack is installed: workspace, user, or plugin). On no, move on without pushing.
