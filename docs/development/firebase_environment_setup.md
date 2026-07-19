# Firebase Environment Setup

Step-by-step guide to create and wire the three Revo Olympics Firebase environments (Sprint F0.5).

## Prerequisites

- Firebase CLI: `npm install -g firebase-tools`
- FlutterFire CLI: `dart pub global activate flutterfire_cli`
- Access to Revolution Games billing account
- Technical lead approval for project IDs

## Task 1 — Confirm naming

Approve project IDs (globally unique):

- `revoolympics-dev`
- `revoolympics-staging`
- `revoolympics-prod`

Mark production as a **production environment** in Firebase console settings.

## Task 2 — Create Firebase projects

Create three independent projects in [Firebase Console](https://console.firebase.google.com/):

1. Revo Olympics Development → `revoolympics-dev`
2. Revo Olympics Staging → `revoolympics-staging`
3. Revo Olympics Production → `revoolympics-prod`

## Task 3 — Billing and alerts

Link each project to the approved billing account. Configure separate budgets with alerts at 50%, 75%, 90%, and 100%.

## Task 4 — Firestore

For each project:

1. Create Cloud Firestore (Native mode)
2. Select region (recommended: `asia-south1` after service compatibility check)
3. Deploy rules: `firebase deploy --project <id> --only firestore:rules`
4. Deploy indexes: `firebase deploy --project <id> --only firestore:indexes`
5. Write `system/environment` from `firebase/seed/<env>/system_environment.json`

**Never** leave production in unrestricted test mode.

## Task 5 — Storage

Enable Storage in each project. Deploy rules:

```bash
firebase deploy --project revoolympics-dev --only storage
```

Repeat for staging and production.

## Task 6 — Register Flutter apps

### Player app (each project)

Register Android, iOS, Web, and macOS apps with bundle IDs from [firebase_environment_architecture.md](../architecture/firebase_environment_architecture.md).

### Admin Web (each project)

Register Web app with nicknames `revoolympics-admin-dev`, etc.

## Task 7 — FlutterFire configuration

From `apps/player_app/`:

```bash
flutterfire configure --project=revoolympics-dev \
  --out=lib/firebase_options/firebase_options_dev.dart

flutterfire configure --project=revoolympics-staging \
  --out=lib/firebase_options/firebase_options_staging.dart

flutterfire configure --project=revoolympics-prod \
  --out=lib/firebase_options/firebase_options_prod.dart
```

Repeat from `apps/admin_web/`.

Update `EnvironmentConfig` values in `lib/core/environment/environment_config.dart` with generated app IDs and sender IDs.

## Task 8 — Native config files

Download and place:

**Android**

```
apps/player_app/android/app/src/dev/google-services.json
apps/player_app/android/app/src/staging/google-services.json
apps/player_app/android/app/src/prod/google-services.json
```

**iOS**

```
apps/player_app/ios/config/dev/GoogleService-Info.plist
apps/player_app/ios/config/staging/GoogleService-Info.plist
apps/player_app/ios/config/prod/GoogleService-Info.plist
```

## Task 9 — Firebase CLI

Copy `.firebaserc.example` to `.firebaserc` if needed. Default alias is **dev**, not prod:

```bash
firebase use dev
firebase projects:list
```

Apply hosting targets (once per machine / CI):

```bash
firebase use dev
firebase target:apply hosting admin revoolympics-admin-dev
firebase target:apply hosting player revoolympics-player-dev
firebase target:apply hosting games revoolympics-games-dev
```

Repeat for `staging` and `prod` with site IDs from `.firebaserc`.

## Task 10 — Hosting sites

In each Firebase project, create Hosting sites for admin, player, and games. Map targets as above.

## Task 11 — Authentication

Configure providers per environment:

| Provider | Development | Staging | Production |
|----------|-------------|---------|------------|
| Email/password | Yes | Yes | Approved only |
| Google | Optional | Yes | If approved |
| Phone | Test numbers | Test | Approved |
| Apple | Optional | If needed | If required |

Configure authorized domains separately. Production must not include unnecessary test domains.

## Task 12 — Cloud Functions

```bash
cd firebase/functions && npm install
firebase deploy --project revoolympics-dev --only functions
```

Copy `.env.dev.example` to local `.env.dev` (not committed). Use Secret Manager for secrets.

## Task 13 — Analytics, Crashlytics, Remote Config, FCM, App Check

Configure separately in each project:

- **Analytics:** separate property per environment
- **Crashlytics:** mobile player app; tag environment in reports
- **Remote Config:** safe defaults; production values approval-controlled
- **FCM:** separate credentials
- **App Check:** debug in dev; enforcement tested in staging before production

## Task 14 — IAM and service accounts

Create deployer service accounts:

- `revoolympics-dev-deployer`
- `revoolympics-staging-deployer`
- `revoolympics-prod-deployer`

Do not grant all developers Owner on production.

## Task 15 — Seed data

Run seed scripts against development first. Staging requires controlled fixtures. Production seed requires `--confirm-production`.

## Task 16 — Verify

Complete [firebase_environment_verification.md](../testing/firebase_environment_verification.md).

## Repository files (already scaffolded)

| File | Purpose |
|------|---------|
| `.firebaserc` | Aliases and hosting targets |
| `firebase.json` | Deploy and emulator config |
| `firebase/environments/*/environment.json` | Metadata |
| `scripts/deploy/firebase_*.sh` | Deployment scripts |
| `scripts/setup/start_firebase_emulators.sh` | Local emulators |

## Related

- [firebase_environment_architecture.md](../architecture/firebase_environment_architecture.md)
- [firebase_environment_switching.md](firebase_environment_switching.md)
- [secret_handling.md](secret_handling.md)
