# 09 — Concurrent fiber load + main-thread rebind

**Axes:** A B C F · **Escapes:** 0  
**Requires:** Aura with [#2656](https://github.com/cybrid-systems/aura/issues/2656) (positive `fiber:spawn`) and [#2654](https://github.com/cybrid-systems/aura/issues/2654) (hash grow).

## Pattern

- **Workers:** pure `kscale` loads only (no mutate)  
- **Main:** `heph:rebind-safe` between fanout waves  
- Assert `fiber:spawn-backend` ∈ {1,2}, positive fids, joined sums match closed forms  

## Run

```bash
# Prefer a denseness-capable aura binary:
export AURA_BIN=/path/to/aura   # built at/after f97c3382 (#2656)
./scripts/run-aura.sh examples/09-concurrent-rebind/main.aura
```

Expect:

```
PASS: concurrent fiber load + main rebind (escapes=0)
RESULT pass example=09-concurrent-rebind escapes=0
```
