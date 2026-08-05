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

- **Observed (historical):** Only `current-time` (Unix seconds); short kernels reported `elapsed=0`.
- **Impact on probes:** Metrology needed large loads (`elapsed_s >= 1`) for ops/s.
- **Upstream fix:** [aura#2655](https://github.com/cybrid-systems/aura/issues/2655) shipped `(current-time-ms)` + `(monotonic-ms)`; `heph:time-call` now uses **monotonic-ms** (`lib/hephaestus-measure.aura`).
- **Status:** **closed** (upstream #2655 + Hephaestus measure wired)

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

- **Observed (historical):** Multi-entry `(hash k v …)` / `hash-set!` dropped keys past capacity 8.
- **Upstream:** [aura#2654](https://github.com/cybrid-systems/aura/issues/2654) **fixed** (`e5f6b207` grow/rehash). Verified: ok=16 fail=0, literal 10-key hash OK on denseness binary.
- **Hephaestus:** `hephaestus-measure` **migrated back to process hash** (v6); `examples/08` reports `HOST_OK id=A-hash`.
- **Status:** **closed** (upstream fixed + local migrate)
- **Note:** Need aura built at/after #2654; stale binaries still fail 08/hash paths.

## H7 — Compile / JIT dirty & stats surfaces sparse

- **Observed:** After pure-Aura `mutate:rebind` specialization, `compile:block-dirty-count` stays 0; `compile:jit-stats` / `stats:get "compile:jit-stats"` often empty; `hot-swap:fn` returned `#f` in smoke tests.
- **Impact on probes:** Axis D denseness is measured via **correctness under load after algorithmic rebind**, not via host JIT counter deltas. Host may still JIT underneath without exposing counters.
- **Upstream:** **filed** [aura#2684](https://github.com/cybrid-systems/aura/issues/2684)
- **Status:** mitigated (probe design) / **upstream open #2684**

## H8 — Free-var capture from `let*` into internal `define` helpers

- **Observed:** Helpers defined with `(define (f) … N …)` inside a `let*` that binds `N` can see `N` as 0/unusable at call time in some host configurations (map-load returned 0 until literals were inlined). Not always reproducible in minimal repros.
- **Impact on probes:** Prefer **literals** or globals for hot helpers; avoid relying on free capture of let*-locals in denseness kernels.
- **Upstream or local fix:** local probe style; file separate issue if a minimal stable repro appears.
- **Status:** mitigated (probe style)

## H9 — `fiber:spawn` returns -1 (concurrent denseness blocked)

- **Observed (historical):** Thread-fallback ids started at `-1`; denseness treated first spawn as failure.
- **Upstream:** [aura#2656](https://github.com/cybrid-systems/aura/issues/2656) **fixed** (`f97c3382` positive `0x4000_0000|seq` ids + `fiber:spawn-backend`).
- **Hephaestus:** `examples/09-concurrent-rebind` PASS; `10-mutate-in-fiber` PASS; `08` reports `HOST_OK id=A-fiber`.
- **Status:** **closed** (upstream fixed + probes 09–10)
- **Related (still open):** top-level simultaneous `define` of two spawns can alias ids — **filed** [aura#2685](https://github.com/cybrid-systems/aura/issues/2685); probes use `let*`.

## H10 — Concurrent multi-name rebind from two fibers unstable

- **Observed:** Two fibers calling `heph:rebind-safe` / `mutate:rebind` on **distinct** names at the same time can: empty `fiber:join`, **unbound name** after reported apply, or **SIGABRT** (`FlatAST::get` id assert).
- **Impact:** Denseness PASS path for multi-name mutate-in-fiber is **sequential** fiber rebinds (spawn+join per name).
- **Upstream:** **filed** [aura#2686](https://github.com/cybrid-systems/aura/issues/2686) (P1)
- **Status:** mitigated (probe design) / **upstream open #2686**
- **Probe:** `examples/10-mutate-in-fiber`
