#!/usr/bin/env bash
# Verify Revo Olympics repository structure after clone (Sprint F0.4 + F0.5 + F0.6)
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
check_dir firebase/seed/development
check_dir firebase/seed/staging
check_dir firebase/seed/production
check_dir firebase/environments/development
check_dir firebase/environments/staging
check_dir firebase/environments/production
check_dir firebase/emulators
check_dir firebase/hosting/player
check_dir apps/player_app/lib/core/environment
check_dir apps/admin_web/lib/core/environment
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
check_file .firebaserc
check_file firebase.json
check_file docs/architecture/firebase_environment_architecture.md
check_file docs/development/firebase_environment_setup.md
check_file docs/development/firebase_environment_switching.md
check_file docs/development/firebase_local_emulator_setup.md
check_file docs/operations/firebase_deployment_rules.md
check_file docs/operations/firebase_production_access.md
check_file docs/testing/firebase_environment_verification.md
check_file scripts/deploy/firebase_dev.sh
check_file scripts/deploy/firebase_staging.sh
check_file scripts/deploy/firebase_prod.sh
check_file scripts/setup/start_firebase_emulators.sh
check_file docs/development/cursor_ai_development_rules.md
check_file docs/development/coding_standards.md
check_file docs/development/definition_of_done.md
check_file docs/product/foundation_completion_gate.md
check_file docs/product/foundation_approval_record.md
check_file .cursor/rules/00-revo-olympics-project-foundation.mdc
check_file .cursor/rules/01-general-development-rules.mdc
check_file .cursor/rules/02-modular-architecture-rules.mdc
check_file .cursor/rules/03-flutter-development-rules.mdc
check_file .cursor/rules/04-unity-csharp-development-rules.mdc
check_file .cursor/rules/05-flutter-unity-protocol-rules.mdc
check_file .cursor/rules/06-firebase-development-rules.mdc
check_file .cursor/rules/07-security-and-secret-rules.mdc
check_file .cursor/rules/08-error-handling-and-logging-rules.mdc
check_file .cursor/rules/09-testing-rules.mdc
check_file .cursor/rules/10-documentation-rules.mdc
check_file .cursor/rules/11-file-size-and-complexity-rules.mdc
check_file .cursor/rules/12-result-integrity-rules.mdc
check_file .cursor/rules/13-localization-rules.mdc
check_file .cursor/rules/14-performance-rules.mdc
check_file .cursor/rules/15-definition-of-done.mdc
check_file melos.yaml
check_file README.md
check_file CONTRIBUTING.md
check_file SECURITY.md

# Secret patterns that must not appear committed
if git grep -l 'firebase-adminsdk' -- ':!*.md' ':!scripts/**' ':!.gitignore' 2>/dev/null; then
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
