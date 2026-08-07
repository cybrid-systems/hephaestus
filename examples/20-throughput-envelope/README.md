# 20 — Throughput envelope under rebind

**Axes:** A B D F  
**Escapes:** 0  
**Phase:** 6 — hard performance envelope (not only correctness)

## What it proves

| Step | Check |
|------|--------|
| Same-complexity load | `kscale` map-load timed; correct + measurable |
| Rebind ×2→×3 | Same work shape; **ratio permille ∈ [400, 2500]** |
| Specialization | loop `sum-kernel` → closed form: correct + measurable (no upper speedup bound) |
| Ownership | own-check pass |

Uses `heph:throughput-ratio` / `heph:envelope-ok?`. The hard band applies to **same-complexity** rebind (denseness criterion: mutation must not destroy the performance envelope). Algorithmic specialization may speed up freely if still correct and timed.

## Run

```bash
./scripts/run-aura.sh examples/20-throughput-envelope/main.aura
```

Expect:

```
PASS: throughput envelope under rebind (escapes=0)
RESULT pass example=20-throughput-envelope escapes=0 ratio=...
```
