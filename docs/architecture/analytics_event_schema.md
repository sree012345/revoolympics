# Analytics Event Schema

Governance for Firebase Analytics events across Revo Olympics environments.

## Principles

- Each environment has a **separate** Analytics property/stream
- Staging events must not appear in production reports
- Do not send PII or sensitive institution data in event names or parameters

## Event record template

| Field | Description |
|-------|-------------|
| Event name | snake_case, stable across versions where possible |
| Purpose | Why the event exists |
| Environments | `development`, `staging`, `production`, or subset |
| Parameters | Name, type, allowed values |
| Privacy | `public`, `internal`, `restricted` |
| Trigger | Where/when fired |
| Owner | Team or role |
| Version | Introduced in product version |

## Foundation events

### `app_environment_started`

| Field | Value |
|-------|-------|
| Purpose | Verify correct environment wiring in dev/staging |
| Environments | development, staging (optional in production) |
| Parameters | `app_environment` (string), `platform` (string) |
| Privacy | internal |
| Trigger | App startup after environment validation |
| Owner | Platform |
| Version | F0.5 |

### User property: `app_environment`

Set only when useful and compliant. Values: `development`, `staging`, `production`.

## Forbidden analytics payload

Never send as event names or parameters:

- Student email or mobile number
- Home address or register number
- Authentication tokens
- Free-text teacher notes
- Full private names where unnecessary

## Environment availability

Document per event whether it is:

- **Dev only** — debugging
- **Staging + Prod** — release validation and live metrics
- **Prod only** — business-critical funnels

## Related

- [firebase_environment_architecture.md](firebase_environment_architecture.md)
- Product rules in `docs/product/`
