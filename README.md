# Revo Olympics

**One platform. Multiple games. Institutions, teams, medals and champions.**

Revo Olympics is a multilingual educational and tournament gaming platform. Players discover and play Unity WebGL games inside a Flutter application. Administrators manage games, institutions, teams, and tournaments through a Flutter Web admin panel. Firebase provides the backend.

## Architecture

| Layer | Technology |
|-------|------------|
| Player application | Flutter (mobile) |
| Admin panel | Flutter Web |
| Spectator Hub | Flutter desktop (Version 5) |
| Game runtime | Unity 6.x WebGL in fullscreen WebView |
| Backend | Firebase (Auth, Firestore, Storage, Hosting, Functions) |

See [docs/architecture/README.md](docs/architecture/README.md) and [docs/product/revo_olympics_product_rules.md](docs/product/revo_olympics_product_rules.md).

## Repository Structure

```
revoolympics/
├── apps/           # Flutter applications (player, admin, spectator)
├── unity/          # Shared bridge, templates, individual games
├── firebase/       # Functions, Firestore, Storage, Hosting, seed
├── tools/          # WebGL validator, build publisher, localization validator
├── docs/           # Product, architecture, development documentation
├── tests/          # Cross-platform integration and E2E tests
└── scripts/        # Setup, build, test, deploy automation
```

## Version Roadmap

| Version | Focus |
|---------|-------|
| Foundation | Product rules, repository, Firebase environments |
| Version 1 | Game Library MVP (no player login) |
| Version 2 | Players, institutions, validated results |
| Version 3 | Teachers and teams |
| Version 4 | Tournaments and Olympics |
| Version 5 | Local spectator mode |
| Version 6 | Automated Unity builds and production ops |

## Prerequisites

- Flutter SDK (stable channel)
- Dart SDK (included with Flutter)
- Unity 6.x (for game development)
- Node.js 20+ (Firebase Functions)
- Firebase CLI
- Git and Git LFS

## Local Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:Revolution-Games/revoolympics.git
   cd revoolympics
   git lfs install
   ```

2. Copy environment examples:
   ```bash
   cp .env.example .env
   cp .firebaserc.example .firebaserc
   cp apps/player_app/.env.example apps/player_app/.env
   cp apps/admin_web/.env.example apps/admin_web/.env
   cp firebase/functions/.env.example firebase/functions/.env
   ```

3. Install dependencies:
   ```bash
   dart pub global activate melos
   melos bootstrap
   cd firebase/functions && npm install
   ```

4. Default environment is **development**. Never deploy to production without explicit authorization.

See [docs/development/local_setup.md](docs/development/local_setup.md).

## Common Commands

```bash
melos analyze          # Flutter static analysis
melos test             # Flutter unit tests
firebase emulators:start   # Local Firebase emulators
```

## Documentation

- [Product rules](docs/product/revo_olympics_product_rules.md)
- [Repository guide](docs/development/repository_structure.md)
- [Git workflow](docs/development/git_workflow.md)
- [Environment guide](docs/development/environment_guide.md)
- [Secret handling](docs/development/secret_handling.md)

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## Security

**Do not commit secrets.** Report vulnerabilities per [SECURITY.md](SECURITY.md).

## License

Proprietary — Revolution Games. See [LICENSE](LICENSE).
