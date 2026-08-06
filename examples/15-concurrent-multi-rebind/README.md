# 15 — Concurrent multi-name rebind (#2686 / H10)

**Axes:** A B C F · **Escapes:** 0 · **Trials:** 20

Two CLI fibers rebind **distinct** names (`ka` / `kb`) concurrently:

- no crash  
- both joins succeed  
- `ka(7)=21`, `kb(7)=35`  
- ownership OK  

Unlocks denseness path that was sequential-only under H10.

```bash
./scripts/run-aura.sh examples/15-concurrent-multi-rebind/main.aura
```
