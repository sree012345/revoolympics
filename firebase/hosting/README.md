# Firebase Hosting

Hosting targets for admin Web and Unity WebGL games.

## Targets

| Target | Path | Purpose |
|--------|------|---------|
| admin | `hosting/admin/` | Flutter Web admin deployment |
| games | `hosting/games/` | Versioned Unity WebGL builds |

## Game URL Pattern

```
https://games.revoolympics.com/{gameId}/{version}/index.html
```

Published builds must not overwrite active versions without validation.

## Headers

WebAssembly MIME type and cache headers: `headers/`

See root `firebase.json`.
