# Coding Standards

Human-readable summary of Revo Olympics coding standards. Cursor enforces these via `.cursor/rules/`.

## Architecture (fixed)

| Layer | Technology | Role |
|-------|------------|------|
| Player app | Flutter | Shell, navigation, Unity WebView host |
| Admin | Flutter Web | Institution and platform administration |
| Games | Unity 6.x WebGL | Gameplay runtime in WebView |
| Backend | Firebase | Auth, data, hosting, trusted Functions |

Official results, ranks, medals, and champions are **backend-authoritative only**.

## Naming

### Dart

- Files: `lower_snake_case.dart`
- Classes: `UpperCamelCase`
- Variables: `lowerCamelCase`
- Private fields: `_lowerCamelCase`

### C#

- Classes/public members: PascalCase
- Locals/parameters: camelCase
- Private serialized: `_camelCase`

### Firestore

- Collections: `lower_snake_case`
- No environment suffix on collection names

### TypeScript (Functions)

- camelCase functions and variables; PascalCase types/interfaces

## Module layout

```
Presentation → Application → Domain → Infrastructure
```

Player features: `apps/player_app/lib/features/<feature>/`  
Admin modules: `apps/admin_web/lib/modules/<module>/`

## Null safety

- Dart: sound null safety required; no `!` without validation
- Unity: validate serialized references; clear error messages

## State and errors

Remote screens: initial, loading, success, empty, error, unauthorized, offline.

Use structured error categories and codes — see [error_handling_and_logging.md](./error_handling_and_logging.md).

## Firebase client boundaries

Clients may read authorized data and submit raw results through approved paths.

Clients must not write official ranks, medals, final leaderboards, or custom claims.

## Environments

Three separate Firebase projects. Use `REVO_ENV` and flavours. Never default to production.

## File size targets

See [file_size_and_complexity_limits.md](./file_size_and_complexity_limits.md).

## Testing

Behavioural code requires tests. See `.cursor/rules/09-testing-rules.mdc`.

## Documentation

Update docs when behaviour, protocol, schema, or security rules change.

## Commits

`type(scope): description` — see `CONTRIBUTING.md`.
