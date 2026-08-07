# Hephaestus Probes

Each probe is a self-contained denseness experiment.

## Conventions

- Copy `_template/` → `examples/NN-short-name/`
- Run: `./scripts/run-aura.sh examples/NN-short-name/main.aura`
- Full suite: `./scripts/run-all.sh`
- Structure only: `./scripts/check-structure.sh`
- Overnight: `./scripts/overnight-soak.sh [cycles]`

## Probe index

| # | Name | Axes | Status |
|---|------|------|--------|
| 01 | [minimal-kernel](01-minimal-kernel/) | A F | **PASS** |
| 02 | [mutation-under-load](02-mutation-under-load/) | A B F | **PASS** |
| 03 | [ownership-transfer](03-ownership-transfer/) | A B C F | **PASS** |
| 04 | [jit-specialization](04-jit-specialization/) | A B D F C | **PASS** |
| 05 | [perf-escape-boundary](05-perf-escape-boundary/) | A B C E F | **PASS** thin edge \(E\) |
| 06 | [long-n-soak](06-long-n-soak/) | A B C D F | **PASS** N=25 |
| 07 | [long-n-50](07-long-n-50/) | A B C D F | **PASS** N=50 |
| 08 | [host-anomaly-scan](08-host-anomaly-scan/) | host | **PASS** |
| 09 | [concurrent-rebind](09-concurrent-rebind/) | A B C F | **PASS** fiber **read** + main rebind |
| 10 | [mutate-in-fiber](10-mutate-in-fiber/) | A B C F | **PASS** rebind **inside** fiber (sequential multi-name) |
| 11 | [snapshot-after-fiber-mutate](11-snapshot-after-fiber-mutate/) | A B C F | **PASS** restore after fiber rebind |
| 12 | [subsecond-metrology](12-subsecond-metrology/) | A D F | **PASS** #2655 |
| 13 | [rebind-observability](13-rebind-observability/) | B D F | **PASS** #2684 |
| 14 | [dual-spawn-binding](14-dual-spawn-binding/) | host/C | **PASS** #2685 |
| 15 | [concurrent-multi-rebind](15-concurrent-multi-rebind/) | A B C F | **PASS** #2686 concurrent dual-name |
| 16 | [long-n-100](16-long-n-100/) | A B C D F | **PASS** N=100 |
| 17 | [ffi-hotpath-edge](17-ffi-hotpath-edge/) | A B C E F | **PASS** hot edge \(E\) volume |
| 18 | [dense-kernels](18-dense-kernels/) | A B F | **PASS** stencil + matmul + gather |
| 19 | [pin-across-rebind](19-pin-across-rebind/) | A B C F | **PASS** pin-stable-refs lifecycle |
| 20 | [throughput-envelope](20-throughput-envelope/) | A B D F | **PASS** bounded rebind throughput ratio |

### Fiber / mutate narrative (09 · 10 · 15)

| Probe | Who mutates | Concurrency |
|-------|-------------|-------------|
| **09** | **main only** | fibers only **read** `kscale` under load |
| **10** | **fiber** | sequential multi-name; mut‖reader; same-name stress |
| **15** | **two fibers** | concurrent rebind of **distinct** names (post-#2686) |

## Phase map

| Phase | Probes | Focus |
|-------|--------|--------|
| **1–5** | 01–06 | Core denseness judgment |
| **5+** | 07–12 | Soak ladder, anomaly, fiber, ms metrology |
| **5++** | 13–15 | #2684–#2686 unlock |
| **complete** | 16–17 | N=100 soak + hotpath \(E\) |
| **6** | 18–20 | Kernel breadth + pin + throughput envelope |
