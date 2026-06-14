# Contributing

Thanks for wanting to add a skill. The bar for this repo is high on purpose — these skills tell people whether their work is good, so the skills themselves have to be good.

## What makes a skill belong here

A skill is a fit if it answers a clear quality question about an AI-agent / LLM-app repo and meets all four:

1. **Repo-aware** — it reads the actual code and cites `file:line`. It never gives generic advice that would read the same for any repo.
2. **Scored** — it ends in a 0–100 score, a letter grade, and a one-line verdict, using the shared rubric in [`CONVENTIONS.md`](CONVENTIONS.md).
3. **Self-contained** — everything it needs is inside its own folder, so it still works after being copied into `.claude/skills/`. Do not rely on relative paths to repo-root files at runtime.
4. **Opinionated** — it makes calls, ranks fixes, names trade-offs, and is willing to say "remove this."

## Skill anatomy

```
skills/<skill-name>/
  SKILL.md            # required: YAML frontmatter + instructions
  references/         # optional: long checklists kept out of SKILL.md
```

`SKILL.md` frontmatter:

```yaml
---
name: skill-name                 # lowercase-hyphenated, matches the folder
description: Use when ...         # one or two sentences; this is how Claude auto-discovers it. Lead with WHEN to use it.
allowed-tools: Read, Grep, Glob, Bash, Write   # keep review skills read-oriented
---
```

The body should, in order: state the role/persona, inline the shared protocol (plan-first + `auto`, evidence rule, severity, scoring, report format), list **what to inspect in the repo** (concrete file globs / patterns), give the evaluation lenses or checklist, define the **scoring dimensions and weights**, and show the **output format**.

Keep `SKILL.md` scannable. Move exhaustive checklists into `references/` and point to them.

## Style

- Concrete over abstract. "Cache the system prompt with `cache_control`" beats "consider caching."
- Beginner-readable. Explain a term the first time you use it.
- No padding. If the token-efficiency skill is verbose, that's embarrassing.

## Testing your skill

Run it against at least two real repos (one good, one rough) and confirm: the plan is short, the findings cite real `file:line`, the score moves between the two repos, and a beginner could act on the top fixes.

## PRs

Small, focused PRs. One skill (or one fix) per PR. Update the skills table in [`README.md`](README.md) when you add a skill.
