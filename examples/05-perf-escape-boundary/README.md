# 05 — Controlled performance escape boundary

**Axes:** A + B + C + E + F  
**Core \(E\):** 0 on evolvable `kscale` path  
**Edge \(E\):** metered libc `abs` via `c-func` (`heph:ffi-abs`)

## Claim

\[
P \approx A \oplus E
\]

| Layer | Content |
|-------|---------|
| \(A\) | Pure-Aura `kscale` rebind + load + ownership |
| \(E\) | Thin FFI abs edge, **metered** (`heph:escape-count`) |

Escapes are **justified & isolated** (see `notes/escape-log.md`), not on the decide/verify core.

## Run

```bash
./scripts/run-aura.sh examples/05-perf-escape-boundary/main.aura
```

Expect:

```
PASS: controlled E boundary; pure core denseness preserved
RESULT pass example=05-perf-escape-boundary core_E=0 edge_E=<n>
```

with `edge_E >= 6` (parity samples + isolated edge call).
