# Revo Olympics — Product Terminology Glossary

This glossary defines official product terms used across Revo Olympics documentation, design, development, and operations.

| Term | Definition |
|------|------------|
| **Revo Olympics** | The complete platform comprising the Flutter player application, Unity WebGL games, Flutter Web admin panel, Spectator Hub, and Firebase backend. |
| **Player Application** | The Flutter mobile application used by players to discover games, participate in competitions, and view results. |
| **Admin Panel** | The Flutter Web application used by platform administrators, institution administrators, and teachers to manage platform content and operations. |
| **Unity Game** | A game developed in Unity 6.x and exported as a WebGL build for loading inside the Flutter player application. |
| **Game Build** | A specific published WebGL version of a Unity game, including its files, metadata, validation status, and hosting URL. |
| **Active Version** | The game build used for new player sessions in a given environment (development, staging, or production). |
| **Game Catalogue** | The dynamically loaded list of available games displayed in the Flutter player application. |
| **Game Session** | One authorized gameplay instance linking a player (or team), game, version, and session token before Unity loads. |
| **Institution** | A school, college, university, training centre, academy, organization, or other approved entity whose players represent it in competitions. |
| **General** | The system-managed category for users who are not registered under an educational institution (`institutionId: general`). |
| **Player** | A registered user who plays games, joins teams, and participates in tournaments. |
| **Institution Player** | A player registered under an approved institution. |
| **General Player** | A player registered under the system-managed General category. |
| **Teacher** | An institution-level user who may manage students, teams, and institution tournaments within assigned permissions. |
| **Team** | A named group of eligible players from an institution (or General category where enabled) with a predefined logo and roster. |
| **Captain** | The designated representative of a team for participation confirmation and selected tournament workflows. |
| **Roster** | The members assigned to a team for a competition period. |
| **Roster Lock** | The point after which team membership cannot be freely changed without authorized override and audit logging. |
| **Tournament** | A structured competition containing one or more games, participants, rules, and final results. |
| **Single-Game Tournament** | A tournament using exactly one selected game (`singleGame`). |
| **Olympics Tournament** | A multi-game tournament where participants compete across multiple selected games (`olympics`). |
| **Competition Mode** | Whether a tournament is played as `solo` (individual results) or `team` (team results). |
| **Solo Mode** | Competition where the official result belongs to one individual player. |
| **Team Mode** | Competition where the official result belongs to a team, aggregated from member performances according to configured rules. |
| **Attempt** | One authorized play of a tournament game by an eligible participant. |
| **Score** | A numeric gameplay performance value calculated by Unity during play. |
| **Timer** | Gameplay elapsed or remaining time tracked during a session. |
| **Ranking Rule** | Configuration that defines how results are ordered (for example, higher score wins or lower time wins). |
| **Provisional Result** | A result that has been received but not yet finalized for official ranking or medal purposes. |
| **Final Result** | An approved official result that may affect leaderboards, medals, and tournament standings. |
| **Gold Medal** | Medal awarded to first place in a finalized ranking. |
| **Silver Medal** | Medal awarded to second place in a finalized ranking. |
| **Bronze Medal** | Medal awarded to third place in a finalized ranking. |
| **Olympics Points** | Points awarded from per-game medal placements or configured points tables in an Olympics tournament. |
| **Champion** | The overall first-ranked participant in a finalized Olympics tournament. |
| **Runner-up** | The overall second-ranked participant in a finalized Olympics tournament. |
| **Second Runner-up** | The overall third-ranked participant when enabled by tournament configuration. |
| **Institution Tournament** | A tournament restricted to one institution. |
| **Inter-Institution Tournament** | A tournament assigned to multiple institutions. |
| **General Tournament** | A tournament available to General/Public players. |
| **Spectator Hub** | The local application that displays multiple player game streams on a shared event screen. |
| **Spectator Operator** | A user who manages the Spectator Hub display during physical events. |
| **Build Runner** | A dedicated machine or self-hosted service that executes Unity batch builds outside Firebase. |
| **Rollback** | Returning to a previously published and validated game build version. |
| **Protocol Version** | The version of the Flutter–Unity communication contract used during a game session. |
| **WebGL Build** | The exported Unity game output loaded inside a fullscreen WebView in Flutter. |
| **Free Play** | A casual game session not tied to a tournament. |
| **Result Validation** | Backend verification that a submitted result is authentic, complete, and eligible before it becomes official. |

## Related Documents

- [Product Rules](./revo_olympics_product_rules.md)
- [MVP Scope](./revo_olympics_mvp_scope.md)
