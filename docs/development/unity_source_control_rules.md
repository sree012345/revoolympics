# Unity Source Control Rules

Every Unity project in `unity/` must follow these Project Settings.

## Required Settings

| Setting | Value |
|---------|-------|
| Version Control Mode | **Visible Meta Files** |
| Asset Serialization Mode | **Force Text** |

Location: *Edit → Project Settings → Editor*

## Why

- `.meta` files must be committed for stable asset references
- Text serialization enables meaningful diffs and merge tools

## Never Commit

- `Library/`
- `Temp/`
- `Obj/`
- `Logs/`
- `UserSettings/`
- `Build/` / `Builds/`
- `MemoryCaptures/`
- `Recordings/`

These are covered by the root `.gitignore`.

## Scene Merge

Configure Unity Smart Merge (YAML) for:

- Scenes (`.unity`)
- Prefabs (`.prefab`)
- ScriptableObjects (`.asset`)
- Animator controllers

Avoid multiple developers editing the same large scene simultaneously.

## WebGL Builds

Published WebGL output goes to **Firebase Storage / Hosting**, not Git.

Use Git LFS only for large source art when necessary — not for routine WebGL build artifacts.

## Game Projects

Each game under `unity/games/{game_id}/` is a separate Unity project with its own `ProjectSettings/`.

Templates under `unity/game_templates/` are starting points — clone to `unity/games/` for commercial games.
