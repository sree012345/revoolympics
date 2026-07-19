# Contributing to Revo Olympics

Thank you for contributing. This repository uses a monorepo structure with strict source-control and security rules.

## Branch Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Production-approved releases |
| `develop` | Integration branch for upcoming releases |
| `feature/*` | New work |
| `fix/*` | Bug fixes |
| `release/*` | Release stabilization |
| `hotfix/*` | Emergency production fixes |

### Branch Naming

```
feature/{sprint-id}-{description}
fix/{issue-id}-{description}
release/{version}
hotfix/{version}-{description}
```

Examples:

- `feature/f0-5-firebase-environments`
- `fix/105-orientation-reset`

## Commit Messages

Use conventional commits:

```
type(scope): description
```

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `perf`, `style`, `chore`, `build`, `ci`, `revert`

Examples:

- `docs(product): add competition ranking rules`
- `chore(repo): add monorepo folders`
- `feat(player): add dynamic game catalogue`

Avoid vague messages like "updated", "changes", or "final changes".

## Pull Requests

1. Branch from `develop` (or `main` for hotfixes).
2. Keep PRs small and focused.
3. Fill in [.github/PULL_REQUEST_TEMPLATE.md](.github/PULL_REQUEST_TEMPLATE.md).
4. Ensure tests and documentation are updated.
5. Obtain required reviews before merge.

### Review Requirements

| Change type | Reviews |
|-------------|---------|
| Normal feature | 1 qualified reviewer |
| Security-sensitive (auth, rules, results) | Technical lead + security-aware review |
| Production-critical | 2 approvals + QA evidence + rollback plan |

Protected areas requiring code-owner review:

- `firebase/firestore/`, `firebase/storage/`, `firebase/functions/`
- `unity/shared_bridge/`, `unity/game_templates/`
- `.github/workflows/`
- `docs/product/`

## Testing

- Add or update tests for behaviour changes.
- Run `melos analyze` and `melos test` for Flutter changes.
- Run Firebase rules tests for security rule changes.

## Documentation

Update relevant documentation when behaviour, architecture, or workflows change.

## Secrets

Never commit:

- `.env` files (only `.env.example`)
- Service account JSON
- Signing keys or certificates
- API tokens or webhook secrets

See [docs/development/secret_handling.md](docs/development/secret_handling.md).

## Git LFS

Use Git LFS for large binary assets (PSD, FBX, audio, video, Unity packages). Do not use LFS for normal source code or published WebGL build output.

## Unity Source Control

Every Unity project must use:

- **Version Control Mode:** Visible Meta Files
- **Asset Serialization Mode:** Force Text

See [docs/development/unity_source_control_rules.md](docs/development/unity_source_control_rules.md).

## Firebase Changes

Changes to Firestore rules, Storage rules, or Cloud Functions require:

- Security review
- Rule tests
- Documentation update

## Questions

Open a discussion or contact the technical lead listed in [CODEOWNERS](.github/CODEOWNERS).
