# Firebase Environment Architecture

Authoritative architecture for Revo Olympics Firebase environments (Sprint F0.5).

## Purpose

Revo Olympics uses **three independent Firebase projects**. Each environment is a complete backend — not a collection prefix inside one project.

| Environment | Project ID | Real users | Official results |
|-------------|------------|------------|------------------|
| Development | `revoolympics-dev` | No | No |
| Staging | `revoolympics-staging` | Test users only | No |
| Production | `revoolympics-prod` | Yes | Yes |

Alternative globally unique IDs (e.g. `rg-revoolympics-dev`) are acceptable if the `-dev`, `-staging`, `-prod` suffix rule is preserved.

## Approved topology

```
Firebase Project: revoolympics-dev
└── Development resources only

Firebase Project: revoolympics-staging
└── Staging resources only

Firebase Project: revoolympics-prod
└── Production resources only
```

## Forbidden patterns

Do **not** use:

- One Firebase project with `games_dev`, `games_staging`, `games_prod` collections
- Shared Authentication users across environments
- Shared Storage buckets or Hosting deployments
- Production as the default CLI target or Flutter fallback

## Resource matrix

| Resource | Isolation |
|----------|-----------|
| Firebase / GCP project | Separate per environment |
| Firestore database | Separate |
| Storage bucket | Separate |
| Authentication users | Separate |
| Cloud Functions deployment | Separate |
| Function secrets | Separate (Secret Manager per project) |
| Hosting sites | Separate (`admin`, `player`, `games` targets) |
| Analytics | Separate property/stream |
| App Check | Separate configuration |
| Remote Config | Separate values |
| FCM credentials | Separate |
| Service accounts | Separate deployer identities |
| IAM | Least privilege; strictest in production |

## Hosting sites

| Target | Development | Staging | Production |
|--------|-------------|---------|------------|
| admin | `revoolympics-admin-dev` | `revoolympics-admin-staging` | `revoolympics-admin` |
| player | `revoolympics-player-dev` | `revoolympics-player-staging` | `revoolympics-player` |
| games | `revoolympics-games-dev` | `revoolympics-games-staging` | `revoolympics-games` |

Game build URL pattern: `/{gameId}/{version}/index.html`

Example: `https://revoolympics-games-dev.web.app/revo_math_race/1.0.0/index.html`

## Flutter applications

Each project registers:

- **Player app:** Android, iOS, Web, macOS (where used)
- **Admin Web:** Web

Application identifiers:

| Platform | Development | Staging | Production |
|----------|-------------|---------|------------|
| Android / iOS | `com.revolutiongames.revoolympics.dev` | `com.revolutiongames.revoolympics.staging` | `com.revolutiongames.revoolympics` |
| Admin nickname | `revoolympics-admin-dev` | `revoolympics-admin-staging` | `revoolympics-admin-prod` |
| Player nickname | `revoolympics-player-dev` | `revoolympics-player-staging` | `revoolympics-player-prod` |

Runtime selection uses `REVO_ENV` and Flutter flavours (`dev`, `staging`, `prod`). See [firebase_environment_switching.md](../development/firebase_environment_switching.md).

## Cloud Functions

Single source tree: `firebase/functions/`. Deploy independently:

```bash
firebase deploy --project revoolympics-dev --only functions
firebase deploy --project revoolympics-staging --only functions
firebase deploy --project revoolympics-prod --only functions
```

Region: `asia-south1` (`REVO_FUNCTIONS_REGION`). Environment behaviour comes from project identity, parameters, and Secret Manager — not duplicated source folders.

## Firestore

- Mode: Native
- Rules source: `firebase/firestore/firestore.rules` (same structure, all environments)
- Indexes: `firebase/firestore/firestore.indexes.json`
- Metadata document: `system/environment`

Collection names are **not** environment-prefixed; project isolation provides separation.

## Storage

Default bucket pattern: `{projectId}.firebasestorage.app`

Rules source: `firebase/storage/storage.rules`

Game version documents must reference URLs within the **same** environment.

## Security boundaries

Client Firebase config is **not** a secret boundary. Enforcement uses:

- Project isolation
- Authentication and custom claims (server-assigned only)
- Firestore and Storage rules
- Cloud Functions validation
- App Check (debug in dev, enforced in production)
- IAM

## Deployment flow

```
Feature branch → local emulators → develop → dev deploy
  → release branch → staging deploy → QA
  → main + approval → production deploy
```

See [firebase_deployment_rules.md](../operations/firebase_deployment_rules.md).

## Cross-environment data

| Direction | Allowed | Not allowed |
|-----------|---------|-------------|
| Dev → Staging | Rules, indexes, schema, approved fixtures | Random test data, emulator dumps |
| Staging → Prod | Approved builds, rules, functions releases | QA users, test results |
| Prod → lower | Anonymized minimal subsets with authorization | Full production copies |

## Repository mapping

| Path | Role |
|------|------|
| `.firebaserc` | CLI aliases and hosting targets |
| `firebase.json` | Shared deploy configuration |
| `firebase/environments/` | Non-secret environment metadata |
| `firebase/seed/` | Per-environment seed definitions |
| `firebase/emulators/` | Local emulator import/export |
| `apps/*/lib/core/environment/` | Flutter runtime environment layer |
| `apps/*/lib/firebase_options/` | FlutterFire generated options |

## Related documents

- [firebase_environment_setup.md](../development/firebase_environment_setup.md)
- [firebase_environment_switching.md](../development/firebase_environment_switching.md)
- [firebase_local_emulator_setup.md](../development/firebase_local_emulator_setup.md)
- [firebase_deployment_rules.md](../operations/firebase_deployment_rules.md)
- [firebase_production_access.md](../operations/firebase_production_access.md)
- [firebase_environment_verification.md](../testing/firebase_environment_verification.md)
- [analytics_event_schema.md](analytics_event_schema.md)
