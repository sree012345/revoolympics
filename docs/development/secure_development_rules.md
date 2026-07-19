# Secure Development Rules

Security foundation for Revo Olympics development.

## Credentials — never in source

Prohibited in Git, Flutter assets, Unity Resources, and docs:

- Passwords, API secrets, signing keys
- Firebase Admin / service-account JSON
- OAuth client secrets, deployment tokens
- Private certificates and SSH keys

## Approved secret storage

| Secret type | Location |
|-------------|----------|
| Production API secrets | Google Secret Manager |
| CI credentials | GitHub Actions Secrets |
| Local development | Ignored `.env` files |
| Team sharing | Approved password manager |

Example files (`.env.example`) contain **names only**, never real values.

## Client trust boundaries

Flutter and Unity are untrusted. Authorization must be enforced in:

- Cloud Functions
- Firestore security rules
- Storage security rules

Never rely solely on hidden UI, disabled buttons, or client-stored roles.

## Client configuration

Public Firebase identifiers (project ID, app ID) are acceptable in client config. Admin SDK credentials are **never** acceptable in clients.

## Input validation

Validate at every trust boundary: client→Functions, Unity↔Flutter, uploads, Firestore/Storage writes, seed scripts, CLI.

## Least privilege

- Firestore/Storage: deny by default
- IAM: minimum roles per environment
- Not every developer is production Owner
- Separate deployer service accounts per environment

## Environment isolation

- `revoolympics-dev`, `revoolympics-staging`, `revoolympics-prod` are separate projects
- No silent default to production
- Staging must not load development Storage URLs; production must not load staging URLs

## Result integrity

Clients submit raw gameplay data only. Official rank, medals, and finalization are backend-only. See `.cursor/rules/12-result-integrity-rules.mdc`.

## Logging

See [error_handling_and_logging.md](./error_handling_and_logging.md) — never log tokens or sensitive student data.

## Production deployment

Protected CI, branch checks, release tags, explicit project ID validation. See [firebase_deployment_rules.md](../operations/firebase_deployment_rules.md).

## Audit

Immutable audit logs for privileged admin actions and result overrides.

## Related

- [secret_handling.md](./secret_handling.md)
- [firebase_production_access.md](../operations/firebase_production_access.md)
- `.cursor/rules/07-security-and-secret-rules.mdc`
