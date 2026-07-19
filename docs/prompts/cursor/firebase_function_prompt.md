# Firebase Cloud Function Prompt Template

---

**Sprint:** Vx.y  
**Function group:** [admin | games | results | …]  
**Task:** [One-line goal]

## Allowed folders

- `firebase/functions/src/[group]/`
- `firebase/functions/test/`

## Do not modify

- Flutter or Unity apps (unless returning typed client contract)
- Unrelated function groups
- Firestore/Storage rules (unless task includes rule updates)

## Architecture constraints

- TypeScript strict mode
- Handler → validation → authorization → service → repository → audit → response
- Idempotent for result submission and other retriable operations
- Server timestamps for authoritative dates
- Same source deploys to dev/staging/prod — no `functions_dev/` copies

## Security constraints

- Never trust client role, institution ownership, rank, medal, or approval status
- Secrets in Secret Manager only
- Return stable error codes, not stack traces
- Audit log for privileged operations

## Requirements

- Input schema validation
- Institution scope enforcement
- Structured logging with correlation ID
- Unit tests + emulator tests where applicable

## Required documentation

- [ ] Update function README or `firebase/functions/README.md`
- [ ] Document new error codes in `docs/development/error_handling_and_logging.md` if added

## Acceptance criteria

1. [Criterion 1]
2. [Criterion 2]

**Do not change unrelated files. Do not hardcode production project IDs.**
