# Flutter Feature Prompt Template

Copy and fill in before asking Cursor to implement a Flutter feature.

---

**Sprint:** Vx.y  
**Task:** [One-line goal]

## Allowed folders

- `apps/player_app/lib/features/[feature_name]/`
- `apps/player_app/test/features/[feature_name]/`

## Do not modify

- Firebase rules or Functions
- Unity projects
- Unrelated features or modules
- `.cursor/rules/`

## Architecture constraints

- Follow Presentation → Application → Domain → Infrastructure
- Use repository abstraction; no direct Firestore in widgets
- Use `REVO_ENV` / environment config — no hardcoded Firebase project IDs
- Player app features in `lib/features/`; admin in `lib/modules/`

## Security constraints

- No secrets or credentials
- No client writes to official ranks, medals, or final results
- Validate institution scope where applicable

## Requirements

- Sound null safety; no forced `!` without validation
- Screen states: loading, empty, error, unauthorized
- Localization keys for user-facing text
- File size within limits (see `docs/development/file_size_and_complexity_limits.md`)

## Required tests

- [ ] Unit tests for business logic / repositories
- [ ] Widget tests for primary UI states

## Required documentation

- [ ] Feature README or update to existing module README

## Acceptance criteria

1. [Criterion 1]
2. [Criterion 2]

**Do not change unrelated files. Do not implement features outside this sprint scope.**
