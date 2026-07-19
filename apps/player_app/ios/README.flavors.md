# iOS build configurations

Use Xcode configurations or schemes mapped to flavours `dev`, `staging`, and `prod`.

Place `GoogleService-Info.plist` under:

```
ios/config/dev/GoogleService-Info.plist
ios/config/staging/GoogleService-Info.plist
ios/config/prod/GoogleService-Info.plist
```

Bundle IDs:

| Flavour | Bundle ID |
|---------|-----------|
| dev | `com.revolutiongames.revoolympics.dev` |
| staging | `com.revolutiongames.revoolympics.staging` |
| prod | `com.revolutiongames.revoolympics` |

See [firebase_environment_setup.md](../../../../docs/development/firebase_environment_setup.md).
