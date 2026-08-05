# 12 — Sub-second metrology denseness (#2655)

**Axes:** A D F (+ B rebind) · **Escapes:** 0  
**Requires:** Aura with `(monotonic-ms)` / `(current-time-ms)` ([#2655](https://github.com/cybrid-systems/aura/issues/2655)).

## What it unlocks

| Before #2655 | After |
|--------------|--------|
| Short kernels → `elapsed_s=0` | `elapsed_ms > 0` on moderate N |
| ops/s unusable without ~1s pad | `ops_per_s` from ms clock |
| Spec comparison needs huge loads | Loop vs closed-form at N≈8e4 |

## Checks

1. `monotonic-ms` present  
2. Loop `sum-kernel`: correct + `elapsed_ms > 0` + `ops_per_s > 0`  
3. Rebind closed form: correct; elapsed_ms ≥ 0  
4. Report both timings (does **not** require closed always faster)

## Run

```bash
# denseness host with #2655 (e.g. /tmp/aura-denseness-build or post-fix aura-grok)
./scripts/run-aura.sh examples/12-subsecond-metrology/main.aura
```
