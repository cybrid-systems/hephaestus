# 01 — Minimal pure-Aura kernel

**Axes:** A (kernel completeness) + F (metrology)  
**Escapes:** 0 on hot path (by construction)

## What it proves

| Kernel | Check |
|--------|--------|
| `heph:sum-sq` | Matches closed form \(n(n-1)(2n-1)/6\) (0-based \(i^2\)) |
| `heph:dot` | Matches independent reference accumulation |
| `heph:saxpy!` + `heph:reduce-sum` | Linear algebra identity after in-place update |
| Load runs | Wall-time metrology via `heph:time-call` (ops, elapsed_s, ops_per_s) |

No mutation, no FFI, no LLM. This is the Phase-1 baseline: **bind → load → observe → verify**.

## Run

```bash
./scripts/run-aura.sh examples/01-minimal-kernel/main.aura
```

Expect:

```
PASS: pure-Aura kernels + metrology (escapes=0)
RESULT pass example=01-minimal-kernel escapes=0
```

## Notes

- Host `(current-time)` is whole seconds; loads are sized so elapsed is usually ≥ 1s.
- Hot loops use `while`, not deep recursion (host recursion limit).
