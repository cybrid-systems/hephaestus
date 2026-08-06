# 13 — Rebind observability (#2684 / H7)

**Axes:** B D F · **Escapes:** 0

Assert pure-Aura `mutate:rebind` advances lifetime host counters:

- `compile:epoch` and/or
- `query:jit-stats-hash` → `hotswap-invalidate-total` / `mutation-epoch`

Sticky dirty after `eval-current` is **not** required (see Aura `docs/stdlib/hot-strategy.md`).

```bash
./scripts/run-aura.sh examples/13-rebind-observability/main.aura
```
