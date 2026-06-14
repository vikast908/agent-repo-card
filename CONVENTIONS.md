# Shared conventions

Every skill in this repo follows the same protocol so their output is consistent, comparable, and trustworthy. The essentials are inlined into each `SKILL.md` (so skills stay self-contained when copied into `.claude/skills/`); this file is the canonical, human-readable reference.

## 1. Plan-first protocol (default)

Before doing the full review, a skill presents a **short review plan**:

- what it will inspect
- the areas it will evaluate
- the deliverables
- assumptions it is making
- any missing information it needs

Then it asks: **"Proceed with the full review, or adjust scope?"** and waits.

**Skip the gate** when the user invokes the skill with `auto`, `--auto`, `yolo`, or says "skip the plan" / "just do it". In that case, run end-to-end and produce the report immediately.

## 2. Evidence rule (non-negotiable)

Reviews are only useful if they're true. Therefore:

- Cite concrete evidence: `path/to/file.ts:42`. Quote at most ~2 lines.
- Never invent files, functions, configs, or behavior. If you can't verify a claim from the code, label it **`unverified`** and say what you'd need to confirm it.
- Distinguish "I saw this in the code" from "this is a common risk in repos like this."
- If the repo is too large to read fully, say what you sampled and what you skipped. No silent truncation.

## 3. Severity scale

| Severity | Meaning |
|---|---|
| **Critical** | Breaks core function, leaks data, blocks users, or burns money at scale. Fix before shipping. |
| **High** | Real harm to quality/cost/trust in common paths. Fix soon. |
| **Medium** | Noticeable gap or risk in edge/secondary paths. Plan a fix. |
| **Low** | Polish, nice-to-have, or stylistic. Optional. |

## 4. Scoring rubric

Each skill scores a small set of **weighted dimensions** (defined in that skill) to a **0–100 total**, then maps to a grade:

| Score | Grade | Meaning |
|---|---|---|
| 90–100 | **A** | Production-grade |
| 75–89 | **B** | Solid, minor gaps |
| 60–74 | **C** | Usable, real gaps |
| 40–59 | **D** | Significant problems |
| 0–39 | **F** | Not ready |

Scores are judgments, not measurements — always show the per-dimension breakdown and the evidence behind them so the user can argue with the grade.

## 5. Report format

Produce the report **inline** in the response, in this shape:

1. **Verdict** — one or two sentences + the grade and score.
2. **Scorecard** — the per-dimension table.
3. **Top fixes** — the 3–5 highest-leverage changes, ranked.
4. **Findings** — grouped by severity, each with: what, where (`file:line`), why it matters, the fix, and any trade-off.
5. **What I didn't check** — scope honesty.

After printing, **offer to save** it to `agent-review/<skill-name>.md` (create the dir if needed). Don't write files unless the user agrees or passed `auto`.

## 6. Tone

Opinionated, specific, kind. Prefer concrete patterns over abstract advice. Recommend *removing* things when polishing them is the wrong call. State trade-offs plainly. Don't pad — a beginner should be able to act on the top fixes without a glossary.

## 7. Re-running & tracking progress

These reviews are meant to be re-run after fixes. Before writing a report, check for a prior `agent-review/<skill-name>.md`. If one exists, open the new report with a one-line **score delta** (e.g. *"72 → 84 (+12); 2 of 3 Critical findings resolved"*) and note which prior findings are now fixed, still open, or newly introduced. This turns the skills into a feedback loop, not a one-off grade.
