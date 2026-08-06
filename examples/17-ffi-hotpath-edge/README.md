# 17 — FFI hotpath edge (controlled \(E\))

**Axes:** A B C E F · **Core \(E\):** 0 · **Edge \(E\):** ≥600 metered `ffi-abs`

Larger escape surface than 05: hundreds of libc abs calls on a hot edge loop, while pure-Aura `kscale` rebind/load/own stay dense.

```bash
./scripts/run-aura.sh examples/17-ffi-hotpath-edge/main.aura
```
