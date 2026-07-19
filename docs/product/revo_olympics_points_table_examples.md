# Revo Olympics — Points Table Examples

Reference examples for admin-defined points tables and normalized tournament points. These supplement the authoritative rules in [Competition and Ranking Rules](./revo_olympics_competition_ranking_rules.md).

**Document status:** Foundation Sprint F0.2  
**Last updated:** 2026-07-19

---

## Related Documents

- [Competition and Ranking Rules](./revo_olympics_competition_ranking_rules.md)
- [Result Status Rules](./revo_olympics_result_status_rules.md)
- [Product Rules](./revo_olympics_product_rules.md)

---

## 1. Placement-Based Points Table

Used with `admin_defined_points_table` ranking mode for single-game tournaments.

| Rank | Tournament Points |
|------|-------------------|
| 1 | 25 |
| 2 | 20 |
| 3 | 16 |
| 4 | 13 |
| 5 | 11 |
| 6 | 10 |
| 7 | 9 |
| 8 | 8 |
| 9 | 7 |
| 10 | 6 |
| Participation (valid attempt, no placement) | 1 |

**Configuration notes:**

- Ranks beyond 10 receive 0 points unless explicitly defined.
- Tied ranks use the tournament tie-break sequence before points assignment.
- Participation points apply only to valid completed or partially completed attempts as configured.

---

## 2. Medal-Based Olympics Points Table

Default per-game medal points for Olympics tournaments.

| Medal | Olympics Points |
|-------|-----------------|
| Gold | 5 |
| Silver | 3 |
| Bronze | 1 |
| No medal | 0 |

**Example — Team Phoenix across 4 games:**

| Game | Medal | Points |
|------|-------|--------|
| Game 1 — Quiz Sprint | Gold | 5 |
| Game 2 — Obstacle Run | Bronze | 1 |
| Game 3 — Target Challenge | Silver | 3 |
| Game 4 — Puzzle Relay | Gold | 5 |
| **Total** | | **14** |

---

## 3. Performance-Band Points Table

Used when points are assigned by raw score bands rather than placement.

| Result Band | Points |
|-------------|--------|
| Score 9,000 or above | 100 |
| Score 7,500 – 8,999 | 80 |
| Score 5,000 – 7,499 | 60 |
| Score 2,500 – 4,999 | 30 |
| Valid completion below 2,500 | 10 |
| Did not finish | 0 |
| Disqualified | 0 |

**Validation requirements:**

- Bands must not overlap.
- Every valid score range must map to exactly one band or a defined fallback.
- Bands must be locked before the tournament begins.

---

## 4. Completion-Based Points Table

Used with `completion_based` ranking mode.

| Completion State | Points |
|------------------|--------|
| Completed | 1,000 |
| Completed with minor penalty | 850 |
| 75–99% completed | 600 |
| 50–74% completed | 350 |
| Below 50% | 100 |
| Did not finish | 0 |
| Disqualified | 0 |

**Example — Educational safety simulation:**

| Player | Objectives | Mandatory Missed | Status | Points |
|--------|------------|------------------|--------|--------|
| A | 10/10 | No | Completed | 1,000 |
| B | 9/10 | No | Completed with minor penalty | 850 |
| C | 8/10 | Yes (safety step) | Failed | 0 |
| D | 6/10 | No | 50–74% band | 350 |

---

## 5. Normalized Points Examples

Recommended scale: **0 to 1,000 tournament points**.

### 5.1 Higher-Is-Better (Score Game)

**Configuration:**

- Raw minimum: 0
- Raw maximum: 10,000
- Points maximum: 1,000

**Formula:**

```
normalizedPoints = ((playerValue - minimumValue) / (maximumValue - minimumValue)) × maximumTournamentPoints
```

**Example:**

| Player | Raw Score | Calculation | Normalized Points |
|--------|-----------|-------------|-------------------|
| A | 7,500 | (7,500 / 10,000) × 1,000 | 750.00 |
| B | 10,500 (clamped) | Clamped to 10,000 → 1,000 | 1,000.00 |
| C | -50 (clamped) | Clamped to 0 | 0.00 |

### 5.2 Lower-Is-Better (Time Game)

**Configuration:**

- Best expected time: 40,000 ms (40 sec)
- Maximum valid time: 100,000 ms (100 sec)
- Points maximum: 1,000

**Formula:**

```
normalizedPoints = ((maximumTime - playerTime) / (maximumTime - minimumTime)) × maximumTournamentPoints
```

**Example:**

| Player | Time (ms) | Calculation | Normalized Points |
|--------|-----------|-------------|-------------------|
| A | 55,000 | ((100,000 - 55,000) / 60,000) × 1,000 | 750.00 |
| B | 40,000 | ((100,000 - 40,000) / 60,000) × 1,000 | 1,000.00 |
| C | 105,000 (clamped) | Clamped to 100,000 | 0.00 |

### 5.3 Weighted Olympics Games

| Game | Weight | Player Normalized Points | Weighted Points |
|------|--------|------------------------|-----------------|
| Game A — Quiz | 1.0 | 820.00 | 820.00 |
| Game B — Race | 1.0 | 750.00 | 750.00 |
| Game C — Puzzle | 1.5 | 680.00 | 1,020.00 |
| Final Game | 2.0 | 900.00 | 1,800.00 |
| **Total** | | | **4,390.00** |

Weights must be published before registration closes.

---

## 6. Team Aggregation Examples

### 6.1 Best N Members (N = 3, Team Size = 5)

| Member | Score |
|--------|-------|
| M1 | 900 |
| M2 | 850 |
| M3 | 820 |
| M4 | 600 |
| M5 | 550 |

**Team score (best 3):** 900 + 850 + 820 = **2,570**

### 6.2 Relay Total Time

| Leg | Member | Leg Time (ms) | Handover Penalty (ms) |
|-----|--------|---------------|------------------------|
| 1 | M1 | 48,000 | 0 |
| 2 | M2 | 52,000 | 2,000 |
| 3 | M3 | 49,500 | 0 |
| **Total** | | | **151,500** |

---

## 7. Points Table Validation Checklist

Before locking a points table:

- [ ] No duplicate placement or band entries
- [ ] No negative points (unless penalty mode explicitly enabled)
- [ ] Behaviour defined for unlisted ranks
- [ ] Tie behaviour defined
- [ ] Participation points defined
- [ ] Disqualification points defined (typically 0)
- [ ] Table included in tournament audit snapshot
- [ ] Table immutable after first valid attempt (except emergency correction with audit)

---

*End of document.*
