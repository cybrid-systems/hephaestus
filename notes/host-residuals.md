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
- **Phase 6 repro (stable):** After `vector-set!` / kernel fill, `(define ok (= (vector-ref out …) …))` yields `#f` while a later `(vector-ref out …)` is correct — define inits see pre-mutation state.
- **Impact on probes:** Kernel probes must use **`let*`** (or top-level defines without internal-define dependency chains) for sequential binding.
- **Upstream:** [aura#2740](https://github.com/cybrid-systems/aura/issues/2740)
- **Status:** mitigated (probe style); **filed**

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

- **Observed (historical):** Probes read sticky dirty **after** `eval-current` (often 0) or wrong surfaces.
- **Upstream:** [aura#2684](https://github.com/cybrid-systems/aura/issues/2684) **closed** — contract: pre-eval dirty and/or lifetime `compile:epoch` / `query:jit-stats-hash` invalidate counters.
- **Hephaestus:** `examples/13-rebind-observability` asserts epoch/invalidate bump + correctness.
- **Status:** **closed**

## H8 — Free-var capture from `let*` into internal `define` helpers

- **Observed:** Helpers defined with `(define (f) … N …)` inside a `let*` that binds `N` can see `N` as 0/unusable at call time in some host configurations (map-load returned 0 until literals were inlined). Not always reproducible in minimal repros.
- **Phase 6:** probe 19 load returned 0 until buffer was a **top-level global** (`heph19-vx`); free-capture of `let*` vector under denseness packaging unreliable. Interacts with **H1**.
- **Impact on probes:** Prefer **literals** or globals for hot helpers; avoid relying on free capture of let*-locals in denseness kernels.
- **Upstream:** [aura#2739](https://github.com/cybrid-systems/aura/issues/2739)
- **Status:** mitigated (probe style); **filed**

## H9 — `fiber:spawn` returns -1 (concurrent denseness blocked)

- **Observed (historical):** Thread-fallback ids started at `-1`; denseness treated first spawn as failure.
- **Upstream:** [aura#2656](https://github.com/cybrid-systems/aura/issues/2656) **fixed** (`f97c3382` positive `0x4000_0000|seq` ids + `fiber:spawn-backend`).
- **Hephaestus:** `examples/09-concurrent-rebind` PASS; `10-mutate-in-fiber` PASS; `08` reports `HOST_OK id=A-fiber`.
- **Status:** **closed** (upstream fixed + probes 09–10)
- **Related:** [aura#2685](https://github.com/cybrid-systems/aura/issues/2685) **closed** — multi-define begin dual spawn → distinct ids; probe `examples/14-dual-spawn-binding`.

## H10 — Concurrent multi-name rebind from two fibers unstable

- **Observed (historical):** Concurrent distinct-name rebind could crash / empty join / unbind.
- **Upstream:** [aura#2686](https://github.com/cybrid-systems/aura/issues/2686) **closed** — exclusive workspace lock serializes rebind vs eval-current.
- **Hephaestus:** `examples/15-concurrent-multi-rebind` N=20 dual-name concurrent trials PASS when host does not abort.
- **Status:** **closed** (contract); residual flake → **H11**

## H11 — Intermittent host abort in concurrent multi-rebind (probe 15)

- **Observed (2026-08-07):** `examples/15-concurrent-multi-rebind` usually **PASS** (20/20 trials), but occasionally **SIGABRT** mid-run:
  - `contract violation: assert … FlatAST::get … id < sym_id_.size()` at `ast.ixx:4480`
  - or `std::vector::operator[]` / `std::span::operator[]` assert
  - often after `[fiber:join] WARN: workspace mutated during join`
- **Impact on probes:** Suite can report fail=1 on 15 without denseness logic regression; re-run 15 alone usually PASS. Phase 6 probes 18–20 unaffected.
- **Upstream:** [aura#2738](https://github.com/cybrid-systems/aura/issues/2738) (follow-up to closed #2686). Do **not** treat as \(S_{\mathrm{Hephaestus}}\) denseness collapse when RESULT pass is otherwise observed.
- **Status:** open (host flake); **filed**
