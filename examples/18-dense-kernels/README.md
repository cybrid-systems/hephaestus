# 18 — Dense numerical kernels (stencil / matmul / gather)

**Axes:** A B F (+ C checks)  
**Escapes:** 0  
**Phase:** 6 — broaden Axis A beyond BLAS-1 fragments

## What it proves

| Shape | Check |
|-------|--------|
| `heph:jacobi1d!` | 1D Jacobi stencil neighbourhood access + multi-step load |
| `heph:matmul!` | Dense n×n matmul (`I * B = B`) under load |
| `heph:gather-sum` | Sparse / indirect indexing correctness |
| Rebind | `kscale` ×2→×3 scales gather path; ownership OK |

Pure-Aura evolvable core; no FFI.

## Run

```bash
./scripts/run-aura.sh examples/18-dense-kernels/main.aura
```

Expect:

```
PASS: stencil+matmul+gather pure-Aura denseness (escapes=0)
RESULT pass example=18-dense-kernels escapes=0
```
