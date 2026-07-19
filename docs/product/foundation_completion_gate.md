# Foundation Completion Gate

Revo Olympics Foundation is complete only when **every required gate** below is approved. No Version 1 feature-development sprint may begin until this gate passes.

**Last updated:** Sprint F0.6 (repository scaffold and documentation status as of commit pending)

## Gate summary

| Gate | Topic | Repository status | Approval status |
|------|-------|-------------------|-----------------|
| 1 | Architecture | Partial docs | Pending |
| 2 | Firebase environments | Scaffolded (F0.5) | Pending cloud setup |
| 3 | Repository structure | Complete (F0.4) | Pending sign-off |
| 4 | Game protocol | Not documented | Pending |
| 5 | Ranking rules | Complete (F0.2) | Pending sign-off |
| 6 | Institution rules | Not documented | Pending |
| 7 | Cursor development rules | Complete (F0.6) | Pending sign-off |
| 8 | Security foundation | Documented | Pending sign-off |
| 9 | Testing foundation | Partial | Pending |
| 10 | Documentation committed | Partial | Pending |

---

## Gate 1 — Architecture approval

Must confirm:

- Flutter is the player application
- Flutter Web is the admin application
- Unity 6.x WebGL is the gameplay runtime in Flutter WebViews
- Firebase is the backend; Cloud Functions validate official results
- Development, Staging, Production are separate Firebase projects
- Spectator Hub deferred to Version 5
- Automated Unity build deployment deferred to Version 6

### Required documents

| Document | Status |
|----------|--------|
| `docs/architecture/revo_olympics_system_architecture.md` | **Not created** |
| `docs/architecture/flutter_architecture.md` | **Not created** |
| `docs/architecture/unity_webgl_architecture.md` | **Not created** |
| `docs/architecture/firebase_architecture.md` | **Not created** (environment architecture exists) |
| `docs/architecture/firebase_environment_architecture.md` | **Exists** (F0.5) |

### Approvers

Product owner, technical architect, Flutter lead, Unity lead, Firebase/backend lead.

---

## Gate 2 — Firebase environments exist

Three independent Firebase projects with separate Firestore, Storage, Hosting, Auth, Functions, Analytics, and registered apps.

| Requirement | Status |
|-------------|--------|
| `revoolympics-dev` project | **Manual — create in console** |
| `revoolympics-staging` project | **Manual — create in console** |
| `revoolympics-prod` project | **Manual — create in console** |
| Repository config (`.firebaserc`, flavours, env layer) | **Exists** (F0.5) |
| Environment documentation | **Exists** (F0.5) |
| Verification checklist | **Exists** — `docs/testing/firebase_environment_verification.md` |
| No silent production default | **Enforced in Flutter env loader** |

---

## Gate 3 — Repository structure exists

| Requirement | Status |
|-------------|--------|
| Monorepo layout (`apps/`, `unity/`, `firebase/`, `tools/`, `docs/`, `tests/`, `scripts/`) | **Exists** (F0.4) |
| Git initialized | **Yes** |
| Git LFS configured | **Requires local `git lfs install`** |
| `main` and `develop` branches | **Exist locally** |
| Branch protection | **Configure in remote** |
| PR template, CODEOWNERS, `.gitignore`, `.gitattributes` | **Exists** |
| Secret-handling policy | **Exists** — `docs/development/secret_handling.md` |
| Root README, CONTRIBUTING, SECURITY | **Exists** |

---

## Gate 4 — Game protocol documented

| Requirement | Status |
|-------------|--------|
| `docs/game_integration/flutter_unity_protocol.md` | **Not created** |
| Machine-readable schema | **Planned** |
| Protocol approval | **Pending** |

No game-integration implementation until protocol is approved.

---

## Gate 5 — Ranking rules documented

| Document | Status |
|----------|--------|
| `docs/product/revo_olympics_competition_ranking_rules.md` | **Exists** (F0.2) |
| `docs/product/revo_olympics_result_status_rules.md` | **Exists** (F0.2) |
| `docs/product/revo_olympics_points_table_examples.md` | **Exists** (F0.2) |

Covers ranking modes, ties, retries, disqualification, final-result workflow.

---

