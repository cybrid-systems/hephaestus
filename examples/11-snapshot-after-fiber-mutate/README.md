# 11 — Snapshot / restore after fiber mutate

**Axes:** A B C F · **Escapes:** 0  
**Requires:** Aura with fiber CLI backend ([#2656](https://github.com/cybrid-systems/aura/issues/2656)).

## What it proves

| Step | Check |
|------|--------|
| S1 | Fiber rebind `kscale` ×2→×3; `:snap` is pre-mutate |
| S2 | Main takes **golden** snapshot after fiber mutate |
| S3 | Fiber poisons ×99; main `restore` golden → ×3 |
| S4 | `restore` pre-fiber snap → ×2 |
| S5 | ownership / boundary / quota OK |

Dual rollback: post-fiber golden **and** pre-fiber baseline both recoverable after fiber-side mutation.

## Run

```bash
./scripts/run-aura.sh examples/11-snapshot-after-fiber-mutate/main.aura
```
