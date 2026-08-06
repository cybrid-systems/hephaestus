# Denseness Report — Hephaestus

**Date:** 2026-08-04  
**Status:** Phase 1–5 probes landed (**01**–**06** PASS).  
**Judgment:** on \(S_{\mathrm{Hephaestus}}\) (as scoped below), \(V_A\) is **practically dense** for the evolvable / tunable core, with controlled metered edge \(E\).

**Theory:** [aura-unify.md](aura-unify.md)  
**Prior span:** `../aether/notes/denseness-report.md` — \(S_{\mathrm{Aether}}\) practically dense (reference only; not re-claimed here)

---

## Claim under test

On \(S_{\mathrm{Hephaestus}}\), \(V_A\) is dense for the evolvable / tunable core of performance-critical numerical and systems kernels.

\[
P \approx A \oplus E,\quad A \in V_A
\]

Hephaestus does **not** claim denseness over all of \(S_{\mathrm{practical}}\) or over \(S_{\mathrm{Aether}}\).

### Scoped meaning of “practically dense”

| In scope | Out of scope (this judgment) |
|----------|------------------------------|
| Pure-Aura numerical kernels + load | Full ML frameworks / autograd |
| Safe rebind under load + restore | Hard realtime / MMIO drivers |
| AST ownership / boundary / quota health | Concurrent multi-fiber mutators (stress) |
| Algorithm specialization in \(V_A\) | Host JIT counter fidelity (H7) |
| Metered FFI edge off the evolvable core | SIMD / GPU foreign kernels productization |
| Multi-round soak (N=25) | Overnight multi-hour soak |

---

## Constructive evidence

