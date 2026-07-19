# Shared Flutter–Unity Bridge

Reusable communication layer for all Revo Olympics Unity WebGL games.

## Planned Contents

- Flutter-to-Unity message receiver
- Unity-to-Flutter message sender
- WebGL JavaScript plugin
- JSON serialization and protocol validation
- Events: INIT_GAME, UNITY_READY, SCORE_UPDATE, TIMER_UPDATE, GAME_COMPLETED, QUIT_GAME, GAME_ERROR

## Rules

- Reusable by all games — no game-specific scoring logic here
- Breaking changes require `protocolVersion` increment
- No production Firebase credentials
- Unity does not connect to privileged Firebase Admin services

## Structure

```
Runtime/Scripts/
Runtime/Models/
Runtime/Events/
Plugins/WebGL/
Tests/EditMode/
Documentation/
```

Implementation begins in Version 1 Unity protocol sprints.
