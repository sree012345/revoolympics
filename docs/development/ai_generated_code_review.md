# AI-Generated Code Review

Every AI-generated change (Cursor or other tools) must be reviewed by a qualified human before merge.

## Reviewer responsibilities

Verify the change:

1. Matches the original request and sprint scope
2. Did not invent requirements not in product/architecture docs
3. Respects existing architecture and module boundaries
4. Did not weaken security checks, rules, or authorization
5. Handles errors with structured codes and user-safe messages
6. Includes meaningful tests (not trivial assertions)
7. Introduces no secrets, credentials, or sensitive log data
8. Uses legitimate dependencies with justified need
9. Updates documentation where behaviour changed
10. Is understandable and maintainable by the team

## Red flags — reject or request revision

- Service-account JSON or API secrets in source
- Client writes to official results, medals, or ranks
- Unrestricted Firestore/Storage rules
- Empty catch blocks or broad `// ignore:` directives
- Deleted or weakened failing tests
- Silent protocol event renames without version bump
- Production Firebase project as fallback
- Files far exceeding review thresholds without refactor plan
- Changes outside allowed folders in the task prompt
- Placeholder marked as production-ready

## AI must not merge because it compiles

Compilation and passing lints are necessary but not sufficient. Review against:

- `.cursor/rules/` (especially always-applied rules)
- `docs/product/` for product rules
- Sprint acceptance criteria

## Approval

| Change type | Reviewer |
|-------------|----------|
| Normal feature | 1 qualified reviewer + CI |
| Security-sensitive | Technical lead + security-aware reviewer |
| Production-critical | 2 approvals + QA evidence + rollback plan |

See [code_review_rules.md](./code_review_rules.md) for full checklists.

## Prompt hygiene

Authors should use templates in [docs/prompts/cursor/](../prompts/cursor/) with explicit allowed/prohibited folders and acceptance criteria to reduce review burden.