| Probe | Axes | Result | Core \(E\) | Edge \(E\) |
|-------|------|--------|------------|------------|
| [01-minimal-kernel](../examples/01-minimal-kernel/) | A F | **PASS** | 0 | 0 |
| [02-mutation-under-load](../examples/02-mutation-under-load/) | A B F | **PASS** | 0 | 0 |
| [03-ownership-transfer](../examples/03-ownership-transfer/) | A B C F | **PASS** | 0 | 0 |
| [04-jit-specialization](../examples/04-jit-specialization/) | A B D F C | **PASS** | 0 | 0 |
| [05-perf-escape-boundary](../examples/05-perf-escape-boundary/) | A B C E F | **PASS** | **0** | **≥6** (metered FFI abs) |
| [06-long-n-soak](../examples/06-long-n-soak/) | A B C D F | **PASS** N=25 | 0 | 0 |
| [07-long-n-50](../examples/07-long-n-50/) | A B C D F | **PASS** N=50 | 0 | 0 |
| [08-host-anomaly-scan](../examples/08-host-anomaly-scan/) | host | **PASS** (hash/fiber OK post-fix; H2 clock fixed #2655) | 0 | 0 |
| [09-concurrent-rebind](../examples/09-concurrent-rebind/) | A B C F | **PASS** 4-worker fanout + main rebind | 0 | 0 |
| [10-mutate-in-fiber](../examples/10-mutate-in-fiber/) | A B C F | **PASS** rebind inside fibers (+ mut‖reader) | 0 | 0 |
| [11-snapshot-after-fiber-mutate](../examples/11-snapshot-after-fiber-mutate/) | A B C F | **PASS** golden + pre-fiber restore after fiber rebind | 0 | 0 |
| [12-subsecond-metrology](../examples/12-subsecond-metrology/) | A D F | **PASS** short-path elapsed_ms/ops/s via monotonic-ms | 0 | 0 |
| [13-rebind-observability](../examples/13-rebind-observability/) | B D F | **PASS** #2684 epoch/invalidate after rebind | 0 | 0 |
| [14-dual-spawn-binding](../examples/14-dual-spawn-binding/) | host/C | **PASS** #2685 dual spawn distinct ids | 0 | 0 |
| [15-concurrent-multi-rebind](../examples/15-concurrent-multi-rebind/) | A B C F | **PASS** #2686 concurrent dual-name rebind N=20 | 0 | 0 |

---

## Metrics (observed on PASS paths)

| Metric | Target | Observed |
|--------|--------|----------|
| Core hot-path escape rate | low / 0 preferred | **0** on 01–04, 06; **0 on core** of 05 |
| Edge escape metering | explicit | **yes** (`heph:escape-count`, escape-log) |
| Correctness after mutation + load | ≈100% | **yes** (incl. soak 25/25) |
| Ownership / nodes / quota | pass | **yes** (03–06) |
| Rollback / restore | yes | **yes** (02–05) |
| Soak rounds | N≥10 | **N=25** (06), **N=50** (07) |

---

## Axes coverage

| Axis | Status | Evidence |
|------|--------|----------|
| **A** Kernel completeness | covered | 01–06 pure-Aura kernels / loads |
| **B** Mutation under load | covered | 02–06 rebind-safe |
| **C** Ownership & memory | covered | 03–06 own-check |
| **D** Specialization | covered | 04 loop↔closed; 06 factor cycle |
| **E** Performance boundary | covered | 05 metered FFI edge; core remains pure |
| **F** Metrology | covered | alist stats, time-call, escape counts |

---

## Judgment

> On the **scoped** subspace \(S_{\mathrm{Hephaestus}}\) above, Aura’s \(V_A\) is **practically dense** for the evolvable / tunable core: numerical kernels, rebind under load, ownership checks, pure-Aura specialization, and multi-round soak stay in pure Aura with **core \(E = 0\)**. Necessary foreign edges (libc abs demo) can be **isolated, metered, and logged** without breaking core rebind, ownership, or restore.

This is a **constructive denseness** judgment (runnable probes + escape accounting), not a mathematical proof of denseness over all numerical software.

### What would falsify or weaken this judgment

- Core decide/load/verify **requires** unguarded foreign code  
- Rebind under load breaks ownership or yields silent wrong answers  
- Escapes on the evolvable core without metering / isolation  
- Soak shows growing ownership or correctness failures  

### Open follow-ups (not blockers for this judgment)

- SIMD / multi-buffer FFI with ownership pins  
- Overnight / N=100 soak harness  
- Mutate-in-fiber concurrent multi-name via 15-style (optional unify 10+15)

### Upstream issues filed from Hephaestus denseness

| Aura issue | Residual | Topic | Status |
|------------|----------|--------|--------|
| [#2654](https://github.com/cybrid-systems/aura/issues/2654) | H6 | `(hash)` / `hash-set!` grow | **fixed** — measure uses hash again |
| [#2655](https://github.com/cybrid-systems/aura/issues/2655) | H2 | sub-second / monotonic clock | **closed** (prims + heph:time-call) |
| [#2656](https://github.com/cybrid-systems/aura/issues/2656) | H9 | `fiber:spawn` positive ids | **fixed** — probes 09–10 |
| [#2684](https://github.com/cybrid-systems/aura/issues/2684) | H7 | rebind observability contract | **fixed** — probe 13 |
| [#2685](https://github.com/cybrid-systems/aura/issues/2685) | H9 caveat | dual spawn binding | **fixed** — probe 14 |
| [#2686](https://github.com/cybrid-systems/aura/issues/2686) | H10 | concurrent multi-name rebind | **fixed** — probe 15 |

---

## Escape accounting

See [escape-log.md](escape-log.md). Only intentional edge escape to date: **libc abs** in 05 / `hephaestus-escape`.

---

## Reproduce

```bash
./scripts/run-aura.sh examples/01-minimal-kernel/main.aura
./scripts/run-aura.sh examples/02-mutation-under-load/main.aura
./scripts/run-aura.sh examples/03-ownership-transfer/main.aura
./scripts/run-aura.sh examples/04-jit-specialization/main.aura
./scripts/run-aura.sh examples/05-perf-escape-boundary/main.aura
./scripts/run-aura.sh examples/06-long-n-soak/main.aura
```

Host residuals: [host-residuals.md](host-residuals.md).
