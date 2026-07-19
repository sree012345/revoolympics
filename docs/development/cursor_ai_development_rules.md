# Cursor AI Development Rules

Official AI-assisted development rules for Revo Olympics (Sprint F0.6).

## Purpose

These rules govern how Cursor AI and human developers create, modify, review, and document code across:

- Flutter player application
- Flutter Web admin application
- Future Spectator Hub (Version 5)
- Unity 6.x WebGL projects and shared bridge
- Firebase (Functions, Firestore rules, Storage rules, Hosting)
- Build tools, tests, and documentation

## Rule files

All rules live in `.cursor/rules/`:

| File | Scope | Always apply |
|------|-------|--------------|
| `00-revo-olympics-project-foundation.mdc` | Core architecture | Yes |
| `01-general-development-rules.mdc` | All code | Yes |
| `02-modular-architecture-rules.mdc` | Module structure | Yes |
| `03-flutter-development-rules.mdc` | `apps/**/*.dart` | No |
| `04-unity-csharp-development-rules.mdc` | `unity/**/*.cs` | No |
| `05-flutter-unity-protocol-rules.mdc` | Bridge and protocol | No |
| `06-firebase-development-rules.mdc` | `firebase/**/*` | No |
| `07-security-and-secret-rules.mdc` | Security | Yes |
| `08-error-handling-and-logging-rules.mdc` | Errors and logs | Yes |
| `09-testing-rules.mdc` | Tests | Yes |
| `10-documentation-rules.mdc` | Docs | Yes |
| `11-file-size-and-complexity-rules.mdc` | Size limits | Yes |
| `12-result-integrity-rules.mdc` | Official results | Yes |
| `13-localization-rules.mdc` | i18n | No |
| `14-performance-rules.mdc` | Performance | Yes |
| `15-definition-of-done.mdc` | Completion criteria | Yes |

## Priority when rules conflict

1. Product and architecture rules
2. Security and result-integrity rules
3. Technology-specific rules
4. Testing and documentation rules
5. Style and file-size rules

## Always-on rules

These apply to every Cursor session:

- `00`, `01`, `02`, `07`, `08`, `09`, `10`, `11`, `12`, `14`, `15`

Technology-specific rules apply when editing matching files (globs).

## Human review required

AI-generated code must not merge without human review. See [ai_generated_code_review.md](./ai_generated_code_review.md).

## Prompt templates

Reusable templates: [docs/prompts/cursor/](../prompts/cursor/)

Every significant implementation prompt should include:

- Sprint ID and goal
- Allowed and prohibited folders
- Architecture and security constraints
- Required tests and documentation
- Acceptance criteria
- Instruction not to change unrelated files

## Foundation gate

Version 1 must not begin until [foundation_completion_gate.md](../product/foundation_completion_gate.md) is approved.

## Related documents

- [coding_standards.md](./coding_standards.md)
- [definition_of_done.md](./definition_of_done.md)
- [secure_development_rules.md](./secure_development_rules.md)
- [error_handling_and_logging.md](./error_handling_and_logging.md)
- [file_size_and_complexity_limits.md](./file_size_and_complexity_limits.md)
- [code_review_rules.md](./code_review_rules.md)
