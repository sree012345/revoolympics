# Revo Olympics — Result Status Rules

This document defines official status values and transitions for attempts, results, retries, disqualifications, and leaderboards in Revo Olympics.

**Document status:** Foundation Sprint F0.2  
**Last updated:** 2026-07-19

For ranking logic, tie-breaks, and validation rules, see [Competition and Ranking Rules](./revo_olympics_competition_ranking_rules.md).

---

## Related Documents

- [Competition and Ranking Rules](./revo_olympics_competition_ranking_rules.md)
- [Points Table Examples](./revo_olympics_points_table_examples.md)
- [Product Rules](./revo_olympics_product_rules.md)

---

## 1. Attempt Status

| Status | Description | Affects leaderboard |
|--------|-------------|---------------------|
| `created` | Session authorized; play not yet started | No |
| `inProgress` | Gameplay active | No |
| `submitted` | Result received from client | Pending validation |
| `validating` | Backend validation in progress | No |
| `accepted` | Passed automated validation | Provisional only |
| `rejected` | Failed validation | No |
| `suspicious` | Flagged for manual review | No (until resolved) |
| `underReview` | Manual review in progress | No |
| `disqualified` | Removed for rule violation | No |
| `superseded` | Replaced by correction or retry | No |

---

## 2. Result Validation Status

| Status | Description | Can affect provisional leaderboard | Can affect final ranking |
|--------|-------------|-----------------------------------|--------------------------|
| `pending` | Awaiting submission or validation | No | No |
| `received` | Received, not yet validated | No | No |
| `validating` | Validation running | No | No |
| `accepted` | Automated validation passed | Yes | No |
| `rejected` | Validation failed | No | No |
| `suspicious` | Requires review | No | No |
| `underReview` | Under manual review | No | No |
| `provisional` | On live/provisional leaderboard | Yes | No |
| `frozen` | Locked during review window | Yes (display only) | No |
| `approved` | Reviewer approved | Yes | Pending finalization |
| `finalized` | Official final result | No (moved to final) | Yes |
| `disqualified` | Removed from ranking | No | No |
| `revoked` | Previously final result withdrawn | No | Recalculation required |
| `superseded` | Replaced by corrected record | No | No |

**Rules:**

- Only `accepted` and `finalized` results may affect official medals and tournament points.
- `accepted` alone is **not** sufficient for medal generation.
- Unvalidated results must not be marked final.

---

## 3. Completion Status

| Status | Code | Ranking treatment (default) |
|--------|------|----------------------------|
| Not started | `notStarted` / DNS | No score, no points, no medal |
| Started | `started` | Not ranked |
| Partially completed | `partiallyCompleted` | Below completed; may use completion points if configured |
| Completed | `completed` | Eligible for ranking |
| Completed with penalty | `completedWithPenalty` | Eligible; ranked below clean completion |
| Failed | `failed` | Not ranked above completed |
| Aborted | `aborted` / DNF | Attempt consumed; no placement (default) |
| Disqualified | `disqualified` | No rank, points, or medal |

### Incomplete Attempt Sub-Statuses

| Status | Typical cause | Default attempt consumption |
|--------|---------------|----------------------------|
| `didNotFinish` | Started but objectives not met | Yes |
| `abortedByPlayer` | Voluntary exit | Yes |
| `technicalFailure` | Crash, load failure, server error | No (may qualify for retry) |
| `timedOut` | Exceeded allowed duration | Yes |
| `disconnected` | Network loss during play | Review-dependent |
| `applicationClosed` | App killed or backgrounded | Yes (unless evidence supports technical retry) |
| `gameCrashed` | Unity/WebGL crash | No (may qualify for retry) |
| `missingObjectives` | Mandatory objective skipped | Yes |

---

## 4. Retry Status

