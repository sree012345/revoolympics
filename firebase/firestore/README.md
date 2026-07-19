# Firestore

Authoritative security rules: `firestore.rules`

## Schema Documentation

Collection schemas are documented in `schemas/`:

- `games.md`
- `game_versions.md`
- `institutions.md`
- `users.md`
- `teams.md`
- `tournaments.md`
- `game_results.md`

## Rules Principles

- Deny by default
- Institution-scoped access for institution users
- Players must not write official ranks or medals
- Administrative writes require appropriate privileges

## Tests

Rule tests: `tests/` (implement in later sprint)
