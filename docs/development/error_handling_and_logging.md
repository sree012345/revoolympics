# Error Handling and Logging

Standards for errors and logs across Flutter, Unity, Firebase Functions, and tools.

## Error categories

| Category | Examples |
|----------|----------|
| `validation` | Invalid input, missing field |
| `authentication` | Not signed in, expired session |
| `authorization` | Insufficient role or institution scope |
| `network` | Connectivity failure |
| `timeout` | WebView load, HTTP timeout |
| `configuration` | Missing env, wrong Firebase project |
| `integration` | Bridge failure, protocol mismatch |
| `data` | Missing document, corrupt payload |
| `gameRuntime` | Unity gameplay error |
| `firebase` | Backend operation failure |
| `security` | App Check, tampering detected |
| `unknown` | Unexpected — log with full context internally |

## Required per error path

- Technical error code (stable string)
- User-safe message (localized in UI)
- Log severity
- Retry eligibility
- Support escalation flag
- Audit logging flag (privileged operations)

## Handling rules

**Do not:**

- Ignore errors or use empty catch blocks
- Return null for every failure without typed result
- Show stack traces to end users
- Retry indefinitely
- Treat auth failures as generic network errors

## Log levels

| Level | Use |
|-------|-----|
| `debug` | Development diagnostics (suppressed in production) |
| `info` | Normal operational events |
| `warning` | Recoverable anomalies |
| `error` | Operation failed; user impact |
| `critical` | Security or data-integrity failure |

## Structured fields

Include where relevant:

`environment`, `application`, `module`, `operation`, `requestId`, `sessionId`, `playerIdHash`, `institutionId`, `gameId`, `gameVersion`, `tournamentId`, `errorCode`

## Never log

Passwords, tokens, private keys, service-account JSON, sensitive student PII, full auth headers, private verification documents.

## Platform notes

### Flutter

Map internal errors to user-safe localized messages. Use crash reporting in staging/production mobile builds. Avoid uncontrolled `print()`.

### Unity

Category-based logging; include game and protocol version. No per-frame logs. Clear bridge failure messages.

### Cloud Functions

Structured logger with correlation ID. Log start/success/failure for critical paths with duration where useful. Return stable error codes to clients — not stack traces.

## Firebase Functions error codes (examples)

`SESSION_NOT_FOUND`, `ATTEMPT_LIMIT_EXCEEDED`, `RESULT_REJECTED`, `INSUFFICIENT_PERMISSION`, `INSTITUTION_SCOPE_MISMATCH`, `GAME_VERSION_NOT_ACTIVE`

## Cursor rule

See `.cursor/rules/08-error-handling-and-logging-rules.mdc`.
