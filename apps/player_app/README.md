# Revo Olympics Player Application

Flutter mobile application — the main Revo Olympics player experience.

## Status

**Foundation F0.4** — directory structure and placeholders only.  
Full Flutter project initialization and features begin in **Version 1, Sprint 1.1**.

## Structure

```
lib/
├── app/          # App shell, routing
├── core/         # Config, Firebase, localization, theme
├── features/     # Feature modules (home, games, unity_player, ...)
├── shared/       # Reusable widgets
└── main.dart
```

## Rules

- Flutter is the player application; Unity WebGL loads inside WebView
- Support development, staging, and production flavours
- No hardcoded Firebase credentials in feature code
- No player login in Version 1

## Commands

```bash
# After flutter create / melos bootstrap in later sprint:
flutter run --dart-define=REVO_ENV=development
```

See [docs/development/local_setup.md](../../docs/development/local_setup.md).
