#!/usr/bin/env bash
# Deploy Firebase resources to the Staging environment.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

EXPECTED_PROJECT="revoolympics-staging"
ALLOWED_BRANCHES=("develop" "release" "release/*")
ONLY="${1:-firestore,storage,functions,hosting}"

echo "=== Revo Olympics — Staging Firebase deployment ==="
echo "Target project: $EXPECTED_PROJECT"

branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
branch_ok=false
for allowed in "${ALLOWED_BRANCHES[@]}"; do
  if [[ "$branch" == $allowed ]]; then
    branch_ok=true
    break
  fi
done

if [[ "$branch_ok" != true ]]; then
  echo "ERROR: Staging deploy requires develop or release branch (current: $branch)."
  exit 1
fi

if [[ "${FIREBASE_PROJECT:-}" == "revoolympics-prod" ]]; then
  echo "ERROR: Production project ID is not allowed for staging deploy."
  exit 1
fi

firebase deploy \
  --project "$EXPECTED_PROJECT" \
  --only "$ONLY"

echo "Staging deployment complete."
