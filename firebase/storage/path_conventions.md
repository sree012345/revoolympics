# Storage Path Conventions

Planned Firebase Storage layout (from product blueprint):

```
games/{gameId}/thumbnails/
games/{gameId}/banners/
games/{gameId}/screenshots/
games/{gameId}/packages/{version}/
games/{gameId}/builds/{version}/

avatars/{avatarId}/
team_logos/{logoId}/
institutions/{institutionId}/logos/

tournaments/{tournamentId}/banners/
build_jobs/{buildJobId}/artifacts/
```

WebGL published builds deploy to **Firebase Hosting** at:

`https://games.revoolympics.com/{gameId}/{version}/index.html`
