# Android product flavours

Configure Gradle product flavours `dev`, `staging`, and `prod` with matching application IDs:

| Flavour | Application ID |
|---------|------------------|
| dev | `com.revolutiongames.revoolympics.dev` |
| staging | `com.revolutiongames.revoolympics.staging` |
| prod | `com.revolutiongames.revoolympics` |

Place `google-services.json` under:

```
app/src/dev/google-services.json
app/src/staging/google-services.json
app/src/prod/google-services.json
```

Run:

```bash
flutter run --flavor dev --dart-define=REVO_ENV=development
```

See [firebase_environment_setup.md](../../../../docs/development/firebase_environment_setup.md).
