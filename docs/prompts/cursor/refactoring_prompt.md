# Refactoring Prompt Template

---

**Sprint:** Vx.y  
**Target:** [File or module path]  
**Goal:** [Reduce complexity | extract repository | split widget | …]

## Allowed folders

- [Specific paths only]

## Do not modify

- Behaviour (unless explicitly fixing a bug)
- Public API contracts without migration plan
- Firebase rules, protocol version, product rules

## Constraints

- No behaviour change unless documented and tested
- File size targets in `docs/development/file_size_and_complexity_limits.md`
- No artificial one-line file splits
- Preserve modular architecture and dependency direction

## Required

- [ ] Existing tests still pass
- [ ] Add tests if coverage was insufficient before refactor
- [ ] Update README if module boundaries changed

## Acceptance criteria

1. Complexity reduced measurably (line count, nesting, responsibilities)
2. All tests pass
3. No functional regression

**Refactor in small steps. Do not change unrelated files.**
