# Hephaestus lib

Composable denseness helpers. Prefer these modules from probes; do not fork Aura engine code.

| Module | Axes | Role |
|--------|------|------|
| `hephaestus-measure.aura` | F | Alist stats, wall-time call, ops/s (H6) |
| `hephaestus-kernel.aura` | A | Pure-Aura numerical kernels (`while` loops) |
| `hephaestus-mutate.aura` | B | install / snapshot / restore / rebind-safe |
| `hephaestus-own.aura` | C | ownership/nodes/quota checks |
| `hephaestus-min.aura` | A+B+C+F | Facade re-export for Phase 1–3 probes |

Host resolution: `scripts/run-aura.sh` sets `AURA_PATH` to `../aura-grok/lib:./lib`.

```scheme
(require "hephaestus-min" all:)
```

Timing uses host `(current-time)` (whole seconds). Size workloads so `elapsed_s >= 1` when you need ops/s.
