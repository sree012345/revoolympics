# Environment Guide

Revo Olympics uses three isolated Firebase environments.

| Environment | Firebase Project | Purpose |
|-------------|------------------|---------|
| development | `revoolympics-dev` | Daily development, emulators, test data |
| staging | `revoolympics-staging` | QA, UAT, release candidates |
| production | `revoolympics-prod` | Live users, official results |

## Configuration Files

| File | Committed | Purpose |
|------|-----------|---------|
| `.env.example` | Yes | Root example variables |
| `.firebaserc.example` | Yes | Firebase project aliases |
| `.env` | **No** | Local overrides |
| `.firebaserc` | Optional team policy | Local project mapping |

Application examples:

- `apps/player_app/.env.example`
- `apps/admin_web/.env.example`
- `firebase/functions/.env.example`

## Default Environment

**Local development defaults to `development`.**

Production deployment requires:

- Explicit environment argument
- Protected CI job
- Authorized approver
- Deployment log entry

## Environment Banner

Development and staging player/admin builds should display **DEV** or **STAGING**. Production must not show debug environment banners.

## Switching Methods

- Flutter flavours / `--dart-define=REVO_ENV=...`
- Firebase project alias (`firebase use dev|staging|prod`)
- CI environment variables
- Deployment scripts with explicit `--project` flag

## Detailed guides (Sprint F0.5)

- [firebase_environment_setup.md](./firebase_environment_setup.md)
- [firebase_environment_switching.md](./firebase_environment_switching.md)
- [firebase_local_emulator_setup.md](./firebase_local_emulator_setup.md)

## Rules

- Never copy development data casually into production
- Never store highly sensitive secrets in Flutter `.env` (extractable from builds)
- Service account JSON stays on backend/CI only

See [secret_handling.md](./secret_handling.md).
