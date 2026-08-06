#!/usr/bin/env bash
# Structure checks — no Aura binary required.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail=0
need() {
  if [[ ! -e "$1" ]]; then
    echo "MISSING: $1" >&2
    fail=1
  fi
}

need README.md
need LICENSE
need notes/aura-unify.md
need notes/denseness-report.md
need notes/escape-log.md
need notes/host-residuals.md
need prompts/GROK.md
need scripts/run-aura.sh
need scripts/run-all.sh
need lib/hephaestus-min.aura
need lib/hephaestus-measure.aura
need lib/hephaestus-kernel.aura
need lib/hephaestus-mutate.aura
need lib/hephaestus-own.aura
need lib/hephaestus-escape.aura
need examples/README.md

for n in 01-minimal-kernel 02-mutation-under-load 03-ownership-transfer \
         04-jit-specialization 05-perf-escape-boundary 06-long-n-soak \
         07-long-n-50 08-host-anomaly-scan 09-concurrent-rebind \
         10-mutate-in-fiber 11-snapshot-after-fiber-mutate 12-subsecond-metrology \
         13-rebind-observability 14-dual-spawn-binding 15-concurrent-multi-rebind \
         16-long-n-100 17-ffi-hotpath-edge; do
  need "examples/$n/main.aura"
done

if [[ ! -x scripts/run-aura.sh ]]; then
  echo "WARN: scripts/run-aura.sh not executable" >&2
fi

if [[ "$fail" -ne 0 ]]; then
  echo "structure: FAIL" >&2
  exit 1
fi
echo "structure: PASS"
