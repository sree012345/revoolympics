# Bug Fix Prompt Template

---

**Sprint:** Vx.y (or hotfix)  
**Bug:** [Short description]  
**Severity:** [critical | high | medium | low]

## Reproduction

1. [Steps]
2. [Expected vs actual]

## Allowed folders

- [List minimal files/modules needed]

## Do not modify

- [Unrelated areas]
- Product rules or ranking formulas (unless bug is in documented rules)

## Constraints

- Minimal focused fix — do not rewrite entire module
- Preserve null safety and security checks
- Do not remove tests to make CI pass
- Do not introduce secrets

## Required

- [ ] Root cause explained in PR description
- [ ] Regression test added
- [ ] Error handling/logging improved if gap contributed to bug

## Acceptance criteria

1. Bug no longer reproduces
2. Tests pass
3. No unrelated changes

**Fix the cause, not the symptom.**
