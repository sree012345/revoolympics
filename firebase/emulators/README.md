# Firebase Emulator Suite

Local Firebase emulators for development. **Never connect staging or production builds to localhost.**

## Layout

| Path | Purpose |
|------|---------|
| `import/` | Optional seed data imported on emulator start |
| `exported/` | Local emulator exports (gitignored contents) |

## Start

From repository root:

```bash
./scripts/setup/start_firebase_emulators.sh
```

Or manually:

```bash
firebase emulators:start --project revoolympics-dev
```

## Ports (from `firebase.json`)

| Emulator | Port |
|----------|------|
| Auth | 9099 |
| Functions | 5001 |
| Firestore | 8080 |
| Hosting | 5000 |
| Storage | 9199 |
| Emulator UI | 4000 |

## Flutter connection

Development builds only:

```bash
flutter run \
  --dart-define=REVO_ENV=development \
  --dart-define=USE_FIREBASE_EMULATORS=true
```

## Rules

- Do not import production exports into this directory
- Do not commit real user data from emulator exports
- Emulator data is disposable; regenerate from `firebase/seed/development/`

See [firebase_local_emulator_setup.md](../../docs/development/firebase_local_emulator_setup.md).
