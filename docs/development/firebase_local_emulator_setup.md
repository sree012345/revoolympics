# Firebase Local Emulator Setup

Run Firebase services locally for daily development without touching staging or production.

## Requirements

- Firebase CLI authenticated: `firebase login`
- Node.js for Functions emulator
- Repository root as working directory

## Start emulators

```bash
./scripts/setup/start_firebase_emulators.sh
```

Equivalent manual command:

```bash
firebase emulators:start --project revoolympics-dev
```

Optional import from `firebase/emulators/import/` when populated.

## Emulator ports

Configured in `firebase.json`:

| Service | Port |
|---------|------|
| Emulator UI | 4000 |
| Hosting | 5000 |
| Functions | 5001 |
| Firestore | 8080 |
| Auth | 9099 |
| Storage | 9199 |

## Connect Flutter (development only)

```bash
cd apps/player_app
flutter run \
  --dart-define=REVO_ENV=development \
  --dart-define=USE_FIREBASE_EMULATORS=true
```

Admin Web:

```bash
cd apps/admin_web
flutter run -d chrome \
  --dart-define=REVO_ENV=development \
  --dart-define=USE_FIREBASE_EMULATORS=true
```

The environment loader rejects emulator mode for staging and production.

## Emulator data

| Directory | Use |
|-----------|-----|
| `firebase/emulators/import/` | Seed data loaded at start |
| `firebase/emulators/exported/` | Local exports (do not commit production data) |

Regenerate development data from `firebase/seed/development/` rather than copying production.

## Auth emulator

Use test users and phone numbers configured in Firebase Auth emulator docs. Development may enable Authentication Emulator alongside Firestore and Functions.

## Functions emulator

Build Functions before testing:

```bash
cd firebase/functions && npm run build
```

Functions run against emulated Firestore/Auth when started via the emulator suite.

## Rules testing

Deploy rules to emulators automatically from `firebase/firestore/firestore.rules` and `firebase/storage/storage.rules` when the suite starts.

Run automated rules tests via CI workflow `firebase_rules_test.yml` when implemented.

## Safety rules

1. Never point staging/production builds at `localhost`
2. Never import production exports into `firebase/emulators/`
3. Emulator exports are disposable
4. `singleProjectMode: true` in `firebase.json` keeps emulator project context on `revoolympics-dev`

## Related

- [firebase_environment_switching.md](firebase_environment_switching.md)
- [firebase/emulators/README.md](../../firebase/emulators/README.md)
