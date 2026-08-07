# 19 — Pin stable-refs across rebind

**Axes:** A B C F  
**Escapes:** 0  
**Phase:** 6 — Axis C pin table (host `#2189`)

## What it proves

| Step | Check |
|------|--------|
| Pin | `(pin-stable-refs)` on bare node-ids 0..3 returns count ≥ 1 |
| Alloc + load | Ownership pass while pins held |
| Rebind | `kscale` ×2→×3 under pins; correctness + own-check |
| Poison + restore | Dual safety while still pinned |
| Unpin | `(unpin-stable-refs)`; binding + ownership still OK |

Complements `03-ownership-transfer` (AST validate only) with **Agent pin table** lifecycle.

## Run

```bash
./scripts/run-aura.sh examples/19-pin-across-rebind/main.aura
```

Expect:

```
PASS: pin-stable-refs across alloc+rebind+restore (escapes=0)
RESULT pass example=19-pin-across-rebind escapes=0
```
