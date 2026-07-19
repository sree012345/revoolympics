# Scripts

Automation scripts for Revo Olympics development.

| Directory | Purpose |
|-----------|---------|
| `setup/` | Initial developer setup |
| `build/` | Build Flutter, Unity, Firebase |
| `test/` | Run test suites |
| `deploy/` | Deploy to staging/production (protected) |
| `cleanup/` | Remove generated artifacts |

## Setup

Run `scripts/setup/verify_repository.sh` after clone to verify structure.

## Rules

- Scripts must require explicit `--env` for non-development targets
- Never embed secrets in scripts
- Production deploy scripts require authorization (later sprint)
