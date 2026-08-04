#!/usr/bin/env bash
# Host runner for Hephaestus probes.
# Expects an Aura checkout nearby (default: ../aura or via AURA_PATH).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Default Aura locations to try
if [[ -z "${AURA_PATH:-}" ]]; then
  if [[ -d "${ROOT_DIR}/../aura" ]]; then
    export AURA_PATH="${ROOT_DIR}/../aura"
  elif [[ -d "${ROOT_DIR}/../aura-grok" ]]; then
    export AURA_PATH="${ROOT_DIR}/../aura-grok"
  else
    echo "error: set AURA_PATH to an Aura checkout" >&2
    exit 1
  fi
fi

export AURA_SANDBOX="${AURA_SANDBOX:-off}"
export AURA_PIPELINE_STRICT="${AURA_PIPELINE_STRICT:-0}"

# Prefer the Aura binary from the checkout
AURA_BIN="${AURA_PATH}/build/aura"
if [[ ! -x "${AURA_BIN}" ]]; then
  AURA_BIN="$(command -v aura || true)"
fi

if [[ -z "${AURA_BIN}" || ! -x "${AURA_BIN}" ]]; then
  echo "error: cannot find aura binary (looked in ${AURA_PATH}/build/aura)" >&2
  exit 1
fi

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <probe.aura> [args...]" >&2
  exit 1
fi

PROBE="$1"
shift

echo "[hephaestus] AURA_PATH=${AURA_PATH}"
echo "[hephaestus] running: ${PROBE}"
exec "${AURA_BIN}" "${PROBE}" "$@"
