# Denseness Report — Hephaestus

**Date:** 2026-08-07  
**Status:** **Complete + Phase 6 breadth** — probes **01–20** PASS; soak ladder through N=100; pin + kernel shapes + throughput envelope.  
**Judgment:** on scoped \(S_{\mathrm{Hephaestus}}\), \(V_A\) is **practically dense** for the evolvable / tunable core, with controlled metered edge \(E\). Phase 6 deepens Axes A / C / F without reopening the claim.

**Theory:** [aura-unify.md](aura-unify.md)  
**Prior span:** `../aether/notes/denseness-report.md` — \(S_{\mathrm{Aether}}\) practically dense (reference only)

---

## Claim

\[
P \approx A \oplus E,\quad A \in V_A
\]

| In scope | Out of scope |
|----------|--------------|
| Pure-Aura kernels (BLAS-1, stencil, matmul, gather), rebind, ownership + pin | Full ML / hard realtime / drivers |
| Fiber load + fiber mutate + concurrent dual-name rebind | Product multi-tenant platforms |
| Specialization + rebind observability + **throughput envelope** | GPU product kernels |
| Metered FFI edge (thin + hotpath volume) | Unmetered foreign code on core path |
| Soak N=25 / 50 / 100 + overnight cycles | Infinite soak |

---

## Constructive evidence

| Probe | Axes | Result | Core \(E\) | Edge \(E\) |
|-------|------|--------|------------|------------|
| [01](../examples/01-minimal-kernel/) | A F | **PASS** | 0 | 0 |
| [02](../examples/02-mutation-under-load/) | A B F | **PASS** | 0 | 0 |
| [03](../examples/03-ownership-transfer/) | A B C F | **PASS** | 0 | 0 |
| [04](../examples/04-jit-specialization/) | A B D F C | **PASS** | 0 | 0 |
| [05](../examples/05-perf-escape-boundary/) | A B C E F | **PASS** | 0 | ≥6 |
| [06](../examples/06-long-n-soak/) | A B C D F | **PASS** N=25 | 0 | 0 |
| [07](../examples/07-long-n-50/) | A B C D F | **PASS** N=50 | 0 | 0 |
| [08](../examples/08-host-anomaly-scan/) | host | **PASS** | 0 | 0 |
| [09](../examples/09-concurrent-rebind/) | A B C F | **PASS** fiber **read** + main rebind | 0 | 0 |
| [10](../examples/10-mutate-in-fiber/) | A B C F | **PASS** rebind **inside** fiber | 0 | 0 |
| [11](../examples/11-snapshot-after-fiber-mutate/) | A B C F | **PASS** dual restore after fiber mut | 0 | 0 |
| [12](../examples/12-subsecond-metrology/) | A D F | **PASS** #2655 ms metrology | 0 | 0 |
| [13](../examples/13-rebind-observability/) | B D F | **PASS** #2684 epoch/invalidate | 0 | 0 |
| [14](../examples/14-dual-spawn-binding/) | host/C | **PASS** #2685 dual spawn ids | 0 | 0 |
| [15](../examples/15-concurrent-multi-rebind/) | A B C F | **PASS** #2686 concurrent dual-name | 0 | 0 |
| [16](../examples/16-long-n-100/) | A B C D F | **PASS** N=100 | 0 | 0 |
| [17](../examples/17-ffi-hotpath-edge/) | A B C E F | **PASS** hotpath edge \(E\) volume | 0 | ≥600 |
| [18](../examples/18-dense-kernels/) | A B F | **PASS** Jacobi + matmul + gather | 0 | 0 |
| [19](../examples/19-pin-across-rebind/) | A B C F | **PASS** pin-stable-refs + rebind | 0 | 0 |
| [20](../examples/20-throughput-envelope/) | A B D F | **PASS** ratio band under rebind | 0 | 0 |

### Fiber / mutate narrative (09 · 10 · 15)

| Probe | Who mutates | Pattern |
|-------|-------------|---------|
| **09** | main | fibers only read under load |
| **10** | fiber | sequential multi-name; mut‖reader; same-name stress |
| **15** | two fibers | concurrent rebind of **distinct** names (post-#2686) |

### Phase 6 narrative (18 · 19 · 20)

| Probe | Gap closed |
|-------|------------|
| **18** | Axis A breadth: neighbourhood stencil, nested matmul, sparse gather |
| **19** | Axis C pin table: `pin-stable-refs` / `unpin-stable-refs` across alloc + rebind + restore |
| **20** | Axis F envelope: same-complexity rebind keeps throughput ratio in band; specialization stays measurable |

---

## Judgment

> On scoped \(S_{\mathrm{Hephaestus}}\), \(V_A\) is **practically dense** for the evolvable core.  
> Soak through **N=100**, fiber mutate, concurrent dual-name rebind, sub-second metrology, rebind observability, **kernel shape breadth**, **pin lifecycle**, and **throughput envelope** all hold with **core \(E=0\)**.  
> Foreign edges (**05**, **17**) are **metered and isolated**.

Constructive denseness only — not a proof over all numerical software.

### Remaining thin regions (not failures)

| Region | Status |
|--------|--------|
| SIMD / buffer FFI \(E\) | Still sample-level (scalar `abs` only) |
| 2D stencil / large GEMM | 1D Jacobi + small dense matmul only |
| Arena transfer / linear types as first-class probe | Pin table exercised; full linear surface not |

### Upstream issues (denseness mining)

| Issue | Topic | Status |
|-------|--------|--------|
| #2654 | hash grow | **fixed** |
| #2655 | monotonic-ms | **fixed** |
| #2656 | fiber positive ids | **fixed** |
| #2684 | rebind observability | **fixed** → 13 |
| #2685 | dual spawn binding | **fixed** → 14 |
| #2686 | concurrent multi-rebind | **fixed** → 15 |

---

## Reproduce

```bash
./scripts/check-structure.sh   # no binary
./scripts/run-all.sh           # full 01–20 (needs aura)
./scripts/overnight-soak.sh 3  # budgeted multi-cycle soak
```

Host residuals: [host-residuals.md](host-residuals.md).  
Escapes: [escape-log.md](escape-log.md).
