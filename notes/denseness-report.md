# Denseness Report — Hephaestus

**Status**: Phase 1–3 probes landed (**01**–**03** PASS). No full \(S_{\mathrm{Hephaestus}}\) denseness judgment yet.

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
| 3 | Ownership / AST integrity under alloc + rebind | **03 PASS** |
| 4+ | JIT specialization, performance \(E\), soak | pending |

## Constructive evidence

| Probe | Axes | Result | Core \(E\) |
|-------|------|--------|------------|
| [01-minimal-kernel](../examples/01-minimal-kernel/) | A F | **PASS** sum-sq / dot / saxpy+reduce + load metrology | **0** |
| [02-mutation-under-load](../examples/02-mutation-under-load/) | A B F | **PASS** rebind double→triple under load; bad rebind→restore | **0** |
| [03-ownership-transfer](../examples/03-ownership-transfer/) | A B C F | **PASS** own/nodes/quota across alloc wave + rebind + poison restore | **0** |

## Metrics

| Metric | Target | Observed | Notes |
|--------|--------|----------|-------|
| Hot-path escape rate | low / measurable | **0** on 01–03 | Pure Aura + host validate/mutate surfaces |
| Correctness after mutation + load | ≈ 100% | **yes** on 02–03 | post-rebind load + sample |
| Ownership / nodes / quota under mutation | pass | **yes** on 03 | `heph:own-check` all-ok through poison+restore |
| Ownership violations counted | 0 | **ownership_fail=0** | 5 ownership_ok samples on 03 |
| Throughput under safe mutation | bounded | reported | coarse 1s wall clock |
| Rollback restores state | yes | **yes** on 02–03 | snapshot restore → triple |

## Axes coverage

| Axis | Status |
|------|--------|
| A. Kernel completeness | **01–03** pure-Aura numerical + map-scale loads |
| B. Mutation under load | **02–03** `heph:rebind-safe` + load before/after |
| C. Ownership & memory | **03** validate-ownership/nodes + quota under alloc pressure |
| D. JIT & specialization | pending (implicit host only) |
| E. Performance boundary | pending (no intentional foreign \(E\)) |
| F. Metrology | **01–03** alist stats (H6: hash capped ~8 keys) |

## Judgment

*None yet for full \(S_{\mathrm{Hephaestus}}\).*

Early signal:

1. Pure-Aura numerical core with **escape count 0**.  
2. Named kernel rebind under load + snapshot rollback stays in \(V_A\).  
3. AST ownership / nodes / boundary / quota remain healthy across alloc waves, rebind, poison, and restore.

Still open: concurrent fiber mutation, `pin-stable-refs` handle discipline, intentional high-perf escapes, longer soak, JIT specialization denseness.

## How to reproduce

```bash
./scripts/run-aura.sh examples/01-minimal-kernel/main.aura
./scripts/run-aura.sh examples/02-mutation-under-load/main.aura
./scripts/run-aura.sh examples/03-ownership-transfer/main.aura
```

Host residuals: [host-residuals.md](host-residuals.md).  
Escapes: [escape-log.md](escape-log.md) (none on 01–03 hot paths).
