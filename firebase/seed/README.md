# Seed Data

Environment-specific seed data for development and testing.

## Directories

| Path | Purpose |
|------|---------|
| `dev/` | Development emulator seed |
| `test/` | Automated test fixtures |
| `staging/` | Staging bootstrap (explicit approval) |
| `fixtures/` | Shared JSON fixtures |
| `scripts/` | Seed scripts |

## Rules

- No real student information
- No real passwords
- No production contact details
- Production seeding requires explicit confirmation
- Scripts must display target environment before writing

## General Institution

Development seed must include system `general` institution per product rules.
