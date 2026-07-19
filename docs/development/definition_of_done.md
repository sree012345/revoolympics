# Definition of Done

A Revo Olympics task is **done** only when all criteria below are satisfied.

## 1. Scope and architecture

- [ ] Implements the sprint/task acceptance criteria
- [ ] Follows approved architecture (Flutter shell, Unity runtime, Firebase backend)
- [ ] Modifies only allowed folders specified in the task
- [ ] No unauthorized architecture changes
- [ ] No circular dependencies introduced

## 2. Code quality

- [ ] Null safety preserved (Dart/C#)
- [ ] Errors handled with codes and user-safe messages
- [ ] Logging appropriate; no sensitive data logged
- [ ] File sizes within targets or refactor justified (see [file_size_and_complexity_limits.md](./file_size_and_complexity_limits.md))
- [ ] No broad lint suppressions without justification
- [ ] No temporary debug code in production paths

## 3. Security

- [ ] No secrets or credentials in the diff
- [ ] Authorization validated on trusted backend where applicable
- [ ] Institution scope enforced where applicable
- [ ] Correct environment (no silent production default)
- [ ] No privileged client writes (ranks, medals, official results)

## 4. Testing

- [ ] Unit/widget/integration tests added for behavioural changes
- [ ] Firebase rules or Functions tests updated where applicable
- [ ] All tests pass locally and in CI
- [ ] Static analysis passes (`dart analyze`, ESLint, etc.)

## 5. Documentation

- [ ] README updated for new/changed modules
- [ ] Protocol, schema, or architecture docs updated if changed
- [ ] New env vars, error codes, or deploy steps documented
- [ ] CHANGELOG updated for user-visible or operational changes (when applicable)

## 6. Review and merge

- [ ] Pull request description explains what and why
- [ ] Code review checklist completed ([code_review_rules.md](./code_review_rules.md))
- [ ] AI-generated code reviewed by human ([ai_generated_code_review.md](./ai_generated_code_review.md))
- [ ] Required approvals obtained for security/production changes

## 7. Foundation and version gates

- [ ] Version 1 feature work does not begin until [foundation_completion_gate.md](../product/foundation_completion_gate.md) is approved
- [ ] Work matches current sprint — no out-of-scope features from later versions

## Prohibited "done" states

- Tests failing or deleted to pass CI
- "Compiles" without tests for business logic
- Placeholder in production without explicit marking
- Missing security-rule updates for new data paths

## Cursor rule

See `.cursor/rules/15-definition-of-done.mdc`.
