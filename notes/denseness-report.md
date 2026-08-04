# Denseness Report — Hephaestus

**Status**: Phase 1–2 probes landed (**01**, **02** PASS). No full \(S_{\mathrm{Hephaestus}}\) denseness judgment yet.

**Theory:** [aura-unify.md](aura-unify.md) (Aura Unify 总论 + span 程序)  
**Prior span:** `../aether/notes/denseness-report.md` — \(S_{\mathrm{Aether}}\) practically dense (reference only; not re-claimed here)

## Claim under test

On \(S_{\mathrm{Hephaestus}}\), \(V_A\) is dense for the evolvable / tunable core of performance-critical numerical and systems kernels.

\[
P \approx A \oplus E,\quad A \in V_A
\]

Hephaestus does **not** claim denseness over all of \(S_{\mathrm{practical}}\) or over \(S_{\mathrm{Aether}}\).

## Current phase

| Phase | Focus | Status |
|-------|--------|--------|
| 1 | Pure-Aura kernels + baseline metrology | **01 PASS** |
| 2 | Mutation / rebind under load | **02 PASS** |
| 3+ | Ownership, JIT specialization, performance \(E\), soak | pending |

## Constructive evidence

| Probe | Axes | Result | Core \(E\) |
|-------|------|--------|------------|
| [01-minimal-kernel](../examples/01-minimal-kernel/) | A F | **PASS** sum-sq / dot / saxpy+reduce + load metrology | **0** |
| [02-mutation-under-load](../examples/02-mutation-under-load/) | A B F | **PASS** rebind double→triple under load; bad rebind→restore | **0** |

## Metrics

| Metric | Target | Observed | Notes |
|--------|--------|----------|-------|
| Hot-path escape rate | low / measurable | **0** on 01–02 | Pure Aura kernels + mutate surfaces |
| Correctness after mutation + load | ≈ 100% | **yes** on 02 | post-rebind load + sample |
| Ownership / lifetime violations | 0 | — | Phase 3 |
| Throughput regression under safe mutation | bounded | reported | pre/post ops_per_s on 02 (coarse 1s clock) |
| Rollback restores state + metrics baseline | yes | **yes** on 02 | snapshot restore → triple again |
| Baseline correctness (no mutation) | ≈ 100% | **5/5** on 01 | closed-form + ref accumulators |
| Boundary / quota after mutation | healthy | **safety-ok** on 02 | |

## Axes coverage

| Axis | Status |
|------|--------|
| A. Kernel completeness | **01–02** pure-Aura sum-sq, dot, saxpy, map-scale load |
| B. Mutation under load | **02** `heph:rebind-safe` + load before/after |
| C. Ownership & memory | pending |
| D. JIT & specialization | pending (implicit host only) |
| E. Performance boundary | pending (no intentional foreign \(E\)) |
| F. Metrology | **01–02** `heph:time-call` + stats + safety-ok |

## Judgment

*None yet for full \(S_{\mathrm{Hephaestus}}\).*

Early signal:

1. Non-trivial pure-Aura numerical core runs with **escape count 0**.  
2. Named kernel rebind under load + snapshot rollback stays in \(V_A\) with correctness restored.

Still open: ownership under concurrent mutation, specialization/JIT denseness, intentional high-perf escapes, longer soak.

## How to reproduce

```bash
./scripts/run-aura.sh examples/01-minimal-kernel/main.aura
./scripts/run-aura.sh examples/02-mutation-under-load/main.aura
```

Host residuals: [host-residuals.md](host-residuals.md).  
Escapes: [escape-log.md](escape-log.md) (none on 01–02 hot paths).
