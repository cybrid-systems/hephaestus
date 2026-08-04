# 03 — Ownership across rebind + alloc pressure

**Axes:** A + B + C + F  
**Escapes:** 0

## What it proves

| Step | Check |
|------|--------|
| Baseline | `ast:validate-ownership` / nodes / boundary / quota all OK |
| Alloc + load | Transient vector wave + map-scale load; ownership still pass |
| Rebind under pressure | `kscale` double→triple after second alloc wave; correctness + own-check |
| Poison + restore | Bad rebind, ownership still pass, restore recovers triple |

Host surfaces used (still \(V_A\)):

- `ast:validate-ownership`, `ast:validate-nodes`
- `mutate:safety-snapshot` (boundary / quota)
- `heph:rebind-safe` / snapshot / restore

Not yet claimed: `pin-stable-refs` handle discipline, concurrent fiber mutation, FFI pin buffers (those would be later axis C/E probes).

## Run

```bash
./scripts/run-aura.sh examples/03-ownership-transfer/main.aura
```

Expect:

```
PASS: ownership across alloc + rebind + restore (escapes=0)
RESULT pass example=03-ownership-transfer escapes=0
```
