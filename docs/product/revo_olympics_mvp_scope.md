# Revo Olympics — MVP Scope

This document defines the scope of **Version 1 — Game Library MVP**, the first public MVP release of Revo Olympics.

For full product rules, see [Product Rules](./revo_olympics_product_rules.md).  
For term definitions, see [Terminology Glossary](./revo_olympics_terminology_glossary.md).

---

## MVP Definition

The first public MVP is **Version 1 — Game Library MVP**.

**Goal:** Deliver a usable Flutter application where administrators can publish Unity WebGL games and users can discover and play them without player login.

---

## Version 1 Completion Gate

Version 1 is complete when:

> An administrator can publish a new Unity WebGL game **without changing Flutter source code**, and the game appears dynamically in the player application.

---

## MVP Inclusion List

### Platform Components

| Area | Included |
|------|----------|
| Flutter player application | Yes |
| Flutter Web admin panel | Yes |
| Firebase development environment | Yes |
| Firebase production environment | Yes |
| Dynamic game catalogue (Firestore live updates) | Yes |
| English interface | Yes |
| Indian-language-ready localization architecture | Yes |

### Player Application (Version 1)

| Feature | Included |
|---------|----------|
| Splash and app shell | Yes |
| Language selection framework | Yes |
| Home / game catalogue | Yes |
| Game thumbnails and banners | Yes |
| Game details | Yes |
| Portrait Unity WebGL games | Yes |
| Landscape Unity WebGL games | Yes |
| Fullscreen WebView player | Yes |
| Loading screen and progress | Yes |
| Exit handling | Yes |
| Orientation restoration on exit | Yes |
| Basic Flutter–Unity bridge | Yes |
| Settings screen | Yes |
| Offline / error handling | Yes |
| Analytics foundation | Yes |
| Crash reporting foundation | Yes |

### Admin Panel (Version 1)

| Feature | Included |
|---------|----------|
| Admin authentication (email/password) | Yes |
| Admin dashboard | Yes |
| Game creation and editing | Yes |
| Game media upload (thumbnail, banner, etc.) | Yes |
| WebGL build upload | Yes |
| WebGL build validation | Yes |
| Build versioning | Yes |
| Build publication | Yes |
| Build activation | Yes |
| Build rollback | Yes |
| Basic audit logs | Yes |

### Backend and Operations (Version 1)

| Feature | Included |
|---------|----------|
| Firestore game catalogue | Yes |
| Firebase Storage for media and build packages | Yes |
| Firebase Hosting for published WebGL builds | Yes |
| Cloud Functions for build publishing workflow | As required for validation and deployment |
| Real-time catalogue updates | Yes |

### MVP Sample Content

Version 1 must include at least:

- One portrait Unity WebGL sample game
- One landscape Unity WebGL sample game
- Multiple game catalogue entries (including inactive/draft entries for admin testing)
- English translations throughout the player and admin interfaces
- At least one additional Indian-language translation to validate the localization architecture

---

## MVP Exclusion List

The following features **must not delay Version 1**. They belong to later versions.

### Authentication and Users

- Player registration
- Player login
- Player profiles
- Player avatars
- Google or phone authentication for players

### Institutions and Roles

- Institution selection
- General user onboarding flows (beyond localization architecture readiness)
- Institution management
- Teacher accounts
- Institution administrators (beyond admin login for platform admins)

### Teams

- Team creation
- Team logos
- Team rosters
- Team captains
- Team results

### Tournaments and Competition

- Single-game tournaments
- Olympics tournaments
- Tournament registration
- Live leaderboards
- Medals (Gold, Silver, Bronze)
- Champion and Runner-up calculation
- Official score validation and storage

### Spectator and Events

- Local spectator streaming
- Spectator Hub
- Local event sessions
- Multi-player display grid

### Build Automation

- Automated Unity build generation
- Build queue on dedicated build runners
- Version promotion pipelines

### Out of Scope (All Versions in Initial Roadmap)

- Payment system
- Advertisements
- Rewards economy
- Certificates
- AI functionality
- Public chat
- Social feeds

---

## Version Boundary Summary

| Version | Name | MVP? |
|---------|------|------|
| Foundation | Product and technical foundation | No (internal preparation) |
| **Version 1** | **Game Library MVP** | **Yes — this document** |
| Version 2 | Players, Institutions and Results | No |
| Version 3 | Teachers and Teams | No |
| Version 4 | Tournaments and Olympics | No |
| Version 5 | Local Spectator Mode | No |
| Version 6 | Automated Builds and Production Operations | No |

---

## Deferred Functionality by Version

| Functionality | Earliest Version |
|---------------|------------------|
| Player authentication | Version 2 |
| Institution selection and General onboarding | Version 2 |
| Game sessions and validated results | Version 2 |
| Teachers | Version 3 |
| Teams and team logos | Version 3 |
| Tournaments | Version 4 |
| Olympics medals and Champion calculation | Version 4 |
| Local spectator streaming | Version 5 |
| Automated Unity builds | Version 6 |

---

## MVP Acceptance Checklist

Use this checklist to confirm Version 1 readiness:

- [ ] Admin can log in to the Flutter Web admin panel
- [ ] Admin can create a game with localized title and description
- [ ] Admin can upload thumbnail and banner images
- [ ] Admin can upload a WebGL build package
- [ ] Invalid WebGL packages fail validation with clear errors
- [ ] Valid WebGL builds publish to versioned hosting
- [ ] Admin can activate and roll back build versions
- [ ] Player app shows games from Firestore without app restart
- [ ] Portrait game opens in portrait orientation
- [ ] Landscape game opens in landscape orientation
- [ ] Exit from any game restores portrait orientation
- [ ] Basic Flutter–Unity messages work (`INIT_GAME`, `UNITY_READY`, `QUIT_GAME`, `GAME_ERROR`)
- [ ] Language selector works; unsupported game language falls back correctly
- [ ] Draft and inactive games do not appear in the public player catalogue
- [ ] No player login is required to browse or play games
- [ ] Sample portrait and landscape games are included

---

## Related Documents

- [Product Rules](./revo_olympics_product_rules.md)
- [Terminology Glossary](./revo_olympics_terminology_glossary.md)
