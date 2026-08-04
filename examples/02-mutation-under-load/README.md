# 02 — Mutation under load

**Axes:** A + B + F  
**Escapes:** 0 on evolvable core

## What it proves

| Step | Check |
|------|--------|
| Install | `kscale` = double via pure-Aura source |
| Pre-load | Map-scale + reduce matches factor 2 closed form |
| Rebind | `heph:rebind-safe` → triple under boundary/quota |
| Post-load | Load + sample match factor 3 |
| Stability | Second load still triple without further rebind |
| Rollback | Bad rebind (*99) then `heph:restore` → triple again |

Canonical denseness loop fragment:

```
Bind → Run under load → Safe Mutation → Verify corr+perf → Rollback path
```

## Run

```bash
./scripts/run-aura.sh examples/02-mutation-under-load/main.aura
```

Expect:

```
PASS: mutation under load + rollback (escapes=0)
RESULT pass example=02-mutation-under-load escapes=0
```