## Gate 6 — Institution rules documented

| Document | Status |
|----------|--------|
| `docs/product/revo_olympics_institution_general_user_rules.md` | **Not created** |

Required before Version 2 institution features; must exist for Foundation approval.

---

## Gate 7 — Cursor development rules committed

| Requirement | Status |
|-------------|--------|
| `.cursor/rules/00` through `15` | **Exists** (F0.6) |
| Supporting development docs | **Exists** (F0.6) |
| Always-applied rules enabled | **Yes** (`00`, `01`, `02`, `07`–`12`, `14`, `15`) |
| Prompt templates | **Exists** — `docs/prompts/cursor/` |

---

## Gate 8 — Security foundation approved

| Topic | Document |
|-------|----------|
| No hardcoded credentials | `docs/development/secure_development_rules.md`, `.cursor/rules/07-*` |
| Secret storage | `docs/development/secret_handling.md` |
| Environment isolation | `docs/architecture/firebase_environment_architecture.md` |
| Deny-by-default Firestore/Storage | `firebase/firestore/firestore.rules`, `firebase/storage/storage.rules` |
| Result integrity | `.cursor/rules/12-result-integrity-rules.mdc` |
| Production deployment controls | `docs/operations/firebase_deployment_rules.md` |

Approval pending from security lead.

---

## Gate 9 — Testing foundation approved

| Requirement | Status |
|-------------|--------|
| `docs/testing/testing_strategy.md` | **Not created** |
| CI workflow placeholders | **Exists** — `.github/workflows/` |
| Firebase rules test workflow | **Placeholder** |
| Environment verification doc | **Exists** (F0.5) |

---

## Gate 10 — Documentation committed

Minimum committed documentation:

| Area | Status |
|------|--------|
| Product rules (F0.1) | **Exists** |
| Competition rules (F0.2) | **Exists** |
| Repository structure (F0.4) | **Exists** |
| Firebase environments (F0.5) | **Exists** |
| Cursor rules (F0.6) | **Exists** |
| Institution rules | **Missing** |
| Game protocol | **Missing** |
| Full architecture set | **Partial** |
| Testing strategy | **Missing** |

---

## Foundation completion checklist

Use this checklist in review meetings. All items must be checked before Version 1 authorization.

### Product

- [ ] Product vision approved (`docs/product/revo_olympics_product_rules.md`)
- [ ] Version boundaries approved (`docs/product/revo_olympics_mvp_scope.md`)
- [ ] Terminology glossary approved

### Competition

- [ ] Ranking modes and tie rules approved
- [ ] Retry and disqualification rules approved
- [ ] Final-result workflow approved

### Institutions

- [ ] Institution types and general-user model documented and approved
- [ ] Teacher, transfer, and archive rules approved

### Architecture

- [ ] System architecture document approved
- [ ] Flutter, Unity, Firebase architecture documents approved
- [ ] Backend-authority model approved

### Repository and environments

- [ ] Repository structure verified (`scripts/setup/verify_repository.sh`)
- [ ] Git LFS configured on developer machines and remote
- [ ] Branch protection and PR rules active on remote
- [ ] Three Firebase projects created and verified
- [ ] Environment switching and production safeguards verified

### Protocol

- [ ] Flutter–Unity protocol document approved
- [ ] Message envelope and versioning approved

### Cursor rules

- [ ] All `.cursor/rules/` files committed and reviewed
- [ ] Always-applied rules verified in Cursor
- [ ] AI code review process adopted

### Security and testing

- [ ] Security foundation approved
- [ ] Testing strategy approved
- [ ] No credentials committed
- [ ] Clean clone verification passed

---

## Authorization

Record approvals in [foundation_approval_record.md](./foundation_approval_record.md).

**Version 1 development authorized:** No — pending gate completion and stakeholder sign-off.

When approved, the next phase is **Version 1 — Game Library MVP**, starting with **Sprint V1.1 — Flutter Player Application Foundation**.

## Related

- [foundation_approval_record.md](./foundation_approval_record.md)
- [cursor_ai_development_rules.md](../development/cursor_ai_development_rules.md)
- [revo_olympics_mvp_scope.md](./revo_olympics_mvp_scope.md)
