# Sample: `report-card` on `acme-support-agent`

> **Illustrative only.** A fictional customer-support agent (Next.js UI + Node agent loop calling Claude with 4 tools: `searchDocs`, `lookupOrder`, `issueRefund`, `sendEmail`). Hand-written to show the output shape. Real runs cite real `file:line`.

---

## Verdict
**C+ (68/100) — Ship with fixes.** The product solves a real, frequent support problem and the UX is clean, but the agent loop can issue refunds on a retry and there are no evals — you wouldn't notice a prompt change breaking it. Fix the refund idempotency and add a golden set before scaling.

**Biggest risk:** agent-reliability (52) — non-idempotent side effects.

## Scorecard

| Area | Score | Grade | Summary |
|---|---|---|---|
| agent-reliability | 52 | F | Refund/email retried without idempotency key; no max-step cap |
| agent-security | 61 | C | RAG content trusted as instructions; `issueRefund` has no confirmation |
| product-review | 82 | B | Clear must-have job (deflect tickets); strong primary user |
| prompt-quality | 70 | C | System prompt solid; output contract for tool args is loose |
| agent-eval-coverage | 40 | D | No evals at all; manual spot-checks only |
| token-efficiency | 74 | C | Full chat history replayed each turn; system prompt not cached |
| ux-audit | 85 | B | Streaming + tool status visible; missing cancel + offline states |
| accessibility-audit | 79 | B | Good semantics; streamed output not announced to screen readers |

*Weights renormalized over the 8 applicable reviews. Overall = 68.*

## Biggest risks (deduped, ranked)

1. **Critical — Refund issued twice on retry.** `agent/tools/issueRefund.ts:23` — retried on timeout with no idempotency key; a slow Stripe call double-refunds. *(agent-reliability, agent-security)*
2. **Critical — No loop cap.** `agent/loop.ts:14` — `while(!done)` with no max-steps/budget; a confused model can loop until the token bill stops it. *(agent-reliability)*
3. **High — Indirect prompt injection via docs.** `agent/prompt.ts:31` — retrieved KB chunks are concatenated into the system prompt; a poisoned doc can instruct a refund. *(agent-security, prompt-quality)*
4. **High — No evals.** `(absent)` — a prompt or model change can silently drop answer quality; nothing would catch it. *(agent-eval-coverage)*
5. **High — Refund has no human gate.** `agent/tools/issueRefund.ts:8` — irreversible money movement runs autonomously. *(agent-security, agent-reliability)*

## Prioritized fix list

**Quick wins (hours)**
- Add an idempotency key to `issueRefund` / `sendEmail`; dedupe on it. *(fixes #1)*
- Add `MAX_STEPS = 12` + a per-run token budget to the loop. *(fixes #2)*
- Cache the static system prompt + tool schemas with `cache_control`. *(token-efficiency)*

**Medium (days)**
- Move retrieved docs into a fenced, labeled `data` block, never the instruction section. *(fixes #3)*
- Require confirmation for `issueRefund` above a threshold. *(fixes #5)*
- Add a 30-case golden set graded by 3 assertions, gated in CI at 90%. *(fixes #4)*

**Later**
- Window/summarize chat history instead of full replay.
- Announce streamed output via a polite `aria-live` region; add cancel + offline states.

## Strengths (don't regress)
- Real must-have problem with a clear primary user (support teams drowning in tickets).
- Tool execution is visible to the user with streaming + status — strong AI-trust UX.
- Clean semantic markup and keyboard support in the chat UI.

## Not checked
- No load/latency testing (out of scope for a static review).
- `issueRefund`'s Stripe integration was read but not executed.
