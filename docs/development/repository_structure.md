# Repository Structure

Official monorepo layout for **revoolympics**.

## Top-Level Directories

| Path | Purpose |
|------|---------|
| `apps/` | Flutter applications |
| `unity/` | Unity bridge, templates, games |
| `firebase/` | Backend configuration and code |
| `tools/` | Build and validation tooling |
| `docs/` | Product and technical documentation |
| `tests/` | Cross-cutting integration tests |
| `scripts/` | Setup, build, deploy automation |

## Applications

| App | Path | Status |
|-----|------|--------|
| Player | `apps/player_app/` | Version 1+ |
| Admin Web | `apps/admin_web/` | Version 1+ |
| Spectator Hub | `apps/spectator_hub/` | Version 5 placeholder |

Each app is independently buildable.

## Unity

| Path | Purpose |
|------|---------|
| `unity/shared_bridge/` | Shared Flutter–Unity protocol |
| `unity/game_templates/portrait_game_template/` | Portrait starter (1080×1920) |
| `unity/game_templates/landscape_game_template/` | Landscape starter (1920×1080) |
| `unity/games/{game_id}/` | Individual commercial games |

Game folder naming: lowercase, underscores, stable game ID (no version in folder name).

## Firebase

| Path | Purpose |
|------|---------|
| `firebase/functions/` | Cloud Functions (TypeScript) |
| `firebase/firestore/` | Rules, indexes, schema docs |
| `firebase/storage/` | Storage rules, path conventions |
| `firebase/hosting/` | Admin and WebGL hosting roots |
| `firebase/seed/` | Environment seed data |

## Tools

| Path | Future role |
|------|-------------|
| `tools/webgl_validator/` | Validate WebGL ZIP packages |
| `tools/build_publisher/` | Publish builds to Hosting |
| `tools/localization_validator/` | Validate translation completeness |

## Documentation

| Path | Contents |
|------|----------|
| `docs/product/` | Product rules, MVP, competition rules |
| `docs/architecture/` | System architecture |
| `docs/development/` | Setup, Git, environments |
| `docs/testing/` | Test strategy |
| `docs/operations/` | Deploy, rollback, DR |
| `docs/game_integration/` | Unity protocol, manifests |
| `docs/prompts/` | Approved Cursor prompts |

## Related

- [Git Workflow](./git_workflow.md)
- [Environment Guide](./environment_guide.md)
- [Proof of Concept Migration](./proof_of_concept_migration_audit.md)
