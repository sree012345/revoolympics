#!/usr/bin/env bash
# Deploy Firebase resources to Production — protected path only.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

EXPECTED_PROJECT="revoolympics-prod"
EXPECTED_ENV="production"
ALLOWED_BRANCHES=("main" "hotfix/*")
ONLY="${1:-firestore,storage,functions,hosting}"

echo "=== Revo Olympics — PRODUCTION Firebase deployment ==="
echo "Target project: $EXPECTED_PROJECT"

if [[ "${REVO_ENV:-}" != "$EXPECTED_ENV" ]]; then
  echo "ERROR: REVO_ENV must be '$EXPECTED_ENV' (current: '${REVO_ENV:-unset}')."
  exit 1
fi

branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)"
branch_ok=false
for allowed in "${ALLOWED_BRANCHES[@]}"; do
  if [[ "$branch" == $allowed ]]; then
    branch_ok=true
    break
  fi
done

if [[ "$branch_ok" != true ]]; then
  echo "ERROR: Production deploy requires main or hotfix/* branch (current: $branch)."
  exit 1
fi

if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
  echo "ERROR: Git working tree is not clean."
  exit 1
fi

if [[ "${CI:-}" != "true" && "${PRODUCTION_DEPLOY_APPROVED:-}" != "true" ]]; then
  echo "ERROR: Production deploy requires CI=true or PRODUCTION_DEPLOY_APPROVED=true."
  exit 1
fi

if [[ -z "${RELEASE_TAG:-}" ]]; then
  echo "ERROR: RELEASE_TAG is required for production deployment."
  exit 1
fi

active_project="$(firebase use prod 2>/dev/null | awk '{print $NF}' || true)"
if [[ -n "$active_project" && "$active_project" != "$EXPECTED_PROJECT" && "$active_project" != "prod" ]]; then
  echo "ERROR: Firebase prod alias does not resolve to $EXPECTED_PROJECT."
  exit 1
fi

echo "Branch: $branch"
echo "Release tag: $RELEASE_TAG"
echo "Deploy targets: $ONLY"

firebase deploy \
  --project "$EXPECTED_PROJECT" \
  --only "$ONLY"

echo "Production deployment complete."
