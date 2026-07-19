# Seed Data

Environment-specific seed data for development, staging, and production bootstrap.

## Directories

| Path | Purpose |
|------|---------|
| `development/` | Replaceable dev fixtures and sample institutions |
| `staging/` | Controlled QA fixtures |
| `production/` | Minimal system seed definitions only |

## Rules

- No real student information
- No real passwords
- No production contact details
- Production seeding requires `--confirm-production` and authorization
- Scripts must display target environment and project ID before writing
- Development seed must include system `general` institution per product rules

## Firestore metadata

Each environment writes a `system/environment` document matching `system_environment.json` in the corresponding seed folder.

See [firebase_environment_setup.md](../../docs/development/firebase_environment_setup.md).
