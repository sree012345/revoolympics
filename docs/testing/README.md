# Testing Documentation

Testing strategy and guides (implementation in feature sprints).

## Test Locations

| Area | Location |
|------|----------|
| Flutter unit/widget | `apps/*/test/` |
| Flutter integration | `apps/*/integration_test/` |
| Cross-platform | `tests/integration/`, `tests/end_to_end/` |
| Security | `tests/security/` |
| Performance | `tests/performance/` |
| Firebase rules | `firebase/firestore/tests/`, `firebase/storage/tests/` |
| Cloud Functions | `firebase/functions/test/` |
| Unity EditMode | `unity/shared_bridge/Tests/EditMode/` |
| Tools | `tools/*/tests/` |

## Principles

Every sprint includes positive, negative, and regression tests per product rules.

## Related

- [Product test scenarios](../product/revo_olympics_product_rules.md#15-test-scenarios)
- [Competition ranking tests](../product/revo_olympics_competition_ranking_rules.md#20-test-scenarios)
