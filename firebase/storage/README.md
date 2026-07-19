# Firebase Storage

Authoritative rules: `storage.rules`

## Path Conventions

See `path_conventions.md` for planned structure:

- `games/{gameId}/thumbnails/`
- `games/{gameId}/packages/{version}/`
- `avatars/{avatarId}/`
- `institutions/{institutionId}/logos/`

## Principles

- Validate file type and size on upload
- Versioned game build paths
- Normal users cannot upload WebGL packages
