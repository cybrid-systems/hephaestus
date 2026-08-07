# Hephaestus lib

Composable denseness helpers. Prefer these modules from probes; do not fork Aura engine code.

| Module | Axes | Role |
|--------|------|------|
| `hephaestus-measure.aura` | F | Process **hash** stats, ms timing, ops/s, **throughput envelope** |
| `hephaestus-kernel.aura` | A | Pure-Aura kernels: BLAS-1 + **jacobi / matmul / gather** (v2) |
| `hephaestus-mutate.aura` | B | install / snapshot / restore / rebind-safe |
| `hephaestus-own.aura` | C | ownership/nodes/quota + **pin-stable-refs** helpers |
| `hephaestus-escape.aura` | E | Metered FFI edge (`ffi-abs`) + pure-abs |
| `hephaestus-min.aura` | A–F | Facade re-export (min-version 8, Phase 1–6) |

Host resolution: `scripts/run-aura.sh` sets `AURA_PATH` to `../aura-grok/lib:./lib`.

```scheme
(require "hephaestus-min" all:)
```

Timing uses host `(monotonic-ms)` (#2655). Short pure kernels can report `elapsed_ms > 0`; `heph:time-call` exposes `:elapsed_ms` and derived ops/s.
