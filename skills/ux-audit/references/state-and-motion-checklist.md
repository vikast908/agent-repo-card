# UX state & motion checklist (reference)

Use this when you need the exhaustive version. The `SKILL.md` summarizes; this expands.

## Per-interaction 20-facet walk

For each high-value interaction, answer all of these. A blank answer is usually a finding.

1. **Trigger** — what starts it (click, key, hover, system event, agent action)?
2. **User intent** — what is the user actually trying to accomplish?
3. **System response** — what the system does internally.
4. **Immediate feedback** — what the user sees within ~100ms.
5. **Motion** — does anything animate, and does it carry meaning?
6. **Loading** — what fills the wait? Skeleton, optimistic UI, progress, streamed partials?
7. **Success state** — how does the user know it worked, beyond the thing just happening?
8. **Failure state** — what does failure look like, in plain language?
9. **Recovery path** — can the user get unstuck without reloading or losing work?
10. **Undo** — can the action be reversed? For how long? Is it discoverable?
11. **Empty state** — first-run / no-data: does it teach and invite action?
12. **Offline / degraded** — what happens with no/slow network or a degraded backend?
13. **Permission / access** — clear messaging for unauthorized / forbidden / quota states?
14. **Latency thresholds** — different treatment for <100ms, <1s, 1–10s, >10s?
15. **Accessibility** — keyboard operable, announced to AT, sufficient contrast, target size?
16. **Keyboard & focus** — shortcuts, focus order, focus trapping in modals, focus return?
17. **Pointer states** — hover, pressed, active, drag affordance?
18. **Mobile / touch** — target sizes, gestures, no hover-only affordances?
19. **Telemetry** — which moments are worth an analytics event (start, success, failure, cancel, retry)?
20. **Interruptions** — what's shown when the user waits, retries, cancels, switches tabs, or returns later?

## Latency → treatment

| Wait | Treatment |
|---|---|
| <100ms | Instant; no spinner. |
| 100ms–1s | Subtle inline feedback; pressed/active state; optimistic update if safe. |
| 1s–10s | Skeleton or progress with meaning ("Fetching 3 sources…"); keep UI responsive; allow cancel. |
| >10s | Streamed partials or staged progress; background option; explicit "still working"; cancel + resume. |

## Component states (design all that apply)

default · hover · pressed/active · focused (visible ring) · loading · disabled (with reason) · success · warning · error (with recovery) · empty · partial · offline · syncing · stale · updating · completed.

## Motion spec template

For every animation you recommend:

- **What animates:** (property: opacity / transform / height …)
- **Why:** orient / confirm / show hierarchy / explain change / reduce perceived latency / build trust
- **Duration:** (ms) — entrances 150–250ms, exits 100–150ms, large reflows 250–400ms
- **Easing:** (e.g. ease-out for entrances, ease-in for exits, spring for direct manipulation)
- **Start → end state**
- **Subtle vs noticeable**
- **Reduced-motion fallback:** what happens under `prefers-reduced-motion`

Reject motion that: distracts, delays access to content, hides information, feels playful in a serious workflow, or causes layout shift/jank.

## AI / agentic surface checklist

- Streaming partial results (text, tokens, intermediate steps).
- Tool-execution visibility ("Searching the web…", "Editing file X").
- Stage/status indicators for multi-step work.
- Progress/reasoning summary **without** dumping raw chain-of-thought.
- Confidence signaling where the model is uncertain.
- Plan-before-action for consequential operations.
- Visible self-correction / re-run affordances.
- Safe interruption: cancel that actually stops work and leaves a clean state.
- Background execution + resumable workflows + partial completion handling.
- A clear, explicit completion / handoff state.
- A plain-language summary of what the AI changed.

## Canvas / editor checklist

- Node & edge creation microinteractions; ghost previews; insertion hints.
- Drag / snap / align / distribute; collision detection and resolution feedback.
- Auto-layout with **animated reflow** so users see what moved and why.
- Zoom / pan / fit-to-screen / zoom-to-selection.
- Grouping, collapsing, focus mode for dense graphs.
- Selection, multi-select, marquee, hover affordances.
- Before/after comparison for layout changes; undo for layout operations.
