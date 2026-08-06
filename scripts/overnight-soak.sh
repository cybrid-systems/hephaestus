#!/usr/bin/env bash
# Budgeted denseness soak: repeat N=100 soak + concurrent multi-rebind.
# Usage: ./scripts/overnight-soak.sh [cycles=3]
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

CYCLES="${1:-3}"
echo "[overnight] cycles=$CYCLES"

for c in $(seq 1 "$CYCLES"); do
  echo "======== overnight cycle $c / $CYCLES ========"
  ./scripts/run-aura.sh examples/16-long-n-100/main.aura
  ./scripts/run-aura.sh examples/15-concurrent-multi-rebind/main.aura
  ./scripts/run-aura.sh examples/11-snapshot-after-fiber-mutate/main.aura
done

echo "[overnight] ALL $CYCLES cycles PASS"
