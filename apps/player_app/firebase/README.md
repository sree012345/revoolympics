# Player app — Firebase native config (per environment)

Place downloaded Firebase config files here after registering apps in each Firebase project.

## Android

```
android/app/src/dev/google-services.json
android/app/src/staging/google-services.json
android/app/src/prod/google-services.json
```

Package names:

| Flavour | Application ID |
|---------|------------------|
| dev | `com.revolutiongames.revoolympics.dev` |
| staging | `com.revolutiongames.revoolympics.staging` |
| prod | `com.revolutiongames.revoolympics` |

## iOS

```
ios/config/dev/GoogleService-Info.plist
ios/config/staging/GoogleService-Info.plist
ios/config/prod/GoogleService-Info.plist
```

Bundle IDs match the Android application IDs above.

**Do not commit real config files until Firebase projects exist.** Add paths to `.gitignore` if your team prefers local-only native config.

See [firebase_environment_setup.md](../../../docs/development/firebase_environment_setup.md).
