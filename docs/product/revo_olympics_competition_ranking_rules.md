# Revo Olympics — Competition and Ranking Rules

**Document status:** Foundation Sprint F0.2 — Competition and Ranking Rules  
**Version:** 1.0  
**Last updated:** 2026-07-19

This document is the authoritative competition and ranking rulebook for Revo Olympics. It defines how player and team performances are received, validated, ranked, scored, tied, retried, disqualified, and approved as final results.

**Related documents:**

- [Product Rules](./revo_olympics_product_rules.md)
- [Result Status Rules](./revo_olympics_result_status_rules.md)
- [Points Table Examples](./revo_olympics_points_table_examples.md)
- [Terminology Glossary](./revo_olympics_terminology_glossary.md)

---

## Table of Contents

1. [Core Competition Principles](#1-core-competition-principles)
2. [Competition Terminology](#2-competition-terminology)
3. [Supported Ranking Modes](#3-supported-ranking-modes)
4. [Ranking Mode Details](#4-ranking-mode-details)
5. [Ranking Configuration Model](#5-ranking-configuration-model)
6. [Attempt Selection Rules](#6-attempt-selection-rules)
7. [Tie Handling](#7-tie-handling)
8. [Invalid Attempt Handling](#8-invalid-attempt-handling)
9. [Incomplete Game Handling](#9-incomplete-game-handling)
10. [Retry Rules](#10-retry-rules)
11. [Disqualification Rules](#11-disqualification-rules)
12. [Penalties](#12-penalties)
13. [Team Ranking Rules](#13-team-ranking-rules)
14. [Final-Result Approval](#14-final-result-approval)
15. [Leaderboard Rules](#15-leaderboard-rules)
16. [Recommended Default Rules](#16-recommended-default-rules)
17. [Example Competition Scenarios](#17-example-competition-scenarios)
18. [Required Data Fields](#18-required-data-fields)
19. [Administration Requirements](#19-administration-requirements)
20. [Test Scenarios](#20-test-scenarios)
21. [Acceptance Criteria](#21-acceptance-criteria)
22. [Sprint F0.2 Completion Gate](#22-sprint-f02-completion-gate)

---

## 1. Core Competition Principles

### 1.1 Fairness

All participants must be evaluated using the **same published rules**.

The following must be fixed **before a tournament begins**:

| Rule element | Must be fixed before start |
|--------------|---------------------------|
| Ranking mode | Yes |
| Score direction | Yes |
| Time direction | Yes |
| Attempt limit | Yes |
| Retry policy | Yes |
| Tie-break order | Yes |
| Minimum completion requirements | Yes |
| Tournament-points formula | Yes |
| Team aggregation formula | Yes |
| Medal-points table | Yes |
| Disqualification rules | Yes |

These rules must **not** change after valid tournament attempts have started unless an authorized administrator performs an **emergency correction** with a recorded reason, participant notification where required, and audit logging.

### 1.2 Backend Authority

Unity calculates gameplay values (score, elapsed time, accuracy, checkpoints, objectives, penalties, completion state). Flutter receives and displays those values.

**Official ranking must be calculated by trusted backend logic.**

```
Unity game
    ↓
Flutter application
    ↓
Secure result-submission function (Cloud Function)
    ↓
Validation
    ↓
Accepted result
    ↓
Leaderboard calculation
```

**The Flutter application and Unity game must not directly:**

- Assign official rank
- Award Gold, Silver, or Bronze
- Declare an overall Champion
- Write official leaderboard positions
- Approve their own result
- Override another participant's result

### 1.3 Published Rules

Players must see important competition rules **before beginning an attempt**.

The tournament screen must show at minimum:

- Ranking mode
- Number of attempts and which attempt counts
- Score direction and time direction
- Tie-break rule
- Retry conditions
- Completion requirement
- Start and end times

### 1.4 Immutable Attempt Records

Once a result is submitted, its **original data must be preserved**.

Corrections must create:

- A new reviewed status
- An adjustment record
- An audit entry
- A recalculated leaderboard

The original result must **not** be silently overwritten.

---

## 2. Competition Terminology

| Term | Definition |
|------|------------|
| **Attempt** | One authorized play of a game |
| **Valid attempt** | An attempt that passed all required validations |
| **Invalid attempt** | An attempt rejected for technical or competition rule violations |
| **Incomplete attempt** | An attempt that started but did not satisfy completion requirements |
| **Technical failure** | Failure caused by application, device, network, server, or game build |
| **Player failure** | Failure caused by voluntary exit, abandonment, or failure to complete |
| **Raw score** | Score generated directly by the Unity game |
| **Adjusted score** | Raw score after approved bonuses or penalties |
| **Elapsed time** | Time consumed by the participant (stored in milliseconds) |
| **Remaining time** | Unused time remaining in a timed game |
| **Ranking value** | Value used to order leaderboard entries |
| **Tournament points** | Standardized points based on result or placement |
| **Placement points** | Points assigned according to finishing position |
| **Normalized score** | A converted score on a common scale (typically 0–1,000) |
| **Primary ranking rule** | First value used to rank participants |
| **Secondary ranking rule** | First tie-break value |
| **Final result** | A reviewed and approved official result |
| **Provisional result** | A result that may still change after validation or review |
| **Disqualification** | Removal of a player, team, or result for a serious rule violation |
| **Did Not Finish (DNF)** | A started attempt that did not meet completion requirements |
| **Did Not Start (DNS)** | A registered participant who never began the assigned game |
| **Retry** | A replacement or additional attempt authorized under tournament rules |
| **Best attempt** | Highest-ranked valid result from permitted attempts |
| **Latest attempt** | Most recent valid result |
| **Average attempt** | Average of selected valid attempts |
| **Leaderboard freeze** | Temporary stop to ranking changes while results are reviewed |

---

## 3. Supported Ranking Modes

Revo Olympics supports exactly **seven** ranking modes. Each tournament game must select **one** primary ranking mode.

| Mode key | Description |
|----------|-------------|
| `highest_score` | Highest valid adjusted score wins |
| `lowest_time` | Lowest valid elapsed time wins |
| `highest_score_then_lowest_time` | Score primary; time tie-break |
| `lowest_time_then_highest_score` | Time primary; score tie-break |
| `normalized_tournament_points` | Raw values converted to common 0–1,000 scale |
| `completion_based` | Ranked by completion status and percentage |
| `admin_defined_points_table` | Admin-defined placement or performance bands |

These modes support:

- Free-play results
- Solo and team competitions
- Single-game and multi-game Olympics tournaments
- Score-based, time-based, combined, completion-based, and admin-defined systems

---

## 4. Ranking Mode Details

### 4.1 Mode 1 — Highest Score Wins (`highest_score`)

#### Definition

The participant with the highest valid **adjusted score** ranks first. Higher score = better rank.

#### Suitable games

Endless runners, shooting games, quiz games, collection games, target games, sports scoring games, survival games, puzzle games with points.

#### Ranking order

```
Rank by adjustedScore descending
```

#### Example

| Player | Score | Rank |
|--------|-------|------|
| Player A | 8,500 | 1 |
| Player B | 7,900 | 2 |
| Player C | 6,250 | 3 |

#### Recommended tie-break order

1. Higher adjusted score
2. Lower elapsed time
3. Fewer penalties
4. Higher accuracy
5. Fewer attempts used
6. Earlier valid result submission
7. Playoff or administrator decision

#### Required result fields

Raw score, adjusted score, elapsed time, completion status, penalty count, attempt number, submission timestamp.

#### Invalid configuration

Do not use when the game does not produce a reliable numeric score.

---

### 4.2 Mode 2 — Lowest Time Wins (`lowest_time`)

#### Definition

The participant who completes the required objective in the shortest valid time ranks first. Lower elapsed time = better rank.

#### Suitable games

Racing, obstacle courses, maze completion, puzzle completion, speed-based educational challenges, time trials, rescue missions.

#### Ranking order

```
Rank by elapsedMilliseconds ascending
```

#### Example

| Player | Time | Rank |
|--------|------|------|
| Player A | 48.250 sec | 1 |
| Player B | 50.100 sec | 2 |
| Player C | 54.800 sec | 3 |

#### Completion requirement

Only **completed** results should normally be ranked. A player who travels part of a track but does not finish must not rank ahead of a player who completed the track.

#### Recommended tie-break order

1. Lower elapsed time
2. Higher adjusted score
3. Fewer penalties
4. Higher accuracy or completion quality
5. Fewer attempts used
6. Earlier valid completion
7. Playoff or administrator decision

#### Precision rule

Time must be stored in **integer milliseconds** (authoritative value).

```json
"elapsedMilliseconds": 48250
```

The UI may display `48.250 seconds`, but ranking comparisons use stored millisecond values, not rounded display values.

#### Invalid configuration

Do not use when:

- Completion cannot be reliably detected
- The timer can be controlled entirely by the client
- The game allows non-completing players to accumulate ranking value

---

### 4.3 Mode 3 — Highest Score, Then Lowest Time (`highest_score_then_lowest_time`)

#### Definition

Score is the **primary** ranking value. Time is considered only when two or more participants have the same score.

- Primary: higher score
- Secondary: lower time

**Recommended default for educational quiz and knowledge games.**

#### Suitable games

Quiz competitions, educational games, target challenges, accuracy games, puzzle games, collection missions.

#### Example

| Player | Score | Time | Rank |
|--------|-------|------|------|
| Player A | 1,000 | 60 sec | 1 |
| Player B | 1,000 | 65 sec | 2 |
| Player C | 950 | 45 sec | 3 |

Player C does **not** rank above Player B because score is primary.

#### Recommended full ranking order

1. Higher adjusted score
2. Lower elapsed time
3. Fewer penalties
4. Higher accuracy
5. Fewer attempts used
6. Earlier valid submission
7. Playoff or administrator decision

---

### 4.4 Mode 4 — Lowest Time, Then Highest Score (`lowest_time_then_highest_score`)

#### Definition

Time is the **primary** ranking value. Score is considered only when completion times are equal.

- Primary: lower time
- Secondary: higher score

#### Suitable games

Racing with collectible points, obstacle courses with optional bonuses, rescue games, timed navigation, speed missions with penalties or bonus objectives.

#### Example

| Player | Time | Score | Rank |
|--------|------|-------|------|
| Player A | 45 sec | 700 | 1 |
| Player B | 45 sec | 650 | 2 |
| Player C | 47 sec | 900 | 3 |

Player C does **not** rank above Player B because time is primary.

#### Recommended full ranking order

1. Lower elapsed time
2. Higher adjusted score
3. Fewer penalties
4. Higher completion percentage
5. Fewer attempts used
6. Earlier valid submission
7. Playoff or administrator decision

---

### 4.5 Mode 5 — Normalized Tournament Points (`normalized_tournament_points`)

#### Purpose

Different games produce very different raw ranges (45–120 seconds vs 0–100,000 points). Raw values cannot be added directly across an Olympics tournament. Normalized tournament points convert each result to a common scale.

**Recommended scale:** 0 to 1,000 tournament points.

#### Normalization configuration

Every tournament game must define:

- Minimum valid raw value
- Maximum expected raw value
- Direction of better performance
- Normalized minimum and maximum
- Clamping rule
- Rounding rule

#### Higher-is-better formula (score games)

```
normalizedPoints =
  ((playerValue - minimumValue) / (maximumValue - minimumValue))
  × maximumTournamentPoints
```

**Example:**

- Minimum score: 0
- Maximum score: 10,000
- Player score: 7,500
- Maximum tournament points: 1,000

```
normalizedPoints = (7,500 / 10,000) × 1,000 = 750
```

#### Lower-is-better formula (time games)

```
normalizedPoints =
  ((maximumTime - playerTime) / (maximumTime - minimumTime))
  × maximumTournamentPoints
```

**Example:**

- Best expected time: 40 seconds (40,000 ms)
- Maximum valid time: 100 seconds (100,000 ms)
- Player time: 55 seconds (55,000 ms)

```
normalizedPoints = ((100 - 55) / (100 - 40)) × 1,000 = 750
```

#### Clamping

- Normalized points cannot be below 0 or above the configured maximum.
- An exceptional raw score above the expected maximum must **not** automatically exceed maximum tournament points unless an explicit uncapped mode exists.

#### Rounding

- Store rounded to **two decimal places** (example: `742.35`).
- Display whole points unless decimal precision is needed.

#### Weighted games

```
weightedPoints = normalizedPoints × gameWeight
```

Weights must be published before registration closes. See [Points Table Examples](./revo_olympics_points_table_examples.md).

#### Recommended use

Appropriate when overall Olympics ranking should consider performance across all games, not only medal counts.

#### Safeguard

Normalization limits must be based on game design specifications, historical test data, valid performance ranges, QA validation, and approved administrator configuration. Arbitrary limits without validation are not permitted.

---

### 4.6 Mode 6 — Completion-Based Ranking (`completion_based`)

#### Definition

Participants are ranked primarily by **completion status** or **completion percentage**. Suitable when finishing required tasks matters more than a large numeric score.

#### Suitable games

Educational lessons, safety simulations, disaster-response games, training exercises, multi-stage missions, task-completion challenges, skill assessments.

#### Completion statuses

| Status | Typical rank order |
|--------|-------------------|
| `completed` | Highest |
| `completedWithPenalty` | Below completed |
| `partiallyCompleted` | Below completed with penalty |
| `failed` | Lower |
| `aborted` | Lower |
| `notStarted` | Lower |
| `disqualified` | Lowest |

Within the same category, tie-break using: higher completion percentage → higher score → lower time → fewer penalties → earlier completion.

#### Completion percentage

```
completionPercentage = (completedObjectives / totalObjectives) × 100
```

**Example:** 8 of 10 objectives → 80%.

#### Mandatory objectives

A participant must **not** receive `completed` status when a mandatory objective was skipped, even if completion percentage appears high.

**Example:** 9 of 10 objectives completed but mandatory safety step missed → status `failed` or `partiallyCompleted`, not `completed`.

#### Completion points (optional)

Administrators may define points by completion band. See [Points Table Examples](./revo_olympics_points_table_examples.md).

---

### 4.7 Mode 7 — Admin-Defined Points Table (`admin_defined_points_table`)

#### Definition

The administrator defines tournament points for each placement or performance band.

#### Placement-based example

| Rank | Points |
|------|--------|
| 1 | 25 |
| 2 | 20 |
| 3 | 16 |
| … | … |
| Participation | 1 |

#### Medal-based example (Olympics)

| Medal | Points |
|-------|--------|
| Gold | 5 |
| Silver | 3 |
| Bronze | 1 |
| No medal | 0 |

#### Performance-band example

| Result | Points |
|--------|--------|
| Score ≥ 9,000 | 100 |
| Score 7,500–8,999 | 80 |
| Did not finish | 0 |

#### Validation requirements

A points table must:

- Contain no duplicate placement entries
- Contain no negative points unless penalty mode is explicitly enabled
- Define behaviour for unlisted ranks and tied ranks
- Define participation and disqualification points
- Be locked before the tournament begins
- Be included in the tournament audit snapshot

#### Rule changes

After the first valid attempt, the points table should become **immutable**. Emergency changes require Super Administrator permission, recalculation of existing results, participant notification, and preservation of old and new configurations in audit logs.

---

## 5. Ranking Configuration Model

Every tournament game should define a ranking configuration.

### Standard configuration example

```json
{
  "rankingMode": "highest_score_then_lowest_time",
  "scoreDirection": "higher",
  "timeDirection": "lower",
  "requiresCompletion": true,
  "minimumValidScore": 0,
  "maximumValidScore": 100000,
  "minimumValidTimeMs": 10000,
  "maximumValidTimeMs": 300000,
  "tieBreakers": [
    "elapsedTime",
    "penaltyCount",
    "attemptsUsed",
    "submittedAt"
  ],
  "attemptRule": "best_valid_attempt",
  "maximumAttempts": 3,
  "retryPolicyId": "standard_technical_retry",
  "normalization": null
}
```

### Normalized configuration example

```json
{
  "rankingMode": "normalized_tournament_points",
  "normalization": {
    "direction": "higher",
    "rawMinimum": 0,
    "rawMaximum": 10000,
    "pointsMinimum": 0,
    "pointsMaximum": 1000,
    "gameWeight": 1.5,
    "roundingDecimals": 2,
    "clampValues": true
  }
}
```

---

## 6. Attempt Selection Rules

When multiple attempts are allowed, the tournament must define which result counts.

| Rule | Description |
|------|-------------|
| `best_valid_attempt` | Select the attempt ranking highest per the game's mode (**recommended default**) |
| `latest_valid_attempt` | Most recent valid attempt only; player warned a later result can replace a better earlier one |
| `first_valid_attempt` | First accepted attempt only; later attempts stored as practice |
| `average_of_valid_attempts` | Average of valid attempts; must define whether score, normalized points, or time is averaged |
| `sum_of_valid_attempts` | Sum of valid attempt values |
| `best_n_attempts` | Best N valid attempts combined per configured rule |
| `admin_selected_attempt` | Special reviewed events only; requires reason and audit |

### Best valid attempt (default)

Select the attempt that ranks highest according to the game's ranking mode. Recommended for most Revo Olympics tournaments.

### Sum example

| Attempt | Score |
|---------|-------|
| 1 | 800 |
| 2 | 900 |
| 3 | 750 |
| **Total** | **2,450** |

### Best N example

Maximum attempts: 5. Best attempts counted: 3. The best three valid attempts are combined per configured aggregation rule.

---

## 7. Tie Handling

### 7.1 General principle

Ties must be resolved using a **published tie-break sequence** stored with tournament configuration before competition begins.

### 7.2 Default tie-break — score games

1. Higher adjusted score
2. Lower elapsed time
3. Fewer penalties
4. Higher accuracy
5. Higher completion percentage
6. Fewer attempts used
7. Earlier valid completion timestamp
8. Playoff
9. Shared placement (only when explicitly permitted)

### 7.3 Default tie-break — time games

1. Lower elapsed time
2. Higher adjusted score
3. Fewer penalties
4. Higher completion quality
5. Fewer attempts used
6. Earlier valid completion timestamp
7. Playoff
8. Shared placement (only when explicitly permitted)

### 7.4 Exact time ties (millisecond precision)

| Player | Stored time | Displayed | Rank |
|--------|-------------|-----------|------|
| Player A | 48,251 ms | 48.25 sec | 1 |
| Player B | 48,259 ms | 48.26 sec | 2 |

Display rounding must **not** alter ranking order.

### 7.5 Shared placement

Shared placement is **disabled by default**.

When enabled:

- The same placement may be assigned to multiple participants
- Next rank follows configured style:

| Style | Example ranks for tied first place |
|-------|-----------------------------------|
| Dense ranking | 1, 1, 2, 3 |
| Competition ranking | 1, 1, 3, 4 |

### 7.6 Medal ties

Recommended: **resolve the tie** rather than award duplicate medals.

Resolution options:

- Existing tie-break fields
- Additional playoff attempt
- Sudden-death mini-game
- Jury decision based on published criteria
- Shared medal (only when explicitly approved)

A shared medal must **not** occur unless explicitly enabled.

### 7.7 Playoff rules

A playoff must define:

- Eligible tied participants
- Playoff game
- Number of attempts
- Start and end time
- Ranking mode
- Failure handling
- Result approval process

### 7.8 Team ties

Team ties may use:

- Better aggregate team result
- Better highest individual member result
- Better second-highest member result
- Fewer total penalties
- Fewer attempts
- Earlier team completion
- Team playoff

---

## 8. Invalid Attempt Handling

### 8.1 Definition

An attempt is **invalid** when it fails technical, eligibility, or competition validation.

### 8.2 Invalid attempt reason codes

| Code | Description |
|------|-------------|
| `INVALID_SESSION` | Session not found or not authorized |
| `SESSION_EXPIRED` | Session past allowed duration or window |
| `WRONG_PLAYER` | Result submitted for different player |
| `WRONG_TEAM` | Result submitted for wrong team |
| `WRONG_GAME` | Game ID mismatch |
| `WRONG_GAME_VERSION` | Game version mismatch |
| `TOURNAMENT_NOT_ACTIVE` | Tournament not in playable state |
| `PLAYER_NOT_ELIGIBLE` | Player not eligible for tournament |
| `TEAM_NOT_ELIGIBLE` | Team not eligible |
| `ROSTER_MISMATCH` | Player not on locked roster |
| `ATTEMPT_LIMIT_EXCEEDED` | Maximum attempts reached |
| `DUPLICATE_SUBMISSION` | Result already finalized for attempt |
| `INVALID_SCORE` | Score outside valid bounds |
| `INVALID_TIME` | Time outside valid bounds or negative |
| `IMPOSSIBLE_RESULT` | Result below physical possibility threshold |
| `MISSING_COMPLETION` | Required completion data absent |
| `MISSING_CHECKPOINT` | Required checkpoint not recorded |
| `UNSUPPORTED_PROTOCOL` | Protocol version not supported |
| `MESSAGE_SEQUENCE_ERROR` | Invalid message sequence from Unity |
| `TAMPERED_RESULT` | Integrity check failed |
| `APP_CHECK_FAILED` | Firebase App Check validation failed |
| `DEVICE_NOT_ALLOWED` | Device not permitted |
| `BUILD_NOT_APPROVED` | Game build not approved for tournament |
| `ADMIN_INVALIDATED` | Manually invalidated by administrator |

### 8.3 Invalid attempt effects

An invalid attempt:

- Must **not** update the official leaderboard
- Must **not** award tournament points or medals
- Must **not** count as a personal best
- May count against attempt limit depending on reason
- Must retain submitted data for audit
- Must display clear user-facing status

### 8.4 User-caused invalid attempts

Examples: unauthorized game version, exceeding attempt limit, leaving before completion, attempting outside tournament window, deliberate restart to avoid poor result.

These normally **count against** the attempt limit.

### 8.5 System-caused invalid attempts

Examples: server failure, corrupt build, platform outage, result function error, confirmed network interruption, game crash unrelated to player.

These may qualify for a **replacement attempt**.

### 8.6 Suspicious attempts

A suspicious attempt is **not** automatically invalid. Status: `suspicious` → enters review.

**Possible triggers:**

- Score outside expected distribution
- Completion time below physical possibility
- Duplicate session pattern
- Unusual message sequence
- Modified build fingerprint
- Excessive retry pattern
- Device integrity failure
- Multiple accounts from same controlled environment

**After review:** `accepted`, `rejected`, or `disqualified`.

A suspicious result must **not** receive a medal before review.

---

## 9. Incomplete Game Handling

### 9.1 Definition

An attempt is **incomplete** when it starts but does not satisfy the game's completion requirements.

### 9.2 Incomplete statuses

`didNotFinish`, `abortedByPlayer`, `technicalFailure`, `timedOut`, `disconnected`, `applicationClosed`, `gameCrashed`, `missingObjectives`

### 9.3 Default ranking rule

Incomplete attempts must **not** rank above completed valid attempts.

An incomplete time-trial result must **not** rank as completed.

### 9.4 Possible tournament treatments

| Treatment | When used |
|-----------|-----------|
| Zero tournament points | Default for score/time tournaments |
| Excluded from ranking | Standard |
| Count as used attempt | Player-caused incomplete |
| Technical retry eligibility | Confirmed technical failure |
| Partial completion points | Completion-based tournaments only |
| Marked DNF | Started but not finished |
| Disqualification after repeated abandonment | Configured per tournament |

### 9.5 Did Not Start (DNS)

Registered but never began an attempt.

**Default outcome:** No score, no points, no medal. No retry after game window closes except administrator-approved emergency cases.

### 9.6 Did Not Finish (DNF)

Started but did not complete.

**Default outcome:** Attempt counts as used. No official placement. Zero tournament points. Technical retry only when evidence supports it.

### 9.7 Partial completion

Partial completion may be ranked only when the tournament explicitly uses `completion_based` ranking. For normal score or time tournaments, partial completion remains below every completed result.

---

## 10. Retry Rules

### 10.1 Definition

A **retry** is permission to perform another attempt after a previous attempt.

### 10.2 Retry categories

| Category | Purpose |
|----------|---------|
| `standardAttempt` | Normal tournament attempt (not exceptional) |
| `technicalRetry` | Replacement after confirmed technical failure |
| `administrativeRetry` | Special correction by authorized admin |
| `playoffAttempt` | Tie-break or playoff round |
| `practiceRetry` | Non-ranking practice when enabled |

### 10.3 Standard attempts

Fixed number of attempts per tournament configuration. These are not exceptional retries.

**Example:** Maximum attempts: 3. Counting rule: best valid attempt.

### 10.4 Technical retry eligibility

Granted for confirmed:

- Game crash
- WebGL load failure
- Firebase outage
- Network failure during mandatory online submission
- Device failure verified by event staff
- Invalid build deployment
- Incorrect tournament configuration
- Spectator or event-system interference

A player must **not** receive a retry simply because of a poor score.

### 10.5 Technical retry evidence

| Evidence type |
|---------------|
| Crash log |
| Session heartbeat history |
| WebView error log |
| Firebase function log |
| Device error report |
| Event official confirmation |
| Video evidence |
| Build incident record |

A technical retry must **not** be granted without valid reason and evidence.

### 10.6 Non-eligible retry reasons

- Poor player performance
- Voluntary quit
- Accidental button press without evidence
- Battery depletion from insufficient preparation
- Player arriving late
- Misunderstanding clearly published instructions
- Deliberate network disconnection
- Attempt to replace a valid low score

### 10.7 Retry approval roles

May approve: Platform Administrator, Tournament Administrator, authorized event official, Super Administrator.

Teachers may **request** retries but should not approve disputed retries for their own institution when conflict-of-interest controls are enabled.

### 10.8 Retry status lifecycle

`requested` → `underReview` → `approved` | `rejected` → `used` | `expired` | `cancelled`

### 10.9 Replacement attempt rules

The tournament must define whether an approved retry:

- Adds an additional attempt
- Replaces the failed attempt
- Replaces the last attempt
- Counts only if completed

**Recommended technical-failure rule:**

- Failed technical attempt is **excluded** from attempt count
- One replacement attempt is issued

### 10.10 Retry expiry

A retry permission must contain: valid-from timestamp, expiry timestamp, game ID, tournament ID, player or team ID, maximum retry attempts, approval reference.

### 10.11 Retry audit

Every retry decision must record: requester, reason, evidence, approver, decision, decision time, original attempt, replacement attempt, notes.

---

## 11. Disqualification Rules

### 11.1 Definition

Disqualification removes a player, team, attempt, or complete tournament entry for a serious rule violation.

### 11.2 Disqualification levels

| Level | Effect |
|-------|--------|
| `attemptDisqualification` | Single attempt removed |
| `gameDisqualification` | Removed from one tournament game |
| `tournamentDisqualification` | Removed from entire tournament; all results invalidated |
| `teamDisqualification` | Team removed per team rules |
| `temporaryAccountSuspension` | Account restricted for a period |
| `permanentAccountBan` | Account permanently blocked |
| `institutionReview` | Institution flagged for review |

### 11.3 Disqualification reason codes

`CHEATING`, `SCORE_MANIPULATION`, `TIME_MANIPULATION`, `MODIFIED_GAME_BUILD`, `UNAUTHORIZED_SOFTWARE`, `IDENTITY_SUBSTITUTION`, `ACCOUNT_SHARING`, `MULTIPLE_ACCOUNT_ABUSE`, `COLLUSION`, `EXPLOIT_ABUSE`, `RESULT_TAMPERING`, `DEVICE_TAMPERING`, `ROSTER_VIOLATION`, `INELIGIBLE_PLAYER`, `HARASSMENT`, `UNSPORTING_CONDUCT`, `REPEATED_FALSE_RETRY_REQUEST`, `ADMINISTRATIVE_FRAUD`, `RULE_VIOLATION`

### 11.4 Tournament disqualification consequences

- All tournament results invalidated
- All medals revoked
- All tournament points removed
- Overall ranking recalculated
- Affected participants notified

A disqualified result must **not** remain in Olympics totals.

### 11.5 Decision process

```
Flag raised → Evidence collected → Result frozen → Participant informed
    → Review conducted → Decision recorded → Appeal window → Final decision
    → Leaderboard recalculated
```

### 11.6 Due process

Except in clear automated invalidation cases, disqualification should include: reason code, human-readable explanation, evidence reference, reviewer identity, decision timestamp, appeal deadline, final decision status.

### 11.7 Medal reassignment

When a medal winner is disqualified:

1. Remove disqualified result
2. Recalculate game leaderboard
3. Promote eligible lower-ranked participants
4. Update medal records
5. Recalculate Olympics standings and Champion/Runner-up
6. Notify affected users
7. Preserve old result in audit history

---

## 12. Penalties

### 12.1 Penalty types

Score deduction, time addition, tournament-point deduction, placement penalty, warning, attempt invalidation, disqualification.

### 12.2 Score penalty

```
adjustedScore = rawScore - scorePenalty
```

**Example:** Raw 1,000 − penalty 100 = adjusted 900.

### 12.3 Time penalty

```
adjustedTimeMs = rawElapsedTimeMs + timePenaltyMs
```

**Example:** Raw 50 sec + penalty 5 sec = adjusted 55 sec.

### 12.4 Penalty limits

Configuration must define: minimum and maximum values, whether negative adjusted values are allowed, who can apply penalties, automatic vs manual application, appeal eligibility.

### 12.5 Manual penalties

Require: authorized role, reason, evidence, original value, adjusted value, audit entry.

---

## 13. Team Ranking Rules

### 13.1 Supported team aggregation modes

| Mode | Description |
|------|-------------|
| `best_single_member` | Best individual result becomes team result |
| `sum_all_members` | Sum of every eligible member score |
| `best_n_members` | Best N member results combined |
| `average_members` | Average of counted member values |
| `lowest_combined_time` | Lowest valid combined time |
| `relay_total_time` | Relay total including handover penalties |
| `weighted_member_results` | Configured member weights |
| `placement_points_sum` | Sum of member placement points |
| `custom_team_formula` | Admin-defined formula |

### 13.2 Best N members example

Team size: 5. Best results counted: 3. Top three valid member results form the team score.

### 13.3 Missing team member

The rule must define whether a missing result causes: team DNF, zero contribution, maximum penalty, substitute activation, or team disqualification.

A missing team-member result must **not** be ignored unless the team rule explicitly permits it.

### 13.4 Team tie-break order

1. Better aggregate team result
2. Better highest individual result
3. Better second-highest individual result
4. Fewer team penalties
5. Fewer attempts used
6. Earlier team completion
7. Team playoff

A team with an invalid roster must **not** receive an official result.

---

## 14. Final-Result Approval

See also [Result Status Rules](./revo_olympics_result_status_rules.md).

### 14.1 Result lifecycle

`created` → `inProgress` → `submitted` → `validating` → `accepted` | `rejected` | `suspicious` → `underReview` → `provisional` → `frozen` → `approved` → `finalized`

Also: `disqualified`, `revoked`, `superseded`.

### 14.2 Automated validation checks

Valid session, correct participant and team, correct tournament and game, correct game and protocol version, valid timestamps, valid score and time, valid completion, attempt limit, tournament window, eligibility, team roster, duplicate submission, integrity signals.

### 14.3 Accepted vs provisional vs final

| State | Meaning |
|-------|---------|
| **Accepted** | Passed automated validation; may appear on provisional leaderboard |
| **Provisional** | Can affect live leaderboard; can still be reviewed or rejected |
| **Final** | Approved official result; determines medals and official rankings |

An unvalidated result must **not** be finalized. Final medals are generated **only after** result approval.

### 14.4 Leaderboard freeze

At end of game or tournament:

1. Stop accepting normal attempts
2. Mark leaderboard as frozen
3. Complete pending validation
4. Review suspicious results
5. Process retry cases
6. Resolve disputes and ties
7. Approve final rankings

### 14.5 Approval roles

Possible roles: Tournament Administrator, Result Reviewer, Platform Administrator, Super Administrator, institution official (institution-only events).

Configuration defines: single vs dual approval, institution event platform approval requirement, medal finalization roles.

### 14.6 Dual approval

Recommended for important tournaments:

- Reviewer 1 approves ranking
- Reviewer 2 finalizes ranking

The same person must **not** perform both actions where dual approval is required.

### 14.7 Finalization effects

May trigger: official leaderboard publication, medal generation, Olympics-points calculation, institution medal-table update, Champion calculation, notifications, certificates, reports, audit snapshot.

### 14.8 Reopening finalized results

Permitted only for: confirmed cheating, major scoring defect, incorrect tournament configuration, legal or policy requirement, verified administrative error.

Requires: Super Administrator permission, reason, evidence, audit record, participant notification, recalculation of affected standings.

A result must **not** be reopened without authorization and audit reason. A final leaderboard must **not** change without reopening the result-review workflow.

---

## 15. Leaderboard Rules

| Type | Updates during play | Determines medals |
|------|--------------------|--------------------|
| `live` | Yes | No — must show provisional message |
| `provisional` | Limited | No |
| `frozen` | No (except authorized corrections) | No |
| `final` | No | Yes |
| `archived` | No | Historical reference only |

**Live leaderboard message:** "Live results are provisional and may change after validation."

Only the **final** leaderboard determines medals, tournament points, Champion, Runner-up, certificates, and official reports.

---

## 16. Recommended Default Rules

Unless a tournament explicitly overrides:

### 16.1 Score game default

| Setting | Value |
|---------|-------|
| Ranking mode | `highest_score_then_lowest_time` |
| Attempt limit | 3 |
| Counting rule | `best_valid_attempt` |
| Tie-breakers | Lower time → fewer penalties → fewer attempts → earlier completion |

### 16.2 Time game default

| Setting | Value |
|---------|-------|
| Ranking mode | `lowest_time_then_highest_score` |
| Attempt limit | 3 |
| Counting rule | `best_valid_attempt` |
| Tie-breakers | Higher score → fewer penalties → fewer attempts → earlier completion |

### 16.3 Completion game default

| Setting | Value |
|---------|-------|
| Ranking mode | `completion_based` |
| Requires completion | Yes |
| Attempt limit | 2 |
| Counting rule | Best valid completion |
| Tie-breakers | Higher completion % → higher score → lower time → fewer penalties |

### 16.4 Technical failure default

Confirmed technical failure does **not** consume the attempt. One replacement attempt may be issued with approval and evidence.

### 16.5 Incomplete player-caused default

Attempt counts as used. Result receives DNF. No tournament points. No automatic retry.

A player-caused exit must **not** automatically be classified as technical failure.

### 16.6 Disqualification default

Disqualified result receives no rank, no points, and no medal. Affected leaderboards are recalculated.

---

## 17. Example Competition Scenarios

### 17.1 Highest score

| Player | Score | Time | Attempts | Rank |
|--------|-------|------|----------|------|
| A | 5,000 | 70 sec | 2 | 1 |
| B | 4,800 | 55 sec | 1 | 2 |
| C | 4,500 | 60 sec | 1 | 3 |

### 17.2 Score tie resolved by time

| Player | Score | Time | Rank |
|--------|-------|------|------|
| A | 5,000 | 60 sec | 1 |
| B | 5,000 | 65 sec | 2 |
| C | 4,900 | 50 sec | 3 |

### 17.3 Lowest time

| Player | Time | Score | Rank |
|--------|------|-------|------|
| A | 45 sec | 600 | 1 |
| B | 48 sec | 900 | 2 |
| C | 50 sec | 950 | 3 |

### 17.4 Technical retry

Player A: Attempt 1 crashes after 30 seconds. Heartbeat and crash logs confirm failure. Status: `technicalFailure`. Attempt **not counted**. Replacement attempt approved by Tournament Administrator. Successful completion enters provisional leaderboard.

### 17.5 Voluntary exit

Player B voluntarily exits after low score. Status: `abortedByPlayer`. Attempt **counts as used**. No automatic retry.

### 17.6 Disqualification

Player C submits impossible completion time. Review finds modified build. Result disqualified. Player removed from game ranking. Medal table recalculated. Account under review. Audit record created.

---

## 18. Required Data Fields

### 18.1 Attempt record

```json
{
  "attemptId": "attempt_001",
  "sessionId": "session_001",
  "tournamentId": "tournament_001",
  "tournamentGameId": "tg_001",
  "gameId": "game_001",
  "gameVersion": "1.2.0",
  "playerId": "player_001",
  "teamId": null,
  "attemptNumber": 1,
  "attemptType": "standardAttempt",
  "status": "submitted",
  "startedAt": "serverTimestamp",
  "submittedAt": "serverTimestamp"
}
```

### 18.2 Result record

```json
{
  "resultId": "result_001",
  "attemptId": "attempt_001",
  "rawScore": 5000,
  "scorePenalty": 100,
  "adjustedScore": 4900,
  "rawElapsedTimeMs": 60000,
  "timePenaltyMs": 5000,
  "adjustedElapsedTimeMs": 65000,
  "completionStatus": "completed",
  "completionPercentage": 100,
  "penaltyCount": 1,
  "rankingMode": "highest_score_then_lowest_time",
  "normalizedPoints": null,
  "validationStatus": "accepted",
  "isProvisional": true,
  "isFinal": false
}
```

### 18.3 Retry record

```json
{
  "retryId": "retry_001",
  "originalAttemptId": "attempt_001",
  "reasonCode": "GAME_CRASH",
  "requestStatus": "approved",
  "requestedBy": "player_001",
  "approvedBy": "admin_001",
  "validUntil": "timestamp",
  "replacementAttemptId": "attempt_002"
}
```

### 18.4 Disqualification record

```json
{
  "disqualificationId": "dq_001",
  "scope": "gameDisqualification",
  "participantType": "player",
  "participantId": "player_001",
  "reasonCode": "MODIFIED_GAME_BUILD",
  "evidenceReferences": ["evidence_001"],
  "decisionStatus": "final",
  "decidedBy": "admin_001",
  "decidedAt": "serverTimestamp",
  "appealDeadline": "timestamp"
}
```

---

## 19. Administration Requirements

The admin panel must eventually allow authorized users to configure (this sprint documents requirements only; no implementation):

- Ranking mode, score direction, time direction
- Attempt limit and counting rule
- Tie-break sequence
- Completion requirement and incomplete-game treatment
- Minimum and maximum valid score and time
- Normalization limits and game weight
- Tournament-points table
- Retry policy and technical retry approvers
- Penalty rules
- Team aggregation rule
- Result approval workflow and dual-approval requirement
- Appeal window

All configuration changes after competition begins require emergency correction procedures with audit logging.

---

## 20. Test Scenarios

### 20.1 Positive test scenarios

| # | Scenario | Expected |
|---|----------|----------|
| P1 | Highest score ranking | Higher score ranks above lower score |
| P2 | Lowest time ranking | Lower time ranks above higher time |
| P3 | Score tie | Equal scores resolved by lower time |
| P4 | Time tie | Equal times resolved by higher score |
| P5 | Millisecond precision | Stored ms values used, not display rounding |
| P6 | Normalization | Different game ranges convert to same 0–1,000 scale |
| P7 | Clamping | Normalized points stay within configured limits |
| P8 | Game weight | Weight applied after normalization |
| P9 | Best valid attempt | Correct attempt selected |
| P10 | Latest valid attempt | Most recent valid attempt selected |
| P11 | Incomplete vs complete | Incomplete does not rank above completed |
| P12 | Technical retry | Confirmed failure receives approved replacement |
| P13 | Voluntary quit | Consumes attempt; no automatic retry |
| P14 | Invalid result | Does not update leaderboard |
| P15 | Suspicious result | Enters review; not auto-finalized |
| P16 | Disqualification | No points or medal; leaderboard recalculated |
| P17 | Medal reassignment | Medals move up after disqualification |
| P18 | Team Best N | Team score uses configured member aggregation |
| P19 | Provisional display | Live/provisional clearly marked |
| P20 | Final medals | Generated only after approval |
| P21 | Leaderboard freeze | Freeze before finalization |
| P22 | Dual approval | Separate reviewers where configured |
| P23 | Audit on correction | Corrections create audit records |
| P24 | Revoked result | Points recalculated after revocation |
| P25 | Authorization | Finalized results not modified by unauthorized users |

### 20.2 Negative test scenarios

| # | Scenario | Must NOT happen |
|---|----------|-----------------|
| N1 | Client rank assignment | Client directly assigns its rank |
| N2 | Unity medals | Unity directly awards medals |
| N3 | Flutter final write | Flutter directly writes final official result |
| N4 | Expired session | Result from expired session accepted |
| N5 | Wrong version | Result from wrong game version accepted |
| N6 | Attempt limit | Participant exceeds configured limit |
| N7 | Incomplete time trial | Incomplete result ranks as completed |
| N8 | Score bounds | Score outside limits enters leaderboard |
| N9 | Negative time | Negative elapsed time accepted |
| N10 | Duplicate submission | Duplicate creates two leaderboard entries |
| N11 | Retry without reason | Technical retry without valid reason |
| N12 | Poor score retry | Retry granted for poor performance |
| N13 | Teacher overreach | Teacher approves outside permission |
| N14 | Shared medal default | Shared medal without explicit enable |
| N15 | Silent points change | Points table changed silently mid-competition |
| N16 | Unvalidated final | Unvalidated result finalized |
| N17 | Suspicious medal | Medal before suspicious review complete |
| N18 | DQ in totals | Disqualified result in Olympics totals |
| N19 | Invalid roster team | Team with invalid roster gets official result |
| N20 | Missing member ignored | Missing member ignored without team rule |
| N21 | Exit as technical | Player exit classified as technical failure |
| N22 | Unauthorized reopen | Result reopened without authorization |
| N23 | Display rounding rank | Display rounding alters ranking order |
| N24 | Unpublished weight | Weighted game uses unpublished weight |
| N25 | Final change without workflow | Final leaderboard changes without review reopen |

---

## 21. Acceptance Criteria

Sprint F0.2 is complete when:

- [ ] `docs/product/revo_olympics_competition_ranking_rules.md` exists
- [ ] All seven ranking modes documented with definition, suitable games, data, direction, tie-breaks, examples, and invalid configurations
- [ ] Normalized tournament-points formulas documented (higher-is-better, lower-is-better, weighted, clamping, rounding)
- [ ] Attempt-selection rules documented
- [ ] Tie-handling rules documented (score, time, ms precision, team, shared placement, medal, playoff)
- [ ] Invalid-attempt handling documented with reason codes
- [ ] Incomplete-game handling documented (DNS, DNF, partial completion)
- [ ] Retry rules documented with evidence and audit requirements
- [ ] Disqualification rules documented with medal reassignment
- [ ] Penalty rules documented
- [ ] Team aggregation rules documented
- [ ] Result lifecycle, leaderboard freeze, and final-result approval documented
- [ ] Reopening rules documented
- [ ] Positive and negative test scenarios included
- [ ] Supporting documents created (`result_status_rules`, `points_table_examples`)
- [ ] Product and technical stakeholders approve
- [ ] Approved documents committed to source control

---

## 22. Sprint F0.2 Completion Gate

No tournament-engine implementation should begin until stakeholders can answer these questions consistently:

| Question | Answer location |
|----------|-----------------|
| Which ranking mode applies to each game? | [Section 3–4](#3-supported-ranking-modes) |
| Which value is the primary ranking value? | Per-mode definitions in [Section 4](#4-ranking-mode-details) |
| Which values resolve a tie? | [Section 7](#7-tie-handling) |
| How is time stored and compared? | Milliseconds — [Section 4.2](#42-mode-2--lowest-time-wins-lowest_time) |
| How are different game scores normalized? | [Section 4.5](#45-mode-5--normalized-tournament-points-normalized_tournament_points) |
| Which attempt counts when multiple are allowed? | [Section 6](#6-attempt-selection-rules) |
| What is the difference between invalid, incomplete, and suspicious? | [Sections 8–9](#8-invalid-attempt-handling) |
| Does a failed attempt consume an attempt? | Depends on cause — [Sections 9, 10, 16](#9-incomplete-game-handling) |
| When is a technical retry permitted? | [Section 10.4](#104-technical-retry-eligibility) |
| Who approves a retry? | [Section 10.7](#107-retry-approval-roles) |
| What evidence is required? | [Section 10.5](#105-technical-retry-evidence) |
| What causes disqualification? | [Section 11](#11-disqualification-rules) |
| What happens to medals after disqualification? | [Section 11.7](#117-medal-reassignment) |
| How are team scores aggregated? | [Section 13](#13-team-ranking-rules) |
| When does a result become provisional? | [Section 14.3](#143-accepted-vs-provisional-vs-final) |
| When is a leaderboard frozen? | [Section 14.4](#144-leaderboard-freeze) |
| Who approves final results? | [Section 14.5–14.6](#145-approval-roles) |
| When are medals generated? | After finalization — [Section 14.3, 14.7](#143-accepted-vs-provisional-vs-final) |
| Can a finalized result be reopened? | [Section 14.8](#148-reopening-finalized-results) |
| How are corrections audited? | [Sections 1.4, 10.11, 14.8](#14-immutable-attempt-records) |

---

*End of document.*
