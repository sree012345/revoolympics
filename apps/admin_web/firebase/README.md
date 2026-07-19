# Admin Web — Firebase configuration notes

Admin Web connects to Firebase Web apps registered per environment.

| Environment | Firebase app nickname | Project ID |
|-------------|----------------------|------------|
| Development | `revoolympics-admin-dev` | `revoolympics-dev` |
| Staging | `revoolympics-admin-staging` | `revoolympics-staging` |
| Production | `revoolympics-admin-prod` | `revoolympics-prod` |

Generate FlutterFire options from `apps/admin_web/`:

```bash
flutterfire configure --project=revoolympics-dev \
  --out=lib/firebase_options/firebase_options_dev.dart
```

See [firebase_environment_setup.md](../../../docs/development/firebase_environment_setup.md).