| Status | Description |
|--------|-------------|
| `requested` | Player or official requested retry |
| `underReview` | Evidence being evaluated |
| `approved` | Retry granted; not yet used |
| `rejected` | Retry denied |
| `used` | Replacement attempt completed or started |
| `expired` | Approval window passed |
| `cancelled` | Withdrawn or invalidated |

### Retry Types

| Type | Purpose |
|------|---------|
| `standardAttempt` | Normal tournament attempt (not exceptional) |
| `technicalRetry` | Replacement after confirmed technical failure |
| `administrativeRetry` | Special correction by authorized admin |
| `playoffAttempt` | Tie-break or playoff round |
| `practiceRetry` | Non-ranking practice (when enabled) |

---

## 5. Disqualification Scope

| Scope | Effect |
|-------|--------|
| `attemptDisqualification` | Single attempt removed; other attempts may remain |
| `gameDisqualification` | Removed from one tournament game |
| `tournamentDisqualification` | Removed from entire tournament; medals revoked |
| `teamDisqualification` | Entire team removed per team rules |
| `temporaryAccountSuspension` | Account restricted for a period |
| `permanentAccountBan` | Account permanently blocked |
| `institutionReview` | Institution flagged for administrative review |

---

## 6. Leaderboard Status

| Type | Description | User message |
|------|-------------|--------------|
| `live` | Updates during competition | "Live results are provisional and may change after validation." |
| `provisional` | Accepted results; may exclude suspicious entries | "Results under validation." |
| `frozen` | No ordinary ranking changes during review | "Leaderboard frozen for review." |
| `final` | Approved official rankings | "Official final results." |
| `archived` | Historical snapshot post-tournament | "Archived results." |

**Rule:** Only the `final` leaderboard determines medals, tournament points, Champion, Runner-up, certificates, and official reports.

---

## 7. Medal Status

| Status | Description |
|--------|-------------|
| `provisional` | Assigned pending review |
| `approved` | Review complete |
| `published` | Publicly visible |
| `revoked` | Withdrawn from recipient |
| `reassigned` | Moved to another participant after recalculation |

Medals must not be published before result review and leaderboard freeze complete.

---

## 8. Status Transition Diagrams

### 8.1 Standard Result Flow

```
created → inProgress → submitted → validating
                                        ↓
                          ┌─────────────┼─────────────┐
                          ↓             ↓             ↓
                      accepted      rejected     suspicious
                          ↓                           ↓
                     provisional                  underReview
                          ↓                           ↓
                       frozen              ┌──────────┼──────────┐
                          ↓                ↓          ↓          ↓
                      approved          accepted  rejected  disqualified
                          ↓
                      finalized
```

### 8.2 Technical Retry Flow

```
attempt (technicalFailure) → retry requested → underReview
                                                    ↓
                                    ┌───────────────┼───────────────┐
                                    ↓                               ↓
                                approved                          rejected
                                    ↓
                        replacement attempt (standardAttempt)
                                    ↓
                              normal result flow
```

### 8.3 Disqualification and Recalculation

```
suspicious / evidence → underReview → disqualified
                                            ↓
                              leaderboard recalculated
                                            ↓
                              medals reassigned (if applicable)
                                            ↓
                              Olympics standings updated
                                            ↓
                              audit log + notifications
```

---

## 9. Immutable Record Rules

Once a result is submitted:

1. Original raw data must be preserved.
2. Corrections create a new reviewed status, adjustment record, and audit entry.
3. Original data must not be silently overwritten.
4. Finalized results may be reopened only with Super Administrator permission, documented reason, evidence, and participant notification.

---

## 10. Quick Reference — What Each Status Allows

| Action | Live | Provisional | Frozen | Final |
|--------|------|-------------|--------|-------|
| Display on screen | Yes | Yes | Yes | Yes |
| Award medal | No | No | No | Yes |
| Calculate Champion | No | No | No | Yes |
| Change without review workflow | Yes | Limited | No | No (reopen only) |
| Export official report | No | No | No | Yes |

---

*End of document.*
