# Firebase Environment Verification

Test plan to confirm Sprint F0.5 environment isolation before backend feature work begins.

## Completion gate

The team must answer consistently:

- What are the three Firebase project IDs?
- Which project is used for daily development, release testing, and real users?
- Does every project have its own Firestore, Storage, Auth users, and Hosting sites?
- How are Hosting targets mapped?
- Which Flutter flavour and `REVO_ENV` pair is used per environment?
- How is a wrong-environment build blocked?
- Where are Functions deployed and how are secrets stored?
- Who can access production and which service account deploys it?

## Positive tests

### Flutter connectivity

| # | Test | Expected |
|---|------|----------|
| P1 | Dev player app with `REVO_ENV=development` | Connects to `revoolympics-dev` only |
| P2 | Staging player app | Connects to `revoolympics-staging` only |
| P3 | Production player app | Connects to `revoolympics-prod` only |
| P4 | Dev admin web | Connects to `revoolympics-dev` only |
| P5 | Staging admin web | Connects to `revoolympics-staging` only |
| P6 | Production admin web | Connects to `revoolympics-prod` only |

### Isolation

| # | Test | Expected |
|---|------|----------|
| P7 | Create dev Auth user | User absent in staging and prod |
| P8 | Write dev Firestore doc | Not visible in staging/prod |
| P9 | Upload dev Storage file | Not visible in prod bucket |
| P10 | Dev analytics event | Not in production reports |

### UI and configuration

| # | Test | Expected |
|---|------|----------|
| P11 | Development build | Shows `DEV` banner |
| P12 | Staging build | Shows `STAGING` banner |
| P13 | Production build | No debug banner |
| P14 | Missing `REVO_ENV` | Startup blocked with error |
| P15 | Staging build + prod Firebase config | Rejected at validation |

### Deploy and CLI

| # | Test | Expected |
|---|------|----------|
| P16 | `firebase deploy --project revoolympics-dev --only firestore:rules` | Updates dev only |
| P17 | Hosting target `games` on dev | Resolves to `revoolympics-games-dev` |
| P18 | Functions env params | Match target project |
| P19 | Emulator mode from dev build | Connects to localhost |
| P20 | Prod deploy script without approval | Exits with error |

## Negative tests

| # | Test | Must fail |
|---|------|-----------|
| N1 | Single shared Firebase project for all envs | Architecture rejected |
| N2 | `games_dev` collection prefix as main isolation | Architecture rejected |
| N3 | Dev build → production project | Blocked |
| N4 | Prod build → dev project | Blocked |
| N5 | Prod uses dev Storage URL | Rejected |
| N6 | Prod deploy from feature branch | Script exits |
| N7 | Prod deploy with dirty Git tree | Script exits |
| N8 | `USE_FIREBASE_EMULATORS` on prod build | Blocked |
| N9 | Service account JSON in Flutter/Unity | Must not exist in repo |
| N10 | Secrets in Git | Must not exist |
| N11 | Production seed creates sample players | Forbidden |
| N12 | Prod Firestore unrestricted mode | Forbidden |
| N13 | Client assigns privileged custom claims | Forbidden |

## Repository verification

Run after clone:

```bash
./scripts/setup/verify_repository.sh
```

Manual checks:

- [ ] `.firebaserc` default is `revoolympics-dev`
- [ ] `firebase/environments/*/environment.json` present
- [ ] Flutter `lib/core/environment/` exists in player and admin apps
- [ ] Placeholder `firebase_options_*.dart` files exist
- [ ] Deploy scripts executable
- [ ] No `.env` or service account files committed

## Manual Firebase console checks

Per project:

- [ ] Firestore Native mode in expected region
- [ ] Storage enabled with rules deployed
- [ ] Three Hosting sites created and mapped
- [ ] Flutter apps registered with correct bundle IDs
- [ ] App Check configuration matches environment policy
- [ ] Billing alerts configured

## Sign-off

| Role | Name | Date |
|------|------|------|
| Technical lead | | |
| Security lead | | |

## Related

- [firebase_environment_setup.md](../development/firebase_environment_setup.md)
- [firebase_environment_architecture.md](../architecture/firebase_environment_architecture.md)
