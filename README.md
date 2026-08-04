# Hephaestus

**Performance / Numerical / Systems Kernel denseness probe on Aura — the second concrete span of Aura Unify.**

Hephaestus is not a general-purpose numerical library and not a reimplementation of high-performance runtimes.
It is the second **concrete span project** of [Aura Unify](notes/aura-unify.md):
an empirical test of whether Aura’s native space \(V_A\) can densely cover the
high-performance, numerical, and systems-kernel region of practical software.

> Aura supplies a machine-friendly basis.  
> Aether showed denseness on the agent + mutation closed-loop subspace.  
> Hephaestus asks whether the same basis remains dense when the primary
> computational objects are **hot paths, kernels, memory-bound loops,
> ownership under concurrent mutation, and performance-critical code**.

**Read first (theory):** [`notes/aura-unify.md`](notes/aura-unify.md) — Aura Unify 总论（语义空间、span 程序、与 Aether / 本仓的关系）。

## The subspace Hephaestus claims: \(S_{\mathrm{Hephaestus}}\)

Hephaestus does **not** try to prove \(V_A \approx S_{\mathrm{practical}}\).
It claims only a high-leverage systems/performance subspace:

\[
S_{\mathrm{Hephaestus}} \subset S_{\mathrm{practical}}
\]

**Systems whose primary computational objects are performance-critical kernels,
numerical loops, memory hierarchies, concurrent mutation under load,
and tunable hot paths** — where correctness, ownership, and observability
must survive high throughput and frequent self-modification.

A system is in \(S_{\mathrm{Hephaestus}}\) when it simultaneously has:

1. **Kernel / hot path as first-class object** — loops, data-parallel bodies, memory layouts, specialization points  
2. **Mutation under load** — safe rebind / hot-swap of kernels while the system continues to produce correct results  
3. **Ownership & lifetime discipline** — linear / affine ownership, arena, pin, and transfer across mutation boundaries  
4. **Performance observability as semantics** — latency, throughput, allocation, escape cost are first-class  
5. **Controlled performance escape set \(E\)** — true hardware / SIMD / C++/Rust kernels live in a metered, capability-gated boundary

### Denseness proposition (defensible form)

> On \(S_{\mathrm{Hephaestus}}\), \(V_A\) is dense for the **evolvable / tunable core**:  
> the majority of numerical and systems logic (including mutation of kernels)
> stays in pure Aura; necessary escapes \(E\) are rare, metered, ownership-safe,
> and do not destroy performance observability or post-mutation correctness.

If this subspace cannot achieve low escape rates on hot paths while preserving
ownership and correctness under mutation, the broader Unify thesis is weakened
at its second highest-leverage engineering point.

### Explicitly out of scope (initial phases)

| Out of scope | Why |
|--------------|-----|
| Full ML training frameworks / autograd | Later global pressure tests |
| Hard realtime OS kernels / MMIO drivers | Different safety regime |
| Rebuilding Aura’s JIT / ownership machinery | Aura already provides the basis |
| Proving universal denseness of all numerical code | Constructive measurement only |

## Canonical performance denseness loop

```
Specialize / Bind Kernel  →  Run under load  →  Observe metrics  →
Safe Mutation / Rebind    →  Verify correctness + performance  →
Rollback (if needed)      →  Specialize / Bind
```

Invariants we care about:

- Mutation of kernels only through typed / ownership-guarded / boundary-checked paths  
- Full observability of latency, throughput, allocation, escape cost  
- Ownership transfer and lifetime remain sound across rebind  
- Rollback restores both semantic state *and* performance envelope  
- Evolvable core stays in pure Aura; raw hardware / SIMD / foreign kernels are thin, audited \(E\)

## Orthogonal axes inside \(S_{\mathrm{Hephaestus}}\)

| Axis | Question |
|------|----------|
| **A. Kernel completeness** | Can a realistic hot path (loop, reduction, stencil, sparse, etc.) live mostly in \(V_A\)? |
| **B. Mutation under load** | Can we safely rebind / specialize a kernel while the system is running and still stay correct? |
| **C. Ownership & memory** | Do linear ownership, arenas, pins, and transfers survive high-throughput concurrent mutation? |
| **D. JIT & specialization** | Does incremental compilation + hot-swap deliver usable performance without leaving \(V_A\)? |
| **E. Performance boundary** | Can true high-performance escapes (C++/Rust/SIMD) be isolated, ownership-safe, and metered? |
| **F. Metrology** | Escape rate on hot path, throughput regression under mutation, correctness after rollback |

## Relationship to Aura and Aether

