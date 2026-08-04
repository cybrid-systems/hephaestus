# Hephaestus Probes

Each probe is a self-contained denseness experiment.

## Conventions

- Copy `_template/` to start a new probe: `examples/NN-short-name/`
- Run via:
  ```bash
  ./scripts/run-aura.sh examples/NN-short-name/main.aura
  ```
- Prefer pure-Aura on the critical path. Any escape → `notes/escape-log.md`.
- Report metrics (throughput, correctness, ownership events, escape count) clearly.
- Prefer offline probes; print a final `RESULT pass|fail example=…` line.

## Probe index

| # | Name | Axes | Status |
|---|------|------|--------|
| 01 | [minimal-kernel](01-minimal-kernel/) | A F | **PASS** |
| 02 | [mutation-under-load](02-mutation-under-load/) | A B F | **PASS** |
| 03 | [ownership-transfer](03-ownership-transfer/) | A B C F | **PASS** |
| 04 | jit-specialization (planned) | A D F | planned |

## Phase map (aligned with README)

| Phase | Probes | Focus |
|-------|--------|--------|
| **1** | 01 | Pure-Aura kernels + baseline metrology — **landed** |
| **2** | 02 | Mutation / rebind under controlled load — **landed** |
| **3** | 03 | Ownership / AST integrity under alloc + rebind — **landed** |
| **4** | 04… | JIT specialization / controlled performance \(E\) |
| **5** | … | Soak + denseness report |
