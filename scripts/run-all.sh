#!/usr/bin/env bash
# Run full offline denseness suite (01–20). Requires Aura binary.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PROBES=(
  01-minimal-kernel
  02-mutation-under-load
  03-ownership-transfer
  04-jit-specialization
  05-perf-escape-boundary
  06-long-n-soak
  07-long-n-50
  08-host-anomaly-scan
  09-concurrent-rebind
  10-mutate-in-fiber
  11-snapshot-after-fiber-mutate
  12-subsecond-metrology
  13-rebind-observability
  14-dual-spawn-binding
  15-concurrent-multi-rebind
  16-long-n-100
  17-ffi-hotpath-edge
  18-dense-kernels
  19-pin-across-rebind
  20-throughput-envelope
)

pass=0
fail=0
failed_list=()

for p in "${PROBES[@]}"; do
  echo "======== $p ========"
  if ./scripts/run-aura.sh "examples/$p/main.aura" 2>&1 | tee "/tmp/heph-$p.log" | tail -5; then
    if rg -q "RESULT pass" "/tmp/heph-$p.log"; then
      pass=$((pass + 1))
    else
      fail=$((fail + 1))
      failed_list+=("$p")
      echo "FAIL: no RESULT pass line for $p" >&2
    fi
  else
    fail=$((fail + 1))
    failed_list+=("$p")
  fi
done

echo "======== summary ========"
echo "pass=$pass fail=$fail total=${#PROBES[@]}"
if [[ "$fail" -ne 0 ]]; then
  echo "failed: ${failed_list[*]}" >&2
  exit 1
fi
echo "ALL PASS"
