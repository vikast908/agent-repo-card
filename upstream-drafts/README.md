# Upstream contributions

PRs contributing skills to other open-source collections, reframed into each host project's genre and format. Not part of this repo's installable skill set — only `skills/` installs.

## `addyosmani/agent-skills` (MIT)

Their skills are prescriptive build-time behaviors (Overview → When to Use → Process → Common Rationalizations → Red Flags → Verification, with BAD/GOOD code), not scored audits. These drafts are rewritten to that anatomy: the plan-first gate, severity, scoring, and report format are removed; Process / Rationalizations / Red Flags / Verification are added. Each references their existing related skills instead of duplicating them.

### Contributed (PRs open)

| Draft | Gap it fills in their repo | Sourced from our | PR |
|---|---|---|---|
| `reliable-agent-loops` | No agent-loop robustness skill (termination, tool errors, idempotency, budgets, resume) | `agent-reliability` | [#285](https://github.com/addyosmani/agent-skills/pull/285) |
| `evaluating-llm-output` | TDD exists, but no LLM evals (golden sets, judge, prompt regression, CI gating) | `agent-eval-coverage` | [#286](https://github.com/addyosmani/agent-skills/pull/286) |
| `llm-cost-optimization` | No runtime LLM token/$ cost skill (distinct from `context-engineering` and `performance-optimization`) | `token-efficiency` | [#287](https://github.com/addyosmani/agent-skills/pull/287) |

### Deliberately not contributed

- **LLM security** — their `security-and-hardening` already has a full "Securing AI / LLM Features" section covering the OWASP LLM Top 10 (prompt injection, output handling, secrets in prompts, excessive agency, unbounded consumption, RAG isolation) with BAD/GOOD code and checklist entries. A new skill or an enhancement would duplicate it, which their no-duplication rule rejects. Our `agent-security` stays in this repo.
- **accessibility / ux** — their `frontend-ui-engineering` already ships a WCAG section plus an accessibility checklist. Covered.
- **product** — product/PMF review is off-theme for an engineering-skills repo.

### How these were submitted

One skill per PR, each branched off a fresh `main` in a fork, matching their [CONTRIBUTING](https://github.com/addyosmani/agent-skills/blob/main/CONTRIBUTING.md): specific, verifiable, battle-tested, minimal; `name` + `description` frontmatter only; no duplication; no extra files. MIT on both sides.
