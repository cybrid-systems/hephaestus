# GROK — Living prompt for Hephaestus

You are helping advance **Hephaestus**, the second concrete denseness probe of **Aura Unify**.

## Read first

1. [`notes/aura-unify.md`](../notes/aura-unify.md) — theory: unified semantic basis, span program, success conditions  
2. [`README.md`](../README.md) — \(S_{\mathrm{Hephaestus}}\), axes A–F, phase plan  
3. Prior span evidence: `../aether/README.md` and `../aether/notes/denseness-report.md`  
4. Host basis: `../aura-grok` (binary + `lib/std`)

Keep this prompt aligned with those docs when scope or phase changes.

---

## Context

- **Aura** (`../aura-grok`) is the AI-native Lisp runtime — basis \(V_A\).
- **Aether** (`../aether`) already established **practical denseness** on the agent + safe-mutation closed-loop subspace \(S_{\mathrm{Aether}}\).
- **Hephaestus** (this repo) pressure-tests the same basis on the **Performance / Numerical / Systems Kernel** subspace \(S_{\mathrm{Hephaestus}}\).

You are **not** re-proving Aether. You **may cite** Aether patterns (escape discipline, denseness metrics, probe layout) when they transfer.

---

## Core question

Can the evolvable / tunable core of high-performance numerical and systems kernels stay mostly inside \(V_A\), with only rare, ownership-safe, metered escapes \(E\)?

\[
P \approx A \oplus E,\quad A \in V_A
\]

Focus: hot paths, kernels, memory layouts, specialization points, concurrent mutation under load, performance observability.

---

## Canonical loop

```
Specialize / Bind Kernel  →  Run under load  →  Observe metrics  →
Safe Mutation / Rebind    →  Verify correctness + performance  →
Rollback (if needed)      →  Specialize / Bind
```

---

## Working rules

1. Prefer pure Aura on critical paths. Compose Aura stdlib/engine surfaces; **do not fork** engine sources into this repo.  
2. Every escape on a hot path or evolvable core must be logged in `notes/escape-log.md` (reason, mechanism, ownership impact, denseness status).  
3. Mutation of kernels must preserve correctness **and** a measurable performance envelope.  
4. Metrology is first-class: throughput, latency, allocation, escape rate, ownership events.  
5. Host/packaging blockers go to `notes/host-residuals.md` — do not confuse them with denseness failures.  
6. Update `notes/denseness-report.md` when probes land; do not invent a denseness “pass” without runnable evidence.  
7. Theory changes → update `notes/aura-unify.md` (and cross-links); probe work alone does not rewrite the manifesto.

---

## Axes (inside \(S_{\mathrm{Hephaestus}}\) only)

| Axis | Span target |
|------|-------------|
| **A. Kernel completeness** | Realistic hot paths mostly in \(V_A\) |
| **B. Mutation under load** | Safe rebind / specialize while running |
| **C. Ownership & memory** | Linear/affine, arena, pin across concurrent mutation |
| **D. JIT & specialization** | Usable perf without unjustified escape |
| **E. Performance boundary** | SIMD / FFI / foreign kernels metered & isolated |
| **F. Metrology** | Escape rate, throughput regression, dual rollback |

---

## Current phase goal

**Phase 1–5 complete.** Denseness judgment: practically dense on scoped \(S_{\mathrm{Hephaestus}}\) (see `notes/denseness-report.md`).

| Probe | Status |
|-------|--------|
| `examples/01-minimal-kernel` | **PASS** |
| `examples/02-mutation-under-load` | **PASS** |
| `examples/03-ownership-transfer` | **PASS** |
| `examples/04-jit-specialization` | **PASS** |
| `examples/05-perf-escape-boundary` | **PASS** (core \(E\)=0, edge metered) |
| `examples/06-long-n-soak` | **PASS** N=25 escapes=0 |

**Next (optional):** concurrent fiber mutation, longer soak, SIMD/pin edges — only if they extend the denseness claim.

Host style notes (see `notes/host-residuals.md`): prefer **literals** in helpers (H8); **`while`** not deep recursion; **alist stats** (H6); JIT counters sparse (H7); every new escape → `notes/escape-log.md`.

When generating code or probes, keep the denseness claim **testable** and the escape discipline **strict**.

### After generating

Briefly state:

- Which axes (A–F) this advances  
- Which part of the performance denseness loop it implements  
- Escapes remaining and open safety/ownership questions  
- How to run: `./scripts/run-aura.sh examples/NN-name/main.aura` (expects `../aura-grok` or `AURA_PATH`)

---

## Success metric (near-term)

A **runnable** pure-Aura kernel probe with baseline metrics and an honest escape count (ideally 0 on the hot path), structured so later phases can add mutation-under-load and ownership stress without rewriting the metrology story.

Longer-term success is a denseness report for \(S_{\mathrm{Hephaestus}}\), not a pile of unrelated microbenchmarks.

---

Update this prompt when architecture, phase, or denseness thresholds evolve.
