# Unity Games

Individual Revo Olympics Unity WebGL game projects.

## Naming

```
unity/games/{game_id}/
```

Examples:

- `revo_math_race`
- `revo_quiz_challenge`

Rules: lowercase, underscores, stable game ID, no version in folder name.

## Each Game Contains

- `Assets/`
- `Packages/`
- `ProjectSettings/`

Do **not** commit `Library/`, `Builds/`, or `Temp/`.

Games are registered in Firestore — they must not be hardcoded in Flutter source (Version 1+).