| Layer | Owner | Role |
|-------|--------|------|
| Runtime, typed mutation, ownership, JIT, fibers, arenas | Aura (`../aura-grok`) | Basis \(V_A\) |
| Thin stdlib surfaces (`mutate`, `query`, `hot-update`, `workspace`, ownership helpers, …) | Aura | Callable operators |
| Agent closed-loop denseness evidence | [Aether](../aether) (`../aether`) | First span (Dim 1+2) — *practically dense* on \(S_{\mathrm{Aether}}\) |
| **Performance / numerical / systems-kernel denseness evidence** | **Hephaestus** | Second span |

Hephaestus **composes** Aura surfaces. It does not fork the engine.
It **does not re-prove** Aether’s agent subspace; it pressure-tests the next high-leverage region under the same Unify discipline (escape log, denseness report, pure-Aura preference on the evolvable core).

Local development is expected against an Aura checkout (default `../aura-grok` via `scripts/run-aura.sh`):

```bash
./scripts/run-aura.sh examples/01-minimal-kernel/main.aura
```

### Documents

| Doc | Purpose |
|-----|---------|
| [`notes/aura-unify.md`](notes/aura-unify.md) | Aura Unify theory + span program |
| [`notes/denseness-report.md`](notes/denseness-report.md) | Evidence & judgment on \(S_{\mathrm{Hephaestus}}\) |
| [`notes/escape-log.md`](notes/escape-log.md) | Required log of leaves from \(V_A\) |
| [`notes/host-residuals.md`](notes/host-residuals.md) | Host/packaging issues (not denseness failures) |
| [`prompts/GROK.md`](prompts/GROK.md) | Living agent prompt |
| [`../aether/notes/denseness-report.md`](../aether/notes/denseness-report.md) | Prior span denseness judgment |

## Practical denseness criteria (tunable)

| Metric | Suggested threshold | Meaning |
|--------|---------------------|---------|
| Hot-path escape rate | low / measurable | By critical path, not whole program |
| Correctness after mutation + load | ≈ 100% | No silent wrong answers |
| Ownership / lifetime violations | 0 | Under concurrent rebind |
| Throughput regression under safe mutation | bounded & reported | Performance envelope preserved or explained |
| Rollback restores both state *and* metrics baseline | yes | Dual correctness |

**Failure modes** (pre-declared):

- Hot path *requires* unguarded foreign code → denseness claim collapses  
- Mutation of kernel breaks ownership or introduces data races → safety failure  
- Performance only achievable by leaving observability behind → metrology failure  

## Project structure (initial)

```
hephaestus/
├── README.md
├── LICENSE
├── scripts/
│   └── run-aura.sh
├── lib/
│   ├── hephaestus-min.aura      # Phase-1 facade (A+F)
│   ├── hephaestus-kernel.aura   # pure-Aura numerical kernels
│   ├── hephaestus-measure.aura  # stats / wall-time metrology
│   └── README.md
├── examples/
│   ├── _template/
│   ├── 01-minimal-kernel/       # Phase 1 denseness probe
│   └── 02-mutation-under-load/  # Phase 2 denseness probe
├── notes/
│   ├── aura-unify.md        # Unify theory (read first)
│   ├── escape-log.md
│   ├── denseness-report.md
│   └── host-residuals.md
└── prompts/
    └── GROK.md
```

## Span order (planned)

| Phase | Focus |
|-------|--------|
| **1** | Minimal pure-Aura numerical kernels + baseline metrology |
| **2** | Mutation / rebind of kernels under controlled load |
| **3** | Ownership transfer + concurrent mutation safety |
| **4** | Controlled performance escapes (FFI / SIMD) + denseness accounting |
| **5** | Longer soak, regression under continuous mutation, first denseness report |

## Escape discipline

Every leave from pure Aura (\(V_A\)) on a performance-critical path must be recorded in `notes/escape-log.md`:

- Location, reason, mechanism (FFI / SIMD / external kernel / other)  
- Impact (correctness vs pure performance)  
- Ownership / lifetime implications  
- Mitigation or future plan  

Escapes on the evolvable / tunable core are treated as **evidence against** denseness until justified and isolated.

## License

Apache License 2.0 (same as Aura and Aether)

## Status

**Phase 1–2 landed.** Probes **01** (kernels + metrology) and **02** (mutation under load + rollback) both PASS with escapes=0.

```bash
./scripts/run-aura.sh examples/01-minimal-kernel/main.aura
./scripts/run-aura.sh examples/02-mutation-under-load/main.aura
```

Hephaestus continues the constructive measurement program of Aura Unify:
after Aether established denseness on the agent + mutation closed-loop subspace,
we now pressure-test the same basis against the second highest-leverage region —
performance, numerical kernels, and systems hot paths.

See [`notes/denseness-report.md`](notes/denseness-report.md).
