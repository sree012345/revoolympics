#!/usr/bin/env bash
# Verify Revo Olympics repository structure after clone (Sprint F0.4)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

errors=0

check_dir() {
  if [[ ! -d "$1" ]]; then
    echo "MISSING: $1"
    errors=$((errors + 1))
  fi
}

check_file() {
  if [[ ! -f "$1" ]]; then
    echo "MISSING: $1"
    errors=$((errors + 1))
  fi
}

echo "Verifying revoolympics repository structure..."

check_dir apps/player_app
check_dir apps/admin_web
check_dir apps/spectator_hub
check_dir unity/shared_bridge
check_dir unity/game_templates/portrait_game_template
check_dir unity/game_templates/landscape_game_template
check_dir unity/games
check_dir firebase/functions
check_dir firebase/firestore
check_dir firebase/storage
check_dir firebase/hosting
check_dir firebase/seed
check_dir tools/webgl_validator
check_dir tools/build_publisher
check_dir tools/localization_validator
check_dir docs/product
check_dir docs/development
check_dir .github/workflows
check_dir .cursor/rules

check_file .gitignore
check_file .gitattributes
check_file .env.example
check_file .firebaserc.example
check_file firebase.json
check_file melos.yaml
check_file README.md
check_file CONTRIBUTING.md
check_file SECURITY.md

# Secret patterns that must not appear committed
if git grep -l 'firebase-adminsdk' -- ':!*.md' ':!scripts/**' 2>/dev/null; then
  echo "ERROR: Possible service account reference in tracked files"
  errors=$((errors + 1))
fi

if [[ -f .env ]]; then
  echo "WARN: .env exists locally (should not be committed)"
fi

if [[ $errors -eq 0 ]]; then
  echo "OK: Repository structure verification passed."
  exit 0
else
  echo "FAILED: $errors issue(s) found."
  exit 1
fi
