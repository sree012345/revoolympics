# Firestore Rules Prompt Template

---

**Sprint:** Vx.y  
**Task:** [Describe collection/path access change]

## Allowed folders

- `firebase/firestore/firestore.rules`
- `firebase/firestore/tests/` (or approved rules test location)

## Do not modify

- Cloud Functions (unless coordinated)
- Flutter/Unity client write paths without updating clients

## Constraints

- Deny by default
- Validate auth, role, institution scope, immutable fields
- Prevent direct official-result, medal, and custom-claim writes from clients
- Same rule structure for all environments (no environment forks)
- No `allow read, write: if request.auth != null;` for production data

## Required tests

- [ ] Unauthenticated access denied
- [ ] Wrong role denied
- [ ] Wrong institution denied
- [ ] Invalid official-result write denied
- [ ] Valid authorized access allowed

## Required documentation

- [ ] Update `firebase/firestore/README.md` or schema doc if collection contract changes

## Acceptance criteria

1. Rules deploy to emulator and pass test suite
2. No regression on existing collections

**Do not change unrelated files.**
