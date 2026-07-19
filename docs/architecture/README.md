# Architecture Documentation

System architecture documents for Revo Olympics.

## Documents

| Topic | Status |
|-------|--------|
| Overall architecture | See [product rules](../product/revo_olympics_product_rules.md) §2 |
| Flutter architecture | Version 1 sprint |
| Unity architecture | Version 1 sprint |
| Firebase architecture | [firebase_environment_architecture.md](firebase_environment_architecture.md) (Sprint F0.5) |
| Analytics events | [analytics_event_schema.md](analytics_event_schema.md) |
| Security architecture | [secret_handling.md](../development/secret_handling.md) |
| WebGL publishing | Version 1 sprint |
| Spectator architecture | Version 5 |

## Core Decisions (Fixed)

- **Flutter** = player application shell
- **Unity WebGL** = game runtime in fullscreen WebView
- **Flutter Web** = admin panel
- **Firebase** = backend; Cloud Functions validate official results
- **Monorepo** = single repository for all platform components

## Related

- [Repository structure](../development/repository_structure.md)
- [Product rules](../product/revo_olympics_product_rules.md)
