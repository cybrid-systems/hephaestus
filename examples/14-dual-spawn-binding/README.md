# 14 — Dual fiber:spawn binding (#2685)

**Escapes:** 0

Locks product contract:

1. `let*` sequential spawn+join → distinct positive ids  
2. Multi-`define` `begin` dual spawn → independent ids + joins  

See Aura `docs/stdlib/fiber-spawn.md` Binding discipline.

```bash
./scripts/run-aura.sh examples/14-dual-spawn-binding/main.aura
```
