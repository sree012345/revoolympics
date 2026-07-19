# Security Policy

## Reporting a Vulnerability

**Do not create public GitHub issues for security vulnerabilities.**

Report security issues privately to the Revolution Games security contact or technical lead. Include:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Affected components (Flutter, Unity, Firebase, etc.)

We will acknowledge receipt and provide a timeline for assessment and remediation.

## Supported Versions

| Version | Supported |
|---------|-----------|
| Foundation / pre-1.0 | Development only |
| 1.x (when released) | Active support per release policy |

## Secret Handling

Secrets must **never** be stored in:

- Git source control
- Markdown documentation
- Flutter assets or Dart source
- Unity Resources folders
- Firestore documents
- Pull request comments or public issues

Approved storage:

- GitHub Actions Secrets
- Google Secret Manager
- Local uncommitted `.env` files
- Protected CI environment variables

## Credential Rotation

Rotate credentials immediately when:

- Accidentally committed (delete from Git **and** revoke the credential)
- Shared with unauthorized persons
- Exposed in logs or screenshots
- A team member with access departs

Removing a secret from the latest commit is **not sufficient** — revoke and rotate.

## Production Access

Production Firebase projects, deployment credentials, and signing keys require authorized personnel only. Production deployment must use protected CI jobs with explicit approval.

## Data Privacy

- Do not use real student data in seed fixtures or test environments.
- Institution and player data must follow applicable privacy requirements.
- Development and staging data must not be copied casually into production.

## Incident Response

1. Contain — revoke exposed credentials, disable affected builds if needed
2. Assess — determine scope and data impact
3. Remediate — patch, rotate, redeploy
4. Document — audit log and post-incident review

See [docs/operations/incident_response.md](docs/operations/incident_response.md) (placeholder).
