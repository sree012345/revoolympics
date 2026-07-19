# Firebase Environment Switching

How developers and CI select the correct Revo Olympics Firebase environment.

## Logical environments

| `REVO_ENV` | Firebase project | CLI alias |
|------------|------------------|-----------|
| `development` | `revoolympics-dev` | `dev` |
| `staging` | `revoolympics-staging` | `staging` |
| `production` | `revoolympics-prod` | `prod` |

## Flutter — compile-time selection

The app reads `REVO_ENV` via `--dart-define`. **There is no production fallback.**

```bash
# Development
flutter run --flavor dev --dart-define=REVO_ENV=development

# Staging
flutter run --flavor staging --dart-define=REVO_ENV=staging

# Production (CI / release only)
flutter build appbundle --flavor prod --dart-define=REVO_ENV=production
```

### Web

```bash
flutter build web --dart-define=REVO_ENV=development
flutter build web --dart-define=REVO_ENV=staging
flutter build web --dart-define=REVO_ENV=production
```

### Emulator mode (development only)

```bash
flutter run \
  --dart-define=REVO_ENV=development \
  --dart-define=USE_FIREBASE_EMULATORS=true
```

Staging and production builds **must reject** `USE_FIREBASE_EMULATORS=true`.

## FlutterFire options

Build environment selects the generated options file:

| Environment | Player / Admin options file |
|-------------|----------------------------|
| development | `lib/firebase_options/firebase_options_dev.dart` |
| staging | `lib/firebase_options/firebase_options_staging.dart` |
| production | `lib/firebase_options/firebase_options_prod.dart` |

Wire Firebase initialization to `EnvironmentLoader.load()` in `lib/core/environment/` before calling `Firebase.initializeApp`.

## Firebase CLI

```bash
firebase use dev        # development
firebase use staging    # staging
firebase use prod       # production — use with care
```

Prefer explicit project IDs for deploys:

```bash
firebase deploy --project revoolympics-dev --only hosting:admin
```

Default alias in `.firebaserc` is `revoolympics-dev`, **not** production.

## Environment validation

At startup, Flutter apps validate:

- `REVO_ENV` is present and valid
- Firebase project ID matches environment (e.g. staging build cannot use `revoolympics-prod`)
- Production disables debug logging and App Check debug mode
- Placeholder FlutterFire IDs block staging/production until configured

Mismatch result: **block startup** with configuration error screen.

## Visual indicators

| Environment | Banner |
|-------------|--------|
| Development | `DEV` |
| Staging | `STAGING` |
| Production | None (name visible in About/diagnostics only) |

Implemented in `EnvironmentBanner`.

## Cloud Functions

Functions read `REVO_ENV` and project ID from deployment context. Use `.env.dev.example`, `.env.staging.example`, `.env.prod.example` as templates for non-secret parameters.

## Quick reference

| Action | Command |
|--------|---------|
| Local dev (cloud) | `REVO_ENV=development`, `firebase use dev` |
| Local emulators | `USE_FIREBASE_EMULATORS=true`, `./scripts/setup/start_firebase_emulators.sh` |
| Deploy dev | `./scripts/deploy/firebase_dev.sh` |
| Deploy staging | `./scripts/deploy/firebase_staging.sh` |
| Deploy prod | CI only: `./scripts/deploy/firebase_prod.sh` |

## Related

- [firebase_environment_setup.md](firebase_environment_setup.md)
- [firebase_deployment_rules.md](../operations/firebase_deployment_rules.md)
