# Secret Handling

## What Counts as a Secret

- Firebase Admin service account JSON
- Google Cloud service account keys
- GitHub tokens and deployment credentials
- Android keystore files and passwords
- Apple distribution certificates and provisioning profiles
- API private keys and webhook secrets
- CI credentials and private SSH keys

## Approved Storage

| Location | Use |
|----------|-----|
| GitHub Actions Secrets | CI/CD |
| Google Secret Manager | Production backend |
| Local `.env` (gitignored) | Developer machines |
| Password manager | Team credential sharing |

## Prohibited Storage

Never store secrets in:

- Git (including history)
- Markdown documentation or README examples with real values
- Flutter source or assets
- Unity Resources or committed ScriptableObjects with keys
- Firestore documents
- Pull request comments or public issues
- `.env.example` (example values only)

## Service Account Rules

- Never commit `*service-account*.json` or `firebase-adminsdk-*.json`
- Never bundle in Flutter or Unity builds
- Never upload to Firebase Hosting
- Use Cloud Functions / CI with Secret Manager only

## Rotation

If a secret is exposed:

1. **Revoke** immediately (deleting from Git is not enough)
2. **Rotate** credentials
3. **Audit** access logs
4. **Document** incident

## Example Files

`.env.example` and similar files may contain **placeholder** values only:

```
FIREBASE_PROJECT_ID=revoolympics-dev
```

Not real API keys or project secrets.
