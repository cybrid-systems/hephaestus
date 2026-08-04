# 06 — Long-N soak (rebind + load + ownership)

**Axes:** A + B + C + D + F  
**Escapes:** 0 (no FFI; pure-Aura soak)

## What it proves

Over **N=25** rounds:

1. Cycle `kscale` among ×2 / ×3 / ×5 via `heph:rebind-safe`
2. Pure-Aura load matches closed form each round
3. `heph:own-check` remains all-ok
4. Escape count stays **0**

Complements 05 (which intentionally meters edge \(E\)).

## Run

```bash
./scripts/run-aura.sh examples/06-long-n-soak/main.aura
```

Expect:

```
PASS: soak N=25 rebind+load+own (escapes=0)
RESULT pass example=06-long-n-soak escapes=0 rounds=25
```
