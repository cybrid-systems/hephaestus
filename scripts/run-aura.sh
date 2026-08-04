#!/usr/bin/env bash
# Run a Hephaestus .aura probe against a local Aura host binary.
#
# Usage (from hephaestus repo root):
#   ./scripts/run-aura.sh examples/01-minimal-kernel/main.aura
#
# Env overrides:
#   AURA_BIN   path to aura binary (default: ../aura-grok/build/aura)
#   AURA_LIB   path to Aura lib/ containing std/ (default: ../aura-grok/lib)
#   HEPHAESTUS_LIB  path to this repo's lib/ (default: <repo>/lib)

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

AURA_BIN="${AURA_BIN:-$ROOT/../aura-grok/build/aura}"
AURA_LIB="${AURA_LIB:-$ROOT/../aura-grok/lib}"
HEPHAESTUS_LIB="${HEPHAESTUS_LIB:-$ROOT/lib}"

if [[ ! -x "$AURA_BIN" ]]; then
  # Fallbacks: sibling aura checkout or PATH
  if [[ -x "$ROOT/../aura/build/aura" ]]; then
    AURA_BIN="$ROOT/../aura/build/aura"
  elif command -v aura >/dev/null 2>&1; then
    AURA_BIN="$(command -v aura)"
  else
    echo "error: aura binary not found or not executable: $AURA_BIN" >&2
    echo "  build aura-grok or set AURA_BIN" >&2
    exit 1
  fi
fi

if [[ ! -d "$AURA_LIB/std" ]]; then
  echo "error: Aura stdlib not found under: $AURA_LIB/std" >&2
  echo "  set AURA_LIB to the directory that contains std/" >&2
  exit 1
fi

if [[ ! -d "$HEPHAESTUS_LIB" ]]; then
  echo "error: Hephaestus lib not found: $HEPHAESTUS_LIB" >&2
  exit 1
fi

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <probe.aura>" >&2
  exit 1
fi

SRC="$1"
if [[ ! -f "$SRC" ]]; then
  echo "error: file not found: $SRC" >&2
  exit 1
fi

# CLI denseness demos: sandbox off; pipeline strict 0 for tree-walker fallback
# on hosts that need it (same discipline as Aether).
export AURA_PATH="${AURA_PATH:-$AURA_LIB:$HEPHAESTUS_LIB}"
export AURA_SANDBOX="${AURA_SANDBOX:-off}"
export AURA_PIPELINE_STRICT="${AURA_PIPELINE_STRICT:-0}"

echo "[hephaestus] AURA_BIN=${AURA_BIN}"
echo "[hephaestus] AURA_PATH=${AURA_PATH}"
echo "[hephaestus] running: ${SRC}"

# Host expects program on stdin (not argv).
exec "$AURA_BIN" < "$SRC"
