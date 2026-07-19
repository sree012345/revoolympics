# Cloud Functions

TypeScript Cloud Functions for Revo Olympics.

## Structure

```
src/
├── admin/
├── games/
├── institutions/
├── users/
├── sessions/
├── results/
├── tournaments/
├── notifications/
├── audit/
├── shared/
└── index.ts
```

## Rules

- TypeScript strict mode
- Validate all client input
- Do not trust client-supplied roles
- Use server timestamps for official records
- No secrets in source files

## Commands

```bash
npm install
npm run build
npm test
firebase emulators:start --only functions
```

## Environment

Copy `.env.example` to `.env` (gitignored).
