# Firebase Production Access

Who may access the Revo Olympics production Firebase project and under what controls.

## Production project

- **Project ID:** `revoolympics-prod`
- **Classification:** Production environment (marked in Firebase console)

## Access tiers

| Role | Typical members | Firebase / GCP access |
|------|-----------------|------------------------|
| Owner (minimal) | Company owners, designated administrators | Full (emergency only) |
| Technical lead | Platform lead | Editor on Functions, Firestore read, deploy via CI |
| DevOps lead | Infrastructure | IAM admin, Secret Manager, deploy pipelines |
| Production CI | `revoolympics-prod-deployer` service account | Deploy-only scoped roles |
| Emergency support | On-call (time-bound) | Temporary elevated access with audit |

## Least privilege

- Do **not** grant all developers Owner on production
- Developers use `revoolympics-dev` for daily work
- QA uses `revoolympics-staging` for release validation

## Service accounts

| Account | Purpose |
|---------|---------|
| `revoolympics-dev-deployer` | Development CI and approved dev deploys |
| `revoolympics-staging-deployer` | Staging CI |
| `revoolympics-prod-deployer` | Production CI only |

Never reuse the production deployer identity in lower environments.

## Human access workflow

1. Request access with justification and duration
2. Technical lead or DevOps approval
3. Grant minimum IAM role required
4. Log in audit record
5. Revoke when task completes

## Production operations

### Allowed with approval

- Firestore rules/index deploy from `main`
- Approved Functions release
- Approved Hosting publish (admin, player, games)
- Minimal system seed with `--confirm-production`
- Super Admin bootstrap (one-time, audited)

### Requires stronger control

- Auth provider changes
- Remote Config mass updates
- FCM mass notifications (second approval recommended)
- App Check enforcement changes
- IAM role changes
- Billing account changes

### Forbidden

- Copying full production data to dev/staging without anonymization
- Sharing service account keys in chat or email
- Local production deploy without CI guards
- Debug App Check tokens in production builds

## Bootstrap

First Super Administrator per environment:

1. Create user in Firebase Authentication
2. Run protected bootstrap script or administrative Function
3. Assign `superAdmin` custom claim (server-side only)
4. Create Firestore admin profile
5. Record audit entry
6. Restrict bootstrap capability

Production bootstrap requires stronger verification than development.

## Monitoring and incident response

- Enable billing alerts (50/75/90/100%)
- Monitor Functions errors and App Check rejections
- Follow [incident_response.md](incident_response.md) for mis-deployments

## Recovery after incorrect deployment

1. Stop further deploys
2. Identify affected resources (Hosting, Functions, rules)
3. Roll back to last known-good release tag
4. Verify `system/environment` and app connectivity
5. Post-incident review

## Related

- [firebase_deployment_rules.md](firebase_deployment_rules.md)
- [secret_handling.md](../development/secret_handling.md)
