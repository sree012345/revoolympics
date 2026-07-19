# Unity — Revo Olympics

Unity WebGL games and shared assets for Revo Olympics.

## Directories

| Path | Purpose |
|------|---------|
| `shared_bridge/` | Flutter–Unity communication (all games) |
| `game_templates/portrait_game_template/` | Portrait starter (1080×1920) |
| `game_templates/landscape_game_template/` | Landscape starter (1920×1080) |
| `games/` | Individual commercial games |

## Rules

- Unity 6.x, WebGL export
- Every game uses `shared_bridge/` — no duplicate protocols
- Commit `Assets/`, `Packages/`, `ProjectSettings/` — not `Library/` or `Builds/`
- Visible Meta Files + Force Text serialization

See [unity_source_control_rules.md](../docs/development/unity_source_control_rules.md).
