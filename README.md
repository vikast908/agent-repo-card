# agent-repo-card

**Grade your AI-agent repo. One command, one report card.**

Point it at any AI-agent / LLM-app repo and get an evidence-backed answer to one question: *is this good enough to ship?* It reads your actual code, runs the checks that apply, and returns severity-ranked findings, a per-area scorecard, and a single **ship / ship-with-fixes / not-ready** verdict.

This is **not** a "how to build" toolkit. Repos like [`addyosmani/agent-skills`](https://github.com/addyosmani/agent-skills) already do that well, and the two are complementary: build-skill repos help you *write* the agent; this one **grades the agent you wrote**.

---

## One command

```
/report-card            # plan first, then run the checks that apply
/report-card auto       # detect, run everything applicable, one combined grade
```

`report-card` detects what your repo is (Has a UI? Calls an LLM? Has tools?), runs only the relevant checks, dedupes overlapping findings, and produces one combined grade with a prioritized fix list. **[See a sample report.](examples/sample-report-card.md)**

> The grade is a prioritization signal, not a precise measurement — it's an LLM scoring against a rubric. The real value is the **evidence-cited findings** (each points at `file:line`) and the **ranked fixes**. Re-run after fixing and the score moves.

---

## What it checks

Each area is a skill in its own right. `report-card` orchestrates the ones that apply; you can also run any of them alone.

| Check | Answers | Applies when |
|---|---|---|
| [`agent-reliability`](skills/agent-reliability) | Will the agent loop survive the real world? | You run an agent / tool loop |
| [`agent-security`](skills/agent-security) | Can it be tricked, leaked, or abused? | Tools, secrets, or untrusted input |
| [`product-review`](skills/product-review) | Does this solve a real problem for a real user? | Any product |
| [`prompt-quality`](skills/prompt-quality) | Are the prompts well-crafted, or fighting the model? | You write prompts / instructions |
| [`agent-eval-coverage`](skills/agent-eval-coverage) | Would you even know if it broke? | You want to trust your own changes |
| [`token-efficiency`](skills/token-efficiency) | Are you burning tokens and money you don't need to? | You call an LLM at runtime |
| [`ux-audit`](skills/ux-audit) | Is the experience clear, trustworthy, and fast? | You have a UI / interaction layer |
| [`accessibility-audit`](skills/accessibility-audit) | Can everyone actually use it? | You ship a UI (incl. streaming output) |

Every check is **repo-aware** (cites `file:line`, never generic), **scored** (0–100 + grade), **beginner-friendly** (plans first, explains jargon, ranks fixes), and runs end-to-end with `auto`. Shared rubric: [`CONVENTIONS.md`](CONVENTIONS.md).

---

## Install

Standard [Claude Code Agent Skills](https://docs.claude.com/en/docs/claude-code/skills). Copy the skills into a directory Claude Code reads — `.claude/skills/` in the repo you're grading, or `~/.claude/skills/` globally.

```bash
./install.sh            # into the current repo
./install.sh --user     # globally
```

```powershell
./install.ps1           # into the current repo
./install.ps1 -User     # globally
```

Or copy each folder under `skills/` into your target `.claude/skills/` manually. Each skill is self-contained.

---

## Use

Open Claude Code in the repo you want to grade:

```
/report-card auto                # the whole picture, one grade
/agent-security                  # one check, plan-first
"review my prompts"              # auto-discovered by description
```

By default each skill shows a short plan and asks before the full review. Pass `auto` (or "skip the plan") to run start-to-finish.

---

## Why this exists

Most "review my repo" prompts are generic and unfalsifiable, and most skill collections teach an agent how to *build*. This one does the opposite job: it takes a finished AI-agent repo and tells you, with evidence, whether it's actually good — and where to start fixing. It's built to be run by the people who write agents and by the people who just want to know if the thing they shipped holds up.

## Contributing

New checks welcome — see [`CONTRIBUTING.md`](CONTRIBUTING.md). The bar: repo-aware, scored, self-contained, opinionated.

## License

MIT — see [`LICENSE`](LICENSE). © Vikas Tiwari.
