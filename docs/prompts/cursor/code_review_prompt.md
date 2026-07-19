# Code Review Prompt Template

Use when asking Cursor to review a change (not implement). For formal review, use human reviewers per [ai_generated_code_review.md](../../development/ai_generated_code_review.md).

---

**Change:** [PR title or description]  
**Sprint:** Vx.y  
**Diff scope:** [branch | uncommitted | specific files]

## Review focus

- [ ] Architecture and sprint scope
- [ ] Security and secrets
- [ ] Result integrity (no client official writes)
- [ ] Null safety and error handling
- [ ] Tests meaningful and passing
- [ ] Documentation updated
- [ ] File size and complexity
- [ ] Environment correctness

## Checklists

Apply:

- `docs/development/code_review_rules.md`
- `.cursor/rules/15-definition-of-done.mdc`
- `.cursor/rules/12-result-integrity-rules.mdc` (if results/tournaments touched)

## Output format

For each finding:

1. **Severity:** blocker | major | minor | suggestion
2. **Location:** file and line or area
3. **Issue:** what is wrong
4. **Recommendation:** specific fix

Do not approve if secrets, missing tests on business logic, or client official-result writes are present.

**Review only — do not implement fixes unless asked.**
