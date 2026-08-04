# Host Residuals — Hephaestus

Track packaging, CLI, environment, and Aura-host issues that are **not** denseness failures but still block clean measurement.

Format:

```
## Hn — short title
- Observed:
- Impact on probes:
- Upstream (Aura) or local fix:
- Status: open | mitigated | closed
```

---

## H1 — Internal `define` acts like simultaneous `letrec`

- **Observed:** Inside `(begin …)` / internal define scopes, dependent bindings such as `(define N 2048) (define v (make-vector N 0))` can see `N` uninitialized → zero-length / wrong vectors; later top-level defines after large `while` loads also showed unbound names.
- **Impact on probes:** Kernel probes must use **`let*`** (or top-level defines without internal-define dependency chains) for sequential binding.
- **Upstream or local fix:** Prefer `let*` in Hephaestus probes; optionally file Aura host note if simultaneous internal-define is unintended.
- **Status:** mitigated (probe style)

## H2 — `(current-time)` is whole-second wall clock

- **Observed:** Only `current-time` (Unix seconds) available; no ms/ns/monotonic primitive in host inventory used here.
- **Impact on probes:** Metrology needs large enough loads (`elapsed_s >= 1`) for meaningful ops/s; short kernels report `ops_per_s = 0`.
- **Upstream or local fix:** Use sized loads in Phase 1; finer clock would improve axis F without leaving \(V_A\) if added as a pure host prim.
- **Status:** mitigated (workload sizing)

## H3 — CLI reads program from stdin only

- **Observed:** `aura <file>` prints usage; must `aura < file.aura`.
- **Impact on probes:** `scripts/run-aura.sh` feeds stdin (aligned with Aether).
- **Upstream or local fix:** local runner.
- **Status:** closed (runner)

## H4 — Production pipeline forbids tree-walker fallback

- **Observed:** Without `AURA_PIPELINE_STRICT=0`, some pure-Aura loops fail with Issue #2213 tree-walker forbidden.
- **Impact on probes:** Runner defaults `AURA_PIPELINE_STRICT=0` (same as Aether denseness demos).
- **Upstream or local fix:** local env; long-term force-soa / pipeline completeness on Aura.
- **Status:** mitigated (runner env)

## H5 — Deep recursion hits host depth limit

- **Observed:** Tail-recursive loops beyond ~700 frames fail (`recursion depth exceeded`).
- **Impact on probes:** Hot kernels use **`while`**, not deep recursion.
- **Upstream or local fix:** local kernel style.
- **Status:** mitigated (kernel style)

## H6 — FlatHashTable capacity ≈ 8 keys

- **Observed:** Multi-entry `(hash k v …)` literals drop later keys. Even sequential `hash-set!` on a fresh `(hash)` only retains ~8 keys reliably (`ok-keys=8` in probe); further sets miss on hash-ref.
- **Impact on probes:** Metrology must not use a large process hash for stats. `hephaestus-measure` stores counters in an **alist** (`*heph-stats*`) instead.
- **Upstream or local fix:** local alist metrology; upstream hash growth if desired.
- **Status:** mitigated (measure module → alist)
