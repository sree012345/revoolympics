# Revo Olympics Admin Web

Flutter Web administration panel for Revo Olympics.

## Status

**Foundation F0.4** — structure only. Admin authentication begins in Version 1, Sprint 1.4.

## Structure

```
lib/
├── app/       # Admin shell, routing, auth guard
├── core/      # Firebase, config, permissions
├── modules/   # games, institutions, tournaments, ...
├── shared/    # Reusable admin UI
└── main.dart
```

## Rules

- All admin routes must be protected
- Role checks must not rely on UI visibility alone
- No production service account keys in this app
- Admin-only data must never ship in the player app
