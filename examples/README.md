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
| 08 | [host-anomaly-scan](08-host-anomaly-scan/) | host | **PASS** |
| 09 | [concurrent-rebind](09-concurrent-rebind/) | A B C F | **PASS** fiber read + main rebind |
| 10 | [mutate-in-fiber](10-mutate-in-fiber/) | A B C F | **PASS** rebind inside fibers |
| 11 | [snapshot-after-fiber-mutate](11-snapshot-after-fiber-mutate/) | A B C F | **PASS** restore after fiber rebind |
| 12 | [subsecond-metrology](12-subsecond-metrology/) | A D F | **PASS** #2655 ms clock |
| 13 | [rebind-observability](13-rebind-observability/) | B D F | **PASS** #2684 epoch/invalidate |
| 14 | [dual-spawn-binding](14-dual-spawn-binding/) | host/C | **PASS** #2685 dual spawn ids |
| 15 | [concurrent-multi-rebind](15-concurrent-multi-rebind/) | A B C F | **PASS** #2686 concurrent dual-name N=20 |

## Phase map

| Phase | Probes | Focus |
|-------|--------|--------|
| **1–5** | 01–06 | Core denseness judgment — **landed** |
| **5+** | 07–12 | Soak, anomaly, fiber, subsecond — **landed** |
| **5++** | 13–15 | #2684/#2685/#2686 unlock — **landed** |
