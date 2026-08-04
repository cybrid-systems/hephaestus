# Hephaestus Probes

Each probe is a self-contained denseness experiment.

## Conventions

- Copy `_template/` to start a new probe: `examples/NN-short-name/`
- Probe should be runnable via:
  ```bash
  ./scripts/run-aura.sh examples/NN-short-name/main.aura
  ```
- Prefer pure-Aura code on the critical path. Any escape must be logged in `notes/escape-log.md`.
- Report metrics (throughput, correctness, ownership events, escape count) clearly.

## Probe Index (planned)

| # | Name | Axes | Status |
|---|------|------|--------|
| 01 | minimal-kernel | A F | planned |
| 02 | mutation-under-load | A B F | planned |
| 03 | ownership-transfer | C | planned |
| … | … | … | … |

Add new probes to this table when they land.
