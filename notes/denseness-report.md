# Denseness Report — Hephaestus

**Status**: Phase 1–4 probes landed (**01**–**04** PASS). No full \(S_{\mathrm{Hephaestus}}\) denseness judgment yet.

**Theory:** [aura-unify.md](aura-unify.md)  
**Prior span:** `../aether/notes/denseness-report.md` — \(S_{\mathrm{Aether}}\) practically dense (reference only)

## Claim under test

On \(S_{\mathrm{Hephaestus}}\), \(V_A\) is dense for the evolvable / tunable core of performance-critical numerical and systems kernels.

\[
P \approx A \oplus E,\quad A \in V_A
\]

## Current phase

| Phase | Focus | Status |
|-------|--------|--------|
| 1 | Pure-Aura kernels + baseline metrology | **01 PASS** |
| 2 | Mutation / rebind under load | **02 PASS** |
| 3 | Ownership under alloc + rebind | **03 PASS** |
| 4 | Specialization in \(V_A\) (algorithm rebind) | **04 PASS** |
| 5 | Performance \(E\) boundary / soak / judgment | pending |

## Constructive evidence

| Probe | Axes | Result | Core \(E\) |
|-------|------|--------|------------|
| [01-minimal-kernel](../examples/01-minimal-kernel/) | A F | **PASS** sum-sq / dot / saxpy + load | **0** |
| [02-mutation-under-load](../examples/02-mutation-under-load/) | A B F | **PASS** rebind + rollback under load | **0** |
| [03-ownership-transfer](../examples/03-ownership-transfer/) | A B C F | **PASS** own/nodes/quota across alloc+rebind+restore | **0** |
| [04-jit-specialization](../examples/04-jit-specialization/) | A B D F C | **PASS** loop→closed-form; kscale ×2/×3/fused/×5; restore | **0** |

## Metrics

| Metric | Target | Observed |
|--------|--------|----------|
| Hot-path escape rate | low | **0** on 01–04 |
| Correctness after specialization + load | ≈100% | **yes** on 04 |
| Ownership under mutation | pass | **yes** on 03–04 |
| Rollback / restore | yes | **yes** on 02–04 |
| Host JIT counter denseness | optional | **sparse** (H7) — not required for claim |

## Axes coverage

| Axis | Status |
|------|--------|
| A. Kernel completeness | **01–04** |
| B. Mutation under load | **02–04** |
| C. Ownership & memory | **03–04** |
| D. JIT & specialization | **04** pure-Aura algorithmic specialize (host JIT counters H7) |
| E. Performance boundary | pending |
| F. Metrology | **01–04** alist stats |

## Judgment

*None yet for full \(S_{\mathrm{Hephaestus}}\).*

Early signal stack:

1. Pure-Aura numerical core, \(E=0\).  
2. Rebind under load + restore.  
3. Ownership/nodes/quota healthy under alloc pressure.  
4. **Specialization of evolvable kernels stays in \(V_A\)** (loop vs closed form; scale factor / fused algebra) with load correctness.

Still open: intentional high-perf escape boundary (axis E), concurrent mutation, longer soak, richer JIT observability.

## Reproduce

```bash
./scripts/run-aura.sh examples/01-minimal-kernel/main.aura
./scripts/run-aura.sh examples/02-mutation-under-load/main.aura
./scripts/run-aura.sh examples/03-ownership-transfer/main.aura
./scripts/run-aura.sh examples/04-jit-specialization/main.aura
```
