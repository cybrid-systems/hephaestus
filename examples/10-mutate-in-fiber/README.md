# 10 — Mutate inside fibers

**Axes:** A B C F · **Escapes:** 0  
**Requires:** Aura [#2656](https://github.com/cybrid-systems/aura/issues/2656) (+ #2654 for hash stats).

Extends `09` (main-only rebind + fiber **readers**) to **typed rebind on worker fibers**.

| Step | What |
|------|------|
| M0 | Single fiber rebind `kscale` → ×3 |
| M1 | **Sequential** fiber rebinds of distinct `ka` / `kb` |
| M2 | Fiber rebind + concurrent pure fiber reader; **final ×3** (join `:ok` optional) |
| M3 | Concurrent same-name rebind stress; ownership sane |

## Notes

- Host may log `[fiber:join] WARN: workspace mutated during join` — expected.
- M2 denseness is **final binding** (`kscale(7)=21`), not mut-fiber join shape. Under a concurrent reader the mut join can be empty/non-`:ok` while rebind still applies; one automatic retry if final does not land.
- Concurrent **distinct-name** dual rebind is covered by probe **15** (aura#2686 / H10 closed).

## Run

```bash
./scripts/run-aura.sh examples/10-mutate-in-fiber/main.aura
```
