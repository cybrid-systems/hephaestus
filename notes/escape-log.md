# Escape Log — Hephaestus

Every departure from pure Aura (\(V_A\)) on a performance-critical or evolvable path must be recorded here.

Format for each entry:

```
## [YYYY-MM-DD] <short title>
- **Location**: file / probe / function
- **Reason**: why the escape was necessary
- **Mechanism**: FFI / SIMD / C++ kernel / external lib / other
- **Impact**: correctness | pure performance | both
- **Ownership / lifetime implications**:
- **Mitigation / future plan**:
- **Denseness status**: evidence against | justified & isolated | temporary
```

---

## [2026-08-04] libc abs via c-func (axis E probe)

- **Location**: `lib/hephaestus-escape.aura` (`heph:ffi-abs`); exercised by `examples/05-perf-escape-boundary/`
- **Reason**: Demonstrate a **controlled, metered** performance/world edge without putting foreign code on the evolvable `kscale` core. Pure-Aura `heph:pure-abs` provides semantic parity.
- **Mechanism**: FFI — `(c-func -1 "abs" "(Int) -> Int")` (RTLD_DEFAULT / libc)
- **Impact**: Isolated edge only; pure core load/rebind/verify does not require this call
- **Ownership / lifetime implications**: None for arena/AST ownership of pure kernels; FFI result is an immediate integer
- **Mitigation / future plan**: Keep escape on propose/edge surfaces; prefer pure-Aura when sufficient; meter via `heph:escape-count`
- **Denseness status**: **justified & isolated** (evidence *for* axis-E discipline, not against denseness of the evolvable core)

---

## Notes

- Probes **01–04** and **06** keep **core and soak paths at escapes=0**.
- Probe **05** intentionally has **edge_E > 0** while asserting **core_E=0**.
