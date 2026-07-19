# Code Review Rules

See also [ai_generated_code_review.md](./ai_generated_code_review.md) and `.cursor/rules/15-definition-of-done.mdc`.

## Required Review Areas

- Correct sprint scope
- Architecture compliance (Flutter shell, Unity runtime, Firebase backend authority)
- Security and secret exposure
- Error handling and edge cases
- Tests and documentation
- Environment targeting (never silent production default)
- Institution data isolation (when applicable)
- Backward compatibility

## Approval Levels

| Change | Requirement |
|--------|-------------|
| Normal feature | 1 qualified reviewer + passing checks |
| Security-sensitive | Technical lead + security-aware review + tests |
| Production-critical | 2 approvals + QA evidence + rollback plan |

## Flutter Review Checklist

- Null safety
- Widget vs logic separation
- Navigation and back-button safety
- Loading, error, offline states
- Localization keys (not hardcoded user strings in production paths)
- No hardcoded Firebase credentials or environment URLs in features
- No client writes to official rankings or final results

## Unity Review Checklist

- Unity 6.x and WebGL compatibility
- Shared bridge reuse (no forked protocol)
- Portrait/landscape correctness and exit restoration
- Protocol version documented if changed
- No privileged Firebase access from Unity
- No hardcoded local IP URLs

## Firebase Review Checklist

- Authentication and role validation server-side
- Institution scoping in rules and functions
- Input validation on all callables
- Server timestamps for official data
- Audit logging for sensitive changes
- No secrets in repository
- Idempotent operations where retries possible

## Protected Paths

Require code owner or senior review:

- `firebase/firestore/firestore.rules`
- `firebase/storage/storage.rules`
- `firebase/functions/`
- `unity/shared_bridge/`
- `unity/game_templates/`
- `.github/workflows/`
- `docs/product/`
