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

## Structure

This repo contains a single file:

```
.claude-plugin/marketplace.json
```

Skills are consolidated into two plugins by category. Each uses `source.git-subdir`
to fetch the category directory from `mattpocock/skills` at `ref: main`, with
`strict: false` and `skills: ["."]` so Claude Code discovers each skill
subdirectory automatically — without requiring an upstream `plugin.json`.
