# Unity Game System Prompt Template

---

**Sprint:** Vx.y  
**Game:** [game_id]  
**Task:** [One-line goal]

## Allowed folders

- `unity/games/[game_id]/Assets/RevoOlympics/`
- `unity/games/[game_id]/Assets/RevoOlympics/Tests/`

## Do not modify

- `unity/shared_bridge/` (unless sprint explicitly includes protocol work)
- Flutter apps
- Firebase backend
- Other games

## Architecture constraints

- Unity 6.x, WebGL target
- Use shared Flutter bridge from `unity/shared_bridge/`
- Gameplay logic in plain C# classes; MonoBehaviours for lifecycle only
- Portrait or landscape per game configuration

## Protocol constraints

- Follow message envelope in `docs/game_integration/flutter_unity_protocol.md`
- Unity may send raw score, time, completion, telemetry — not official rank or medals
- Increment `protocolVersion` for breaking changes

## Security constraints

- No Firebase Admin credentials
- No tokens in URLs or bridge payloads

## Requirements

- Validate serialized references with clear errors
- Clean up event subscriptions (OnEnable/OnDisable)
- No expensive per-frame logic
- WebGL-compatible APIs only

## Required tests

- [ ] Edit Mode tests for score/protocol serialization
- [ ] Play Mode tests for session lifecycle where applicable

## Acceptance criteria

1. [Criterion 1]
2. [Criterion 2]

**Do not change unrelated files.**
