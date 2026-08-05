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
| 04 | [jit-specialization](04-jit-specialization/) | A B D F C | **PASS** |
| 05 | [perf-escape-boundary](05-perf-escape-boundary/) | A B C E F | **PASS** (core \(E\)=0, edge metered) |
| 06 | [long-n-soak](06-long-n-soak/) | A B C D F | **PASS** N=25 |
| 07 | [long-n-50](07-long-n-50/) | A B C D F | **PASS** N=50 |
| 08 | [host-anomaly-scan](08-host-anomaly-scan/) | host | **PASS** (hash/fiber OK after #2654/#2656; H2 clock fixed #2655) |
| 09 | [concurrent-rebind](09-concurrent-rebind/) | A B C F | **PASS** fiber fanout + main rebind |
| 10 | [mutate-in-fiber](10-mutate-in-fiber/) | A B C F | **PASS** rebind inside fibers |
| 11 | [snapshot-after-fiber-mutate](11-snapshot-after-fiber-mutate/) | A B C F | **PASS** restore after fiber rebind |
| 12 | [subsecond-metrology](12-subsecond-metrology/) | A D F | **PASS** ms clock + short-path ops/s (#2655) |

## Phase map (aligned with README)

| Phase | Probes | Focus |
|-------|--------|--------|
| **1** | 01 | Pure-Aura kernels + baseline metrology — **landed** |
| **2** | 02 | Mutation / rebind under controlled load — **landed** |
| **3** | 03 | Ownership / AST integrity under alloc + rebind — **landed** |
| **4** | 04 | Pure-Aura specialization under load — **landed** |
| **5** | 05–06 | Controlled \(E\) boundary + soak + **denseness judgment** — **landed** |
| **5+** | 07–08 | N=50 soak + host anomaly scan — **landed** |
| **5++** | 09 | Concurrent fiber load + main rebind (#2656) — **landed** |
| **5++** | 10 | Mutate-in-fiber rebind denseness — **landed** |
| **5++** | 11 | Snapshot/restore after fiber mutate — **landed** |
| **5++** | 12 | Sub-second metrology denseness (#2655) — **landed** |
| **meta** | measure | Hash stats (#2654) + monotonic-ms (#2655) — **landed** |
