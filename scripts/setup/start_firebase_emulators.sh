#!/usr/bin/env bash
# Start Firebase emulators for local development.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

PROJECT="${FIREBASE_PROJECT_ID:-revoolympics-dev}"
IMPORT_DIR="$ROOT/firebase/emulators/import"

echo "Starting Firebase emulators for project: $PROJECT"

args=(emulators:start --project "$PROJECT")
if [[ -d "$IMPORT_DIR" && -n "$(ls -A "$IMPORT_DIR" 2>/dev/null || true)" ]]; then
  args+=(--import="$IMPORT_DIR")
fi

firebase "${args[@]}"
