---
name: reflect
description: Spawn three parallel review subagents over the active transcript, surface learnings, and route each to a concrete edit on an existing skill. Use when the user says reflect.
disable-model-invocation: true
---

# Reflect

Mine the current conversation for durable learnings, then route them into skill edits.

Invoke when the user says "reflect" or "/reflect". Skip when the conversation is trivial, off-topic, or already covered by an existing skill the parent followed correctly. One-offs are not learnings.

## 1. Locate the active transcript

Before fanning out, find this conversation's transcript in the current session's transcript store, in the directory the runtime or system prompt names for the active workspace. Never glob across workspaces. That crosses workspace boundaries and reads private chats from unrelated projects.

```bash
ls -t <transcript-store>/* <transcript-store>/*/* <transcript-store>/*/subagents/* 2>/dev/null | head -10
```

List by real modification time, newest first. Layouts differ by runtime: a flat file per chat (`<id>.jsonl`), a nested folder per session (`<id>/<id>.jsonl`), or subagent chats in subfolders are all examples. Adjust the globs to what the store actually contains. For each candidate, read its first lines to learn the schema (JSONL with one event per line is typical, but confirm). Take the file whose first user message contains the conversation's opening user prompt. If none matches, pass a tight digest of the session instead.

## 2. Spawn three reviewers in parallel

One message, three general-purpose subagents spawned with the runtime's subagent mechanism, in writable (not read-only) mode. Reviewers need MCP access to look up the tickets, chat threads, and observability traces the transcript references, and read-only mode can strip MCPs.

Each reviewer and the synthesizer name a role line in the `pstack models` section of the user's or project's agent instructions (written by `setup-pstack`) and a default tier. Set the subagent's model to that line's tier, or to the default if the section or the line is missing. Omit the model override when the value is `inherit`, so the subagent runs on the parent model. If the runtime rejects the chosen model, use the default tier and say so. If it rejects the default, use the closest valid model of the same tier from its error message. If the runtime cannot choose models, every role runs on the parent model. Pick each subagent's reasoning level and fast or standard speed for the job, per the Subagents section of the **poteto-mode** skill.

| Lens | Role line | Default tier | Prompt template |
|---|---|---|---|
| Judgment | `reflect judgment, divergent, synthesizer` | `strongest` | `references/judgment-reviewer.md` |
| Tooling | `reflect tooling` | `fast` (prefer a different model family than `strongest`) | `references/tooling-reviewer.md` |
| Divergent | `reflect judgment, divergent, synthesizer` | `strongest` | `references/divergent-reviewer.md` |

Pass each template verbatim, substituting the transcript path or digest where marked. Reviewers return findings in the subagent's response body.

## 3. Synthesize

One general-purpose subagent, model tier from the `reflect judgment, divergent, synthesizer` line (default `strongest`), in writable (not read-only) mode. It spot-verifies citations through MCP, and read-only mode can strip MCPs. Pass `references/synthesizer.md` verbatim, with each reviewer's full output inlined where marked. It returns an Accepted / Rejected / Backlog list.

## 4. Structural enforcement check

Move any Accepted item that a lint rule, script, metadata flag, or runtime check would enforce more reliably to Backlog. See the **encode-lessons-in-structure** principle skill.

## 5. Apply

Present the synthesizer's full Accepted / Rejected / Backlog output and wait for explicit approval before applying any Accepted edit. The user picks the subset and may redirect routings. Skill changes affect every future agent in the org. Do not auto-apply.

File each Backlog item to your team's devex or backlog tracker without waiting. Only the Accepted list waits for approval.

Follow each approved row's Routing exactly:

- Trivial existing-skill edit (a one-line bullet, a tightened sentence, a stale fact corrected): the parent does it directly.
- Substantive existing-skill edit (a new section, a new pattern table, more than ~10 lines): hand to the runtime's skill-authoring skill if it has one, otherwise follow the Agent Skills format (SKILL.md with name + description frontmatter) directly, and run a draft / test / iterate loop.
- `tune description: <skill path>` (the skill exists but didn't trigger when it should have): hand to the same skill-authoring path and run a description-optimization loop.
- `new skill via skill-authoring: <kebab-name>`: hand creation to the same skill-authoring path. Do not invent the shape ad hoc.

If your environment ships a SKILL.md validator, run it on every touched skill before declaring done.

## 6. Summarize for the user

Short list, no preamble:

- Edits applied: `<skill path>`. What changed, one line each.
- New skills created: `<skill path>`. One line each (rare).
- Backlog filed to the devex tracker: `<issue title>` (`<tags>`). One line each.
- Dropped: one line per rejected finding + reason from the synthesizer.
