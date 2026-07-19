# Firebase Deployment Rules

Operational rules for deploying Firebase resources to Revo Olympics environments.

## Deployment matrix

| Resource | Development | Staging | Production |
|----------|-------------|---------|------------|
| Firestore rules | Developer or CI | CI | Protected CI |
| Firestore indexes | Developer or CI | CI | Protected CI |
| Storage rules | Developer or CI | CI | Protected CI |
| Functions | Developer or CI | CI | Protected CI |
| Admin Hosting | Developer or CI | CI | Protected CI |
| Player Hosting | Developer or CI | CI | Protected CI |
| Games Hosting | Developer or CI | CI | Protected publishing |
| Remote Config | Controlled | Controlled | Approval required |
| Auth provider changes | Admin | Technical lead | Production administrator |

## Branch flow

```
feature/* → develop → dev deploy
release/* → staging deploy → QA approval
main (+ hotfix/*) → production deploy
```

## Scripts

| Script | Environment | Guards |
|--------|-------------|--------|
| `scripts/deploy/firebase_dev.sh` | Development | Explicit `--project revoolympics-dev`; blocks prod project |
| `scripts/deploy/firebase_staging.sh` | Staging | Branch must be `develop` or `release/*` |
| `scripts/deploy/firebase_prod.sh` | Production | See production guard below |

## Explicit project IDs

Always prefer:

```bash
firebase deploy --project revoolympics-dev --only firestore,storage,functions,hosting
```

Do not rely on the active CLI alias alone for production.

## Production deployment guard

`firebase_prod.sh` requires **all** of:

| Check | Requirement |
|-------|-------------|
| `REVO_ENV` | `production` |
| Project ID | `revoolympics-prod` |
| Git branch | `main` or `hotfix/*` |
| Working tree | Clean |
| Approval | `CI=true` or `PRODUCTION_DEPLOY_APPROVED=true` |
| Release tag | `RELEASE_TAG` set |

Failure on any check: **stop immediately**.

## Pre-deploy checklist

### All environments

- [ ] Correct `--project` flag
- [ ] Rules/indexes reviewed in PR
- [ ] Functions tests pass
- [ ] No secrets in commit

### Staging / Production

- [ ] Staging validation completed (for prod)
- [ ] Deployment record created
- [ ] Rollback steps documented

## Hosting targets

Deploy specific sites:

```bash
firebase deploy --project revoolympics-dev --only hosting:admin,hosting:games
```

Targets `admin`, `player`, `games` map to environment-specific site IDs in `.firebaserc`.

## Functions

Same codebase (`firebase/functions/`) deployed per project. Secrets via Secret Manager only.

## Rollback

- **Hosting:** redeploy previous known-good build artifact
- **Functions:** redeploy previous release tag from CI
- **Rules:** revert Git commit and redeploy
- **Firestore schema:** follow migration runbook; restore from backup in production

Document incidents per [incident_response.md](incident_response.md).

## Forbidden

- Deploying production from a feature branch
- Deploying with a dirty working tree to production
- Using production service account in development
- Overwriting immutable versioned game builds in production

## Related

- [firebase_production_access.md](firebase_production_access.md)
- [firebase_environment_architecture.md](../architecture/firebase_environment_architecture.md)
