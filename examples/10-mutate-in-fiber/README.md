# 10 — Mutate inside fibers

**Axes:** A B C F · **Escapes:** 0  
**Requires:** Aura [#2656](https://github.com/cybrid-systems/aura/issues/2656) (+ #2654 for hash stats).

Extends `09` (main-only rebind + fiber **readers**) to **typed rebind on worker fibers**.

| Step | What |
|------|------|
| M0 | Single fiber rebind `kscale` → ×3 |
| M1 | **Sequential** fiber rebinds of distinct `ka` / `kb` |
| M2 | Fiber rebind + concurrent pure fiber reader; final ×3 |
| M3 | Concurrent same-name rebind stress; ownership sane |

## Host residual **H10**

Concurrent rebinds of **two different names from two fibers at once** can crash (`NodeView` assert) or return empty join on some hosts. Denseness **PASS path** therefore uses sequential fiber mutates for multi-name coverage; concurrent multi-mutate is out of denseness scope until host hardens.

Host may log `[fiber:join] WARN: workspace mutated during join` — expected.

## Run

```bash
./scripts/run-aura.sh examples/10-mutate-in-fiber/main.aura
```
