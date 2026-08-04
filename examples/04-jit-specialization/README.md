# 04 — Pure-Aura specialization (JIT axis denseness)

**Axes:** A + B + D + F (+ C checks)  
**Escapes:** 0

## What it proves

Specialization of the evolvable core can stay inside \(V_A\):

| Step | Specialization | Check |
|------|----------------|--------|
| S1 | `sum-kernel` = iterative \(i^2\) sum | matches closed form under load |
| S2 | rebind → closed-form body | same results; ownership OK |
| S3 | `kscale` chain: ×2 → ×3 → fused `(+ x x x)` → ×5 | load correctness after each rebind |
| S4 | restore snapshot from S2 | sum-kernel recovers; ownership OK |

Host JIT / `compile:*-dirty` / `compile:jit-stats` observability may be sparse on the current host (**H7**). This probe does **not** require reading those counters to claim denseness: the claim is that **algorithm specialization via typed rebind** needs no foreign kernel \(E\).

## Run

```bash
./scripts/run-aura.sh examples/04-jit-specialization/main.aura
```

Expect:

```
PASS: pure-Aura specialization chain under load (escapes=0)
RESULT pass example=04-jit-specialization escapes=0
```
