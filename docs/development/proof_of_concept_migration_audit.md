# Proof of Concept Migration Audit

**Status:** Planned — Sprint F0.4 documents migration rules only.  
**Source POC:** `/Volumes/Second/flutterunityapp/` (external; not in this repository)

## Migration Mapping

| POC Path | Target Path |
|----------|-------------|
| `flutterunityapp/flutterapp/` | `apps/player_app/` |
| `flutterunityapp/gameportrait/` | `unity/game_templates/portrait_game_template/` or `unity/games/sample_portrait_game/` |
| `flutterunityapp/gamelandscape/` | `unity/game_templates/landscape_game_template/` or `unity/games/sample_landscape_game/` |
| Shared bridge logic (extracted) | `unity/shared_bridge/` |

## Do Not Copy

- Unity `Library/`, `Temp/`, `Logs/`, `Builds/`
- Flutter `build/` output
- Old WebGL build folders
- Hardcoded local IP addresses
- Temporary Python HTTP servers
- Demo credentials
- Unused packages
- Absolute `/Volumes/Second/...` runtime paths

## Migration Process (Future Sprint)

1. Audit POC files — classify retain / rewrite / exclude
2. Extract shared bridge into `unity/shared_bridge/`
3. Migrate Flutter shell to `apps/player_app/` with flavour structure
4. Migrate portrait/landscape Unity projects to templates or sample games
5. Remove hardcoded paths; use stable content IDs and Firebase config
6. Validate WebGL load and orientation in Flutter WebView
7. Document remaining technical debt

## Files Retained

| Item | Status |
|------|--------|
| Flutter app shell concepts | To migrate in Version 1 sprint |
| Portrait Unity game | To migrate as template/sample |
| Landscape Unity game | To migrate as template/sample |
| Bridge message protocol | To extract to shared_bridge |

## Files Excluded

| Item | Reason |
|------|--------|
| Generated Unity/Flutter build output | Not source |
| Local dev server scripts | Replaced by Firebase Hosting |
| Hardcoded credentials | Security |

## Bridge Extraction

Bridge code must move to `unity/shared_bridge/` with:

- Versioned protocol (`protocolVersion`)
- JSON message contract aligned with product rules
- No game-specific scoring logic in bridge layer

## Hardcoded Paths Removed

All runtime configuration must use:

- Environment variables / Flutter flavours
- Firebase remote config (later)
- Stable game IDs — not file paths

## Remaining Technical Debt

To be updated after migration execution:

- [ ] Full bridge extraction
- [ ] Flutter flavour setup (dev/staging/prod)
- [ ] WebGL publish pipeline integration
- [ ] Sample games registered in Firestore catalogue

## Approval

Migration execution requires technical lead sign-off after audit completion.
