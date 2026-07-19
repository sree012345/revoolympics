# Revo Olympics — Product Rules

**Document status:** Foundation Sprint F0.1 — Product Rules Document  
**Version:** 1.0  
**Last updated:** 2026-07-19

This document is the official product reference for Revo Olympics. It defines what the product is, who uses it, how participation and competition work, and which functionality belongs to each product version.

**Related documents:**

- [Terminology Glossary](./revo_olympics_terminology_glossary.md)
- [MVP Scope](./revo_olympics_mvp_scope.md)

---

## Table of Contents

1. [Product Identity](#1-product-identity)
2. [Core Technical Architecture Rules](#2-core-technical-architecture-rules)
3. [User Categories](#3-user-categories)
4. [Institution and General Participation Rules](#4-institution-and-general-participation-rules)
5. [Game Catalogue Rules](#5-game-catalogue-rules)
6. [Solo Participation Rules](#6-solo-participation-rules)
7. [Team Participation Rules](#7-team-participation-rules)
8. [Tournament Rules](#8-tournament-rules)
9. [Olympics Rules](#9-olympics-rules)
10. [Medal Rules](#10-medal-rules)
11. [Score and Timer Rules](#11-score-and-timer-rules)
12. [Multilingual Product Rules](#12-multilingual-product-rules)
13. [Version Boundaries](#13-version-boundaries)
14. [MVP Scope Summary](#14-mvp-scope-summary)
15. [Test Scenarios](#15-test-scenarios)
16. [Product Completion Checklist](#16-product-completion-checklist)
17. [Sprint F0.1 Completion Gate](#17-sprint-f01-completion-gate)

---

## 1. Product Identity

### 1.1 Product Name

**Revo Olympics**

### 1.2 Product Type

Revo Olympics is a multilingual gaming, educational competition, and esports tournament platform.

Players access multiple Unity WebGL games through a Flutter application and may participate in:

- Casual game sessions
- Educational game sessions
- Solo competitions
- Team competitions
- Single-game tournaments
- Multi-game Olympics-style tournaments
- Institution-level events
- Inter-institution competitions
- General or public competitions

### 1.3 Core Positioning

**One platform. Multiple games. Institutions, teams, medals and champions.**

### 1.4 Product Vision

Revo Olympics creates a common digital platform where schools, colleges, universities, training institutions, and public users participate in structured multi-game competitions.

The platform must make it possible to:

| Capability | Requirement |
|------------|-------------|
| Dynamic game publishing | Publish new Unity games without updating Flutter source code |
| Competition types | Support educational and entertainment-oriented competitions |
| Institution representation | Allow players to represent institutions |
| Public access | Support public users through the General category |
| Participation modes | Conduct individual and team competitions |
| Per-game recognition | Award Gold, Silver, and Bronze medals for individual games |
| Overall recognition | Identify an overall Olympics Champion and Runner-up |
| Event formats | Operate digital and physical events |
| Spectator experience | Display live player activity on a shared event screen |
| Language support | Support English and Indian languages |
| Scalable delivery | Scale from a simple game catalogue into a complete tournament platform |

---

## 2. Core Technical Architecture Rules

Revo Olympics is **not** a Unity-only application. Flutter is the main player-facing application; Unity provides individual game runtimes.

### 2.1 Flutter Player Application

Flutter is the main user-facing application.

**Flutter is responsible for:**

| Area | Responsibilities |
|------|------------------|
| Application lifecycle | Startup, navigation, error boundaries |
| Catalogue | Game catalogue, thumbnails, featured games |
| Identity and profiles | Authentication, institution selection, profiles, avatars |
| Social and competition UI | Team screens, tournament screens, leaderboards, medal tables |
| Communication | Notifications, Flutter-to-Unity and Unity-to-Flutter messaging |
| Game loading | Orientation control, Unity WebGL loading in fullscreen WebView |
| Results | Result submission to trusted backend (not direct official writes) |
| Resilience | Error handling, offline states, maintenance screens |

**Rule:** The player application must **not** be implemented as a Unity application.

### 2.2 Unity WebGL Game Runtime

Unity 6.x is used to create individual games. Every game is exported as a Unity WebGL build and loaded inside Flutter using a **fullscreen WebView**.

Each game declares:

- Portrait or landscape orientation
- Supported languages
- Score and timer capabilities
- Result protocol version

**Unity is responsible for:**

| Area | Responsibilities |
|------|------------------|
| Gameplay | Game mechanics, game state, completion state |
| Performance data | Score, timer, pause and resume state |
| Communication | Score/timer updates, final results, quit requests, errors |
| Localization | In-game localized content where supported by the game build |

**Rule:** Unity is the **game runtime**, not the platform shell.

### 2.3 Flutter Web Admin Panel

The administration application is developed using **Flutter Web**.

**The admin panel is responsible for:**

- Game and build management
- Institution, teacher, player, and avatar management
- Team and team logo management
- Tournament management
- Medal and result review
- Localization content management
- Build publication, activation, and rollback
- Audit logs and platform settings

### 2.4 Firebase Backend

Firebase is the core backend platform.

| Service | Responsibility |
|---------|----------------|
| Firebase Authentication | Admin, teacher, and player authentication |
| Cloud Firestore | Main product database |
| Firebase Storage | Images, avatars, logos, WebGL packages |
| Firebase Hosting | Published WebGL builds and admin portal |
| Cloud Functions | Secure result validation, tournament calculations, build publishing |
| Firebase Cloud Messaging | Tournament and result notifications |
| Firebase Remote Config | Feature flags, minimum versions, operational settings |
| Firebase Analytics | User, game, and tournament analytics |
| Firebase Crashlytics | Flutter crash reporting |
| Firebase App Check | Protection against unauthorized Firebase access |
| Realtime listeners | Live catalogue, tournament, and leaderboard updates |

**Critical security rules:**

1. Official tournament results must be validated through **trusted backend logic** (Cloud Functions).
2. Flutter and Unity clients must **not** directly write final official leaderboard positions.
3. Flutter must **not** directly write official final game results.
4. Unity must **not** directly assign official medals.

**Result submission flow:**

```
Flutter receives GAME_COMPLETED from Unity
        ↓
Flutter calls Cloud Function (e.g. submitGameResult)
        ↓
Backend validates session, score, timer, eligibility
        ↓
Backend stores accepted or rejected result
        ↓
Leaderboards and medals update only from validated data
```

---

## 3. User Categories

### 3.1 Platform Super Administrator

Complete platform-level access.

**Permissions include:**

- Create and manage administrators
- Create and manage institutions, teachers, and players
- Create and manage games; upload and publish builds
- Create tournaments; manage teams
- Review results; finalize medals, Champions, and Runners-up
- Manage platform languages, audit logs, and system settings

### 3.2 Platform Administrator

Receives selected permissions from the Super Administrator.

**Possible responsibilities:**

- Game management
- Tournament operations
- Institution management
- Content management
- Result review
- Build publishing
- Reports

### 3.3 Institution Administrator

Manages **one institution only**.

**May:**

- Manage institution information
- Approve students
- Create teachers
- Manage institution teams
- Create institution tournaments where permitted
- Assign participants
- View institution results and medal tables

**Must not:** Access another institution's private data.

### 3.4 Teacher

Belongs to **one institution**. Permissions are configurable.

**May be allowed to:**

- View institution students
- Create teams and assign members
- Select team logos
- Create institution tournaments
- Assign players to tournaments
- Manage tournament-specific teams
- View results and monitor participation

**Must not:**

- Access another institution's data
- Edit platform-wide games
- Publish Unity builds
- Change global configuration
- Approve their own elevated permissions

### 3.5 Institution Player

Registered under a school, college, university, academy, or other approved organization.

**May:**

- Create a profile and select an avatar
- View and play available games
- Join institution, inter-institution, and eligible public competitions
- Join teams and represent the institution
- View results and medals

### 3.6 General Player

Not registered under an educational institution.

**System representation:**

```json
{
  "institutionId": "general",
  "institutionType": "general"
}
```

**May:**

- Play publicly available games
- Join General and public tournaments
- Create a profile and select an avatar
- View individual results
- Join General teams where enabled

**Rule:** General must **not** be stored as `null` or an empty institution reference.

### 3.7 Spectator Operator

Manages the shared event display during physical events.

**May:**

- Join local event sessions
- View connected players
- Select display layouts
- Highlight players
- Show scores, timers, and tournament captions
- Switch between grid and focus views

### 3.8 Spectator

Watches games, leaderboards, and event displays. Does not require permission to modify game or tournament data.

---

## 4. Institution and General Participation Rules

### 4.1 Institution Types

Supported institution types include:

| Type |
|------|
| School |
| College |
| University |
| Training centre |
| Coaching centre |
| Esports academy |
| Corporate organization |
| Government organization |
| Community organization |
| General/Public |

### 4.2 Institution Creation

Institutions are created through the admin panel.

**Required fields:**

- Institution name
- Institution code
- Institution type
- Address, district, state, country
- Primary contact
- Institution logo
- Status
- Supported languages

### 4.3 Institution Status

| Status | Meaning |
|--------|---------|
| `draft` | Not yet ready for use |
| `pendingApproval` | Awaiting platform approval |
| `active` | Can receive registrations and tournament assignments |
| `suspended` | Temporarily restricted |
| `inactive` | Not accepting new activity |
| `archived` | Historical record only |

**Rule:** Only **active** institutions can receive new player registrations and tournament assignments.

### 4.4 Player Institution Selection

After registration, the player must select an available institution **or** General/Public.

**Selection methods may include:**

- Institution search
- Institution code
- Invitation link
- Teacher invitation
- Administrator assignment

### 4.5 Institution Approval

An institution may configure player joining as:

| Mode | Behavior |
|------|----------|
| `automatic` | Player joins immediately |
| `teacherApproval` | Teacher must approve |
| `institutionAdminApproval` | Institution admin must approve |
| `platformAdminApproval` | Platform admin must approve |

### 4.6 General Participation

General participation must always be represented by a valid backend entity.

**Recommended system document:**

```json
{
  "institutionId": "general",
  "name": "General",
  "institutionType": "general",
  "isSystemManaged": true,
  "isActive": true
}
```

### 4.7 Tournament Institution Assignment

A tournament may be assigned to:

| Scope | Description |
|-------|-------------|
| One institution | `singleInstitution` |
| Multiple selected institutions | `multipleInstitutions` |
| General players only | `general` |
| All active institutions | `allInstitutions` |
| Institutions plus General | `institutionsAndGeneral` |

### 4.8 Institution Data Isolation

Institution-scoped users must only access permitted institution data.

A teacher from Institution A **must not**:

- View private player data from Institution B
- Modify teams belonging to Institution B
- Add Institution B players to a team
- Modify Institution B tournaments
- View private Institution B reports

---

## 5. Game Catalogue Rules

### 5.1 Dynamic Game Catalogue

Games are loaded dynamically from Firestore. The Flutter application must **not** require source-code modification when a new game is added.

**The catalogue displays:**

- Thumbnail
- Game title and short description
- Category
- Portrait or landscape indicator
- Supported languages
- Featured and availability status
- Tournament availability
- Minimum application version

**Rule:** Games update through Firestore listeners without requiring an application restart.

### 5.2 Game Status

| Status | Player visibility |
|--------|-------------------|
| `draft` | Hidden |
| `testing` | Hidden (or restricted testers only) |
| `published` | Visible when active |
| `inactive` | Hidden |
| `maintenance` | Hidden or maintenance message |
| `archived` | Hidden |

**Rule:** Only **published and active** games appear to normal players. Draft games must not appear in the public catalogue.

### 5.3 Game Orientation

Every game declares `portrait` or `landscape`.

| Game type | Flutter orientation while playing |
|-----------|-----------------------------------|
| Portrait | `DeviceOrientation.portraitUp` |
| Landscape | `DeviceOrientation.landscapeLeft`, `DeviceOrientation.landscapeRight` |

**On every exit path**, Flutter must restore `DeviceOrientation.portraitUp`.

Exit paths include: Unity quit, Flutter exit, Android back, navigation pop, load failure, and app lifecycle interruption.

### 5.4 Game Build Versioning

Each game may have multiple builds. Only one build should normally be active per environment.

**Environments:** Development, Staging, Production

**Build statuses:**

| Status | Description |
|--------|-------------|
| `uploaded` | Package received |
| `validating` | Validation in progress |
| `validationFailed` | Failed checks |
| `readyForTesting` | Passed validation, not yet live |
| `approved` | Approved for publication |
| `published` | Deployed to hosting |
| `deprecated` | Superseded but retained |
| `disabled` | Not available for new sessions |

**Rule:** A WebGL build must not overwrite the currently active build until validation succeeds.

### 5.5 Game Availability

A game may be available for:

- Free play
- Solo tournaments
- Team tournaments
- Olympics tournaments
- Institution-only play
- General play
- Selected institutions
- All users

### 5.6 Game Language Support

Every game declares supported languages.

**Example:**

```json
{
  "supportedLanguages": ["en", "ta", "hi", "ml"]
}
```

**When the player's selected language is unavailable:**

1. Use English when supported
2. Otherwise use the game's configured default language
3. Inform Flutter which language Unity is using

**Rule:** Missing translations must not crash the application.

### 5.7 Game Result Capabilities

Each game declares supported result fields, such as:

- Score
- Timer
- Completion state
- Accuracy, collected items, level reached
- Penalties, bonus points, custom statistics

**Version 2 minimum requirement:** Final score, elapsed time, and completion status.

### 5.8 Game Visibility Rules

Games may be filtered by:

- Institution
- Player age group
- Application version
- Device support
- Language
- Tournament assignment
- Game status
- Scheduled availability

---

## 6. Solo Participation Rules

### 6.1 Solo Definition

In solo mode, the result belongs to **one individual player**.

**A solo result must include:**

| Field | Required |
|-------|----------|
| Player ID | Yes |
| Institution ID | Yes |
| Game ID | Yes |
| Game version | Yes |
| Session ID | Yes |
| Score | Yes (when applicable) |
| Time | Yes (when applicable) |
| Completion state | Yes |
| Submission timestamp | Yes |
| Validation state | Yes |

### 6.2 Solo Eligibility

A player may participate only when:

- The player account is active
- The institution or General category is eligible
- Registration is approved where required
- The tournament is active
- Attempt limits have not been exceeded
- The correct game version is used

### 6.3 Solo Ranking

Solo ranking uses the game or tournament ranking configuration.

**Supported ranking types** (see [Section 11.3](#133-supported-ranking-types)):

- `higher_score`
- `lower_time`
- `score_then_time`
- `time_then_score`
- `normalized_score`
- `completion_points`
- `custom_points_table`

### 6.4 Solo Medal Eligibility

Gold, Silver, and Bronze are awarded to the first three **eligible finalized** solo results.

**Rules:**

- Disqualified or rejected results must not receive medals
- Unvalidated results must not be marked final
- Medals must not be published before result review

---

## 7. Team Participation Rules

> **Version note:** Teams are introduced in **Version 3**. They are excluded from Version 1 and Version 2.

### 7.1 Team Definition

A team is a named group of eligible players.

**Each team has:**

- Team ID, name, and caption
- Institution
- Predefined logo
- Teacher or administrator manager
- Captain
- Members
- Status

### 7.2 Team Creation

Teams can be created by:

- Platform Administrator
- Institution Administrator
- Authorized teacher

General users may use General teams where enabled.

### 7.3 Team Logo Rule

Teams must initially select from **predefined logos**.

This prevents offensive images, copyright violations, inconsistent quality, and unmoderated uploads.

Custom logo uploads may be added in a future version after moderation tools exist.

### 7.4 Team Membership

Membership restrictions are configured per tournament:

| Rule option | Description |
|-------------|-------------|
| One team per tournament | Player joins one team for that event |
| One team per institution | Player belongs to one active institution team |
| Multiple teams | Allowed across different tournament categories |

### 7.5 Team Captain

Each active team should have one captain.

**The captain may:**

- View team roster
- Confirm participation
- Receive tournament notifications
- Represent the team in selected workflows

**The captain cannot** modify official results.

### 7.6 Team Roster Lock

Before a tournament begins, the roster must be locked.

**After roster lock:**

- Members cannot be freely added or removed
- Replacements require authorization
- Every override requires a reason
- A roster snapshot must be stored

**Rule:** A team roster must not change freely after lock.

### 7.7 Team Result Models

Supported team calculation models:

| Model | Description |
|-------|-------------|
| Best player result | Highest individual score or best time |
| Sum of all player scores | Total of member scores |
| Best N player results | Top N members count |
| Average score | Mean of member scores |
| Lowest combined time | Best aggregate time |
| Relay completion time | Sequential relay total |
| Weighted member score | Configured weights per member |
| Custom configured rule | Admin-defined formula |

### 7.8 Team Medal Eligibility

Gold, Silver, and Bronze may be awarded to teams.

The medal belongs to the team result. Individual members may also receive a medal record connected to the team award.

---

## 8. Tournament Rules

> **Version note:** Full tournament management begins in **Version 4**. Version 2 does not include complete tournament management.

### 8.1 Tournament Types

| Type | Description |
|------|-------------|
| `singleGame` | One selected game |
| `olympics` | Multiple selected games |

### 8.2 Competition Modes

Each tournament uses one mode:

| Mode | Description |
|------|-------------|
| `solo` | Individual results |
| `team` | Team results |

Combined solo and team categories inside one tournament may be added in a future version but are not required for the first tournament release.

### 8.3 Tournament Creators

Tournaments can be created by:

- Platform Administrator
- Institution Administrator
- Authorized teacher

Teacher-created tournaments may require approval before publication.

### 8.4 Tournament Scope

| Scope | Target audience |
|-------|-----------------|
| `singleInstitution` | One institution |
| `multipleInstitutions` | Selected institutions |
| `general` | General/Public players |
| `allInstitutions` | All active institutions |
| `institutionsAndGeneral` | Institutions plus General |

### 8.5 Tournament Status Workflow

```
draft
  → pendingApproval
  → published
  → registrationOpen
  → registrationClosed
  → inProgress
  → resultReview
  → finalized
  → archived

(cancelled may occur from several states)
```

### 8.6 Tournament Caption

Administrators and authorized teachers may create a localized tournament caption shown on:

- Tournament cards
- Registration screen
- Game loading screen
- Leaderboard
- Spectator display
- Result announcement

### 8.7 Tournament Registration

Supported registration methods:

- Open registration
- Invitation
- Admin assignment
- Teacher assignment
- Team assignment
- Institution automatic qualification

### 8.8 Tournament Games

| Tournament type | Games |
|-----------------|-------|
| Single-game | Exactly one game |
| Olympics | Multiple games |

**Each selected game stores:**

- Game ID and version
- Play order
- Start and end date/time
- Attempt limit
- Ranking rule
- Medal rule
- Weight
- Points table

### 8.9 Attempt and Retry Rules

A tournament may configure:

| Setting | Options |
|---------|---------|
| Attempt count | One or multiple |
| Scoring method | Best, latest, or average attempt |
| Retry permission | Admin-approved retry |
| Technical failure | Retry after failure |
| Completed attempt | No retry after valid completion |

### 8.10 Result States

| State | Affects official ranking |
|-------|--------------------------|
| `pending` | No |
| `received` | No |
| `validating` | No |
| `accepted` | Yes (provisional) |
| `rejected` | No |
| `suspicious` | No (until reviewed) |
| `underReview` | No |
| `finalized` | Yes |
| `disqualified` | No |

**Rule:** Only **accepted** and **finalized** results can affect official medals and final rankings.

---

## 9. Olympics Rules

### 9.1 Olympics Definition

Olympics mode is a tournament containing **multiple selected games**.

Players or teams compete across games. Each game produces:

- Its own leaderboard
- Gold, Silver, and Bronze medals
- Olympics points

After all games are finalized, the system calculates the overall ranking.

### 9.2 Olympics Participation

An Olympics tournament may require participants to:

- Participate in every game
- Participate in a minimum number of games
- Participate only in assigned games
- Use different team members for different games
- Use the same team roster throughout

The selected rule must be fixed **before registration closes**.

### 9.3 Per-Game Medal Rule

For every Olympics game:

| Rank | Medal |
|------|-------|
| 1 | Gold |
| 2 | Silver |
| 3 | Bronze |

Medals are awarded only after result review and leaderboard freeze.

**Rule:** Unity must not directly assign official medals.

### 9.4 Olympics Points

**Recommended default:**

| Medal | Points |
|-------|--------|
| Gold | 5 |
| Silver | 3 |
| Bronze | 1 |

The points table must be configurable. Other placements may optionally receive participation points.

### 9.5 Overall Olympics Ranking

**Recommended default tie-break order:**

1. Highest total Olympics points
2. Highest number of Gold medals
3. Highest number of Silver medals
4. Highest number of Bronze medals
5. Highest total normalized game score
6. Earliest completion of all required games

### 9.6 Champion and Runner-up

After all selected games are finalized:

| Overall rank | Title |
|--------------|-------|
| 1 | Champion |
| 2 | Runner-up |
| 3 | Second Runner-up (when enabled) |

Results remain **provisional** until an authorized administrator finalizes them.

### 9.7 Missed Game Rule

A participant who misses a required game may receive:

- Zero points
- Non-completion status
- Disqualification from overall ranking
- Reduced eligibility

The rule must be configured before the tournament starts.

### 9.8 Olympics Team Participation

In team Olympics mode:

- The same team represents itself across selected games
- Different eligible members may play different games where allowed
- The roster must be locked
- Each game result belongs to the team
- Team medals contribute to overall team ranking

---

## 10. Medal Rules

### 10.1 Medal Types

`gold`, `silver`, `bronze`

### 10.2 Medal Award Record

Each medal record should include:

- Medal ID
- Tournament ID and tournament game ID
- Game ID
- Winner type (player or team)
- Player ID or Team ID
- Institution ID
- Medal type and final rank
- Score and time
- Awarded date
- Finalized by
- Validation reference

### 10.3 Provisional Medals

Medals must initially remain provisional during result review.

| Status | Meaning |
|--------|---------|
| `provisional` | Awaiting review |
| `approved` | Reviewed and approved |
| `published` | Publicly visible |
| `revoked` | Withdrawn |
| `reassigned` | Moved to another participant |

**Rule:** A tournament medal must not be published before result review.

### 10.4 Medal Reassignment

When a medal winner is disqualified:

1. Recalculate leaderboard
2. Move eligible lower-ranked participants upward
3. Reassign medals
4. Store audit log
5. Notify affected participants
6. Update Olympics standings

### 10.5 Institution Medal Table

Institution standings show:

- Gold, Silver, and Bronze counts
- Total Olympic points
- Total finalists and participants

### 10.6 Medal Tie Rule

Two participants must **not** normally receive the same medal unless the tournament explicitly allows shared medals.

The standard system resolves ties using configured tie-breakers (see [Section 11.12](#1112-tie-breaking-order)).

---

## 11. Score and Timer Rules

### 11.1 Score Ownership

| Layer | Role |
|-------|------|
| Unity | Calculates gameplay score |
| Flutter | Receives updates for display and session monitoring |
| Cloud Functions | Validates and stores the official final result |

### 11.2 Timer Ownership

Unity may calculate the gameplay timer, but the backend must also maintain trusted session timing.

The backend compares:

- Server session start
- Server result receipt
- Unity elapsed time
- Allowed tournament duration

### 11.3 Supported Ranking Types

| Type | Primary ordering |
|------|------------------|
| `higher_score` | Highest score wins |
| `lower_time` | Lowest time wins |
| `score_then_time` | Highest score; tie-break by lowest time |
| `time_then_score` | Lowest time; tie-break by highest score |
| `normalized_score` | Normalized comparison across sessions |
| `completion_points` | Points based on completion criteria |
| `custom_points_table` | Admin-defined points mapping |

#### Higher Score Example

| Player | Score | Rank |
|--------|-------|------|
| Player A | 5,000 | 1 |
| Player B | 4,500 | 2 |
| Player C | 4,000 | 3 |

#### Lower Time Example

| Player | Time | Rank |
|--------|------|------|
| Player A | 48.2 sec | 1 |
| Player B | 50.0 sec | 2 |
| Player C | 55.4 sec | 3 |

#### Score Then Time Example

| Player | Score | Time | Rank |
|--------|-------|------|------|
| Player A | 5,000 | 60 sec | 1 |
| Player B | 5,000 | 67 sec | 2 |
| Player C | 4,800 | 50 sec | 3 |

#### Time Then Score

Primary: lowest time. Tie-breaker: highest score.

### 11.4 Completion Requirement

A result may be ranked only when:

- The game sends a valid completion state
- Minimum gameplay duration is satisfied
- Maximum gameplay duration is not exceeded
- Required checkpoints or objectives are completed
- Result validation succeeds

### 11.5 Score Validation

The backend should validate:

- Minimum and maximum score bounds
- Maximum score change rate
- Expected gameplay duration
- Game version and session ownership
- Duplicate submission and attempt limits
- Tournament status and participant eligibility

### 11.6 Timer Validation

The backend should validate:

- Timer is not negative
- Timer is within configured minimum and maximum
- Timer is consistent with server timestamps
- Session has not expired
- Pause rules were followed

### 11.7 Incomplete Results

Incomplete results may be:

- Rejected
- Recorded without ranking
- Assigned zero points
- Marked as did not finish
- Eligible for technical retry

The rule is configured per tournament.

### 11.8 Tie-Breaking Order

**Recommended default:**

1. Primary ranking value
2. Secondary ranking value
3. Fewer penalties
4. Fewer attempts
5. Earlier valid completion
6. Administrator-approved playoff where necessary

---

## 12. Multilingual Product Rules

### 12.1 Version 1 Requirement

Multilingual architecture must exist from **Version 1**.

The first release must include:

- English
- Language-selector framework
- Translation-file structure
- Firestore localized-content structure
- Fallback logic
- Right-to-left support preparation

### 12.2 Supported Languages

The product architecture supports **English and 22 scheduled Indian languages**:

Assamese, Bengali, Bodo, Dogri, Gujarati, Hindi, Kannada, Kashmiri, Konkani, Maithili, Malayalam, Manipuri, Marathi, Nepali, Odia, Punjabi, Sanskrit, Santali, Sindhi, Tamil, Telugu, Urdu.

Supporting all languages in the platform does not mean every Unity game is automatically translated. Each game build declares which languages it supports.

### 12.3 Admin-Created Content

The admin panel allows localized versions of:

- Game title and description
- Tournament name, caption, and instructions
- Notification title and body
- CMS content

### 12.4 Translation Fallback

**Fallback order:**

1. Selected language
2. English
3. Default configured language
4. Internal content key (development environments only)

### 12.5 Unity Language Rules

Flutter sends the selected language to Unity. Unity must:

- Use the selected language when supported
- Use its default language when unsupported
- Report the final language used
- Avoid crashing because of missing translation content

---

## 13. Version Boundaries

Each version has explicit inclusions and exclusions. No version should implement features reserved for a later version unless this document is formally revised.

### 13.1 Version 1 — Game Library MVP

**Included:**

- Flutter player application (no player login)
- Language architecture
- Dynamic game catalogue
- Portrait and landscape WebGL games in fullscreen WebView
- Admin authentication, game creation, media upload
- WebGL build upload, validation, publication, activation, rollback
- Basic Flutter–Unity communication

**Excluded:**

- Player accounts, institutions, teams, tournaments
- Official score storage and medal calculations
- Local spectator streaming
- Automated Unity builds

### 13.2 Version 2 — Players, Institutions and Results

**Included:**

- Player authentication, institution selection, General option
- Player profiles, avatars, game sessions
- Score and timer updates, final result validation
- Player history and personal bests

**Excluded:**

- Team management, teacher management
- Tournament creation and medal calculation
- Spectator streaming

### 13.3 Version 3 — Teachers and Teams

**Included:**

- Teacher accounts and institution permissions
- Team creation, captions, predefined logos
- Team member assignment, captain, roster lock
- Team game sessions and team results

**Excluded:**

- Full tournament engine
- Olympics medals and Champion calculation
- Local streaming

### 13.4 Version 4 — Tournaments and Olympics

**Included:**

- Single-game and Olympics tournaments
- Solo and team competition
- Institution targeting and General tournaments
- Attempt rules, live leaderboards, per-game medals
- Overall Champion and Runner-up
- Teacher tournament workflows, result review, finalization

**Excluded:**

- Local player video streaming
- Automated Unity build runner

### 13.5 Version 5 — Local Spectator Mode

**Included:**

- Local event sessions and player stream publishing
- Local network discovery and Spectator Hub
- Multi-player display grid, focus mode, overlays
- TV/projector display and local offline event support

**Architecture note:** Live video travels through the **local network** (WebRTC). Firebase manages event metadata; Firebase does **not** stream game video.

**Excluded:**

- Fully automated Unity build generation

### 13.6 Version 6 — Automated Builds and Production Operations

**Included:**

- Standard Unity game template and batch-build scripts
- Build queue and dedicated/self-hosted build runner
- Automatic WebGL generation, validation, upload, and hosting deployment
- Build approval, version promotion, atomic activation, rollback
- Monitoring and disaster recovery

**Architecture note:** Firebase does **not** run the Unity Editor. Builds run on dedicated machines or self-hosted CI runners.

---

## 14. MVP Scope Summary

The first public MVP is **Version 1**. See [MVP Scope](./revo_olympics_mvp_scope.md) for the full inclusion list, exclusion list, and Version 1 completion gate.

**Version 1 completion gate:**

> An administrator can publish a new Unity WebGL game without changing Flutter source code, and the game appears dynamically in the player application.

---

## 15. Test Scenarios

These scenarios validate that this document is complete, consistent, and ready for stakeholder review.

### 15.1 Positive Test Scenarios

| # | Scenario | Expected |
|---|----------|----------|
| P1 | Reader asks "What is Revo Olympics?" | Document explains platform purpose and vision |
| P2 | Reader asks "Why Flutter?" | Flutter identified as main player-facing application |
| P3 | Reader asks "Why Unity WebGL?" | Unity identified as game runtime inside WebView |
| P4 | Admin technology | Flutter Web identified for admin panel |
| P5 | Backend | Firebase identified with service responsibilities |
| P6 | Institution vs General | Clearly separated; General is system-managed entity |
| P7 | Solo vs team | Both modes defined with result ownership |
| P8 | Tournament types | `singleGame` and `olympics` defined |
| P9 | Medals | Gold, Silver, Bronze rules documented |
| P10 | Champion selection | Overall ranking and finalization documented |
| P11 | Ranking | Score and timer rules with examples documented |
| P12 | Tie-breaks | Tie-breaking order documented |
| P13 | Version boundaries | Versions 1–6 clearly separated |
| P14 | MVP scope | Inclusions and exclusions explicit |
| P15 | Glossary | All key terms defined in glossary document |
| P16 | No implementation code | Documentation contains no application source code |

### 15.2 Negative Test Scenarios

| # | Scenario | Document must NOT |
|---|----------|-------------------|
| N1 | Player app technology | Describe Unity as the complete player application |
| N2 | Game engine | Describe Flutter as the game engine |
| N3 | Version 1 auth | Include player authentication |
| N4 | Version 1 institutions | Include institutions |
| N5 | Version 1 teams | Include teams |
| N6 | Version 2 tournaments | Include complete tournament management |
| N7 | Version 3 Olympics | Include Olympics finalization |
| N8 | Version 4 streaming | Include local player streaming |
| N9 | Version 5 video | Claim Firebase streams game video |
| N10 | Version 6 builds | Claim Firebase runs the Unity Editor |
| N11 | General users | Use null institution reference |
| N12 | Teacher isolation | Grant cross-institution data access |
| N13 | Official rankings | Allow clients to write official final rankings |
| N14 | Medal assignment | Allow Unity to assign official medals |
| N15 | Unvalidated results | Mark unvalidated results as final |
| N16 | Draft games | Show draft games in public catalogue |
| N17 | Inactive institutions | Accept new registrations |
| N18 | Roster lock | Allow free roster changes after lock |
| N19 | Medal publication | Publish medals before result review |
| N20 | Missing translations | Cause application crashes |

---

## 16. Product Completion Checklist

Use this checklist for Sprint F0.1 acceptance:

- [ ] `docs/product/revo_olympics_product_rules.md` exists
- [ ] Product vision is clearly documented
- [ ] Flutter confirmed as player application
- [ ] Unity WebGL confirmed as game runtime
- [ ] Flutter Web confirmed as admin application
- [ ] Firebase confirmed as backend
- [ ] User categories documented
- [ ] Institution participation documented
- [ ] General participation documented as system entity
- [ ] Game catalogue rules documented
- [ ] Solo rules documented
- [ ] Team rules documented
- [ ] Tournament rules documented
- [ ] Olympics rules documented
- [ ] Medal rules documented
- [ ] Score and timer rules documented
- [ ] Multilingual rules documented
- [ ] Version 1 through Version 6 boundaries clearly separated
- [ ] MVP inclusions documented
- [ ] MVP exclusions documented
- [ ] Terminology glossary exists
- [ ] Positive test scenarios documented
- [ ] Negative test scenarios documented
- [ ] No contradictions found during review
- [ ] Product owners and technical leads approve
- [ ] Documents committed to source control

---

## 17. Sprint F0.1 Completion Gate

No application-development sprint should begin until stakeholders can answer these questions consistently:

| Question | Answer source |
|----------|---------------|
| What is Revo Olympics? | [Section 1](#1-product-identity) |
| Why is Flutter used? | [Section 2.1](#21-flutter-player-application) |
| Why is Unity WebGL used? | [Section 2.2](#22-unity-webgl-game-runtime) |
| How are portrait and landscape games handled? | [Section 5.3](#53-game-orientation) |
| Who is an Institution Player? | [Section 3.5](#35-institution-player) |
| Who is a General Player? | [Section 3.6](#36-general-player) |
| What is the difference between solo and team mode? | [Sections 6](#6-solo-participation-rules) and [7](#7-team-participation-rules) |
| What is the difference between single-game and Olympics? | [Sections 8.1](#81-tournament-types) and [9](#9-olympics-rules) |
| How are Gold, Silver, and Bronze awarded? | [Sections 9.3](#93-per-game-medal-rule) and [10](#10-medal-rules) |
| How is the overall Champion selected? | [Section 9.6](#96-champion-and-runner-up) |
| How are score and time used in ranking? | [Section 11](#11-score-and-timer-rules) |
| What belongs to each version? | [Section 13](#13-version-boundaries) |
| What is excluded from the MVP? | [MVP Scope](./revo_olympics_mvp_scope.md) |

---

*End of document.*
