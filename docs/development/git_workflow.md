# Git Workflow

## Branches

```
main          ← production-approved
develop       ← integration
feature/*     ← sprint work
fix/*         ← bug fixes
release/*     ← stabilization
hotfix/*      ← emergency production fixes
```

## Workflow

1. Create `feature/{sprint-id}-{description}` from `develop`
2. Commit using conventional format: `type(scope): description`
3. Open pull request to `develop`
4. Pass review and CI checks
5. Merge to `develop` → staging deployment (later sprint)
6. Release branch → `main` for production

## Branch Protection (GitHub)

### `main`

- Pull request required
- No direct push
- No force push
- Required status checks (when CI enabled)
- Code owner review for protected paths

### `develop`

- Pull request required
- At least one approval
- No force push

## Hotfix Flow

```
main → hotfix/1.0.1-description → main + develop
```

## Commit Format

```
type(scope): description
```

See [CONTRIBUTING.md](../../CONTRIBUTING.md).

## Pull Requests

Use [.github/PULL_REQUEST_TEMPLATE.md](../../.github/PULL_REQUEST_TEMPLATE.md).

Keep PRs small. Do not mix unrelated Flutter, Unity, and Firebase changes without justification.

## Code Review

See [code_review_rules.md](./code_review_rules.md).

Protected areas:

- Firebase rules and functions
- Unity shared bridge and templates
- CI workflows
- Product documentation
