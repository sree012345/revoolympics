#!/usr/bin/env bash
# Deploy Firebase resources to the Development environment.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

EXPECTED_PROJECT="revoolympics-dev"
EXPECTED_ALIAS="dev"
FORBIDDEN_PROJECT="revoolympics-prod"

echo "=== Revo Olympics — Development Firebase deployment ==="
echo "Target project: $EXPECTED_PROJECT"
echo "Target alias:   $EXPECTED_ALIAS"

if [[ "${FIREBASE_PROJECT:-}" == "$FORBIDDEN_PROJECT" ]]; then
  echo "ERROR: Production project ID detected in FIREBASE_PROJECT."
  exit 1
fi

current_project="$(firebase use 2>/dev/null | awk '{print $NF}' || true)"
if [[ -n "$current_project" && "$current_project" != "$EXPECTED_PROJECT" && "$current_project" != "$EXPECTED_ALIAS" ]]; then
  echo "WARN: Active Firebase alias is '$current_project'. Continuing with explicit --project."
fi

ONLY="${1:-firestore,storage,functions,hosting}"

firebase deploy \
  --project "$EXPECTED_PROJECT" \
  --only "$ONLY"

echo "Development deployment complete."
