# Game Integration Documentation

Guides for Unity game developers integrating with Revo Olympics.

## Planned Documents

- Unity template guide
- Flutter–Unity protocol (INIT_GAME, UNITY_READY, SCORE_UPDATE, etc.)
- Score and timer integration
- Game manifest format
- Localization requirements
- WebGL release checklist

## Protocol Reference

See product rules for Version 1 basic protocol and Version 2 expanded protocol.

## Templates

- `unity/game_templates/portrait_game_template/`
- `unity/game_templates/landscape_game_template/`

## Shared Bridge

All games must use `unity/shared_bridge/` — no incompatible duplicate implementations.
