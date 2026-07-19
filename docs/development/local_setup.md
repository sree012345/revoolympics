# Local Setup

Foundation sprint setup guide. Product features are implemented in later sprints.

## 1. Clone and LFS

```bash
git clone git@github.com:Revolution-Games/revoolympics.git
cd revoolympics
git lfs install
git checkout develop   # or main for stable foundation
```

## 2. Environment Files

```bash
cp .env.example .env
cp .firebaserc.example .firebaserc
cp apps/player_app/.env.example apps/player_app/.env
cp apps/admin_web/.env.example apps/admin_web/.env
cp firebase/functions/.env.example firebase/functions/.env
```

Edit `.env` files with your **development** project values. Never commit them.

## 3. Flutter (Melos)

```bash
dart pub global activate melos
melos bootstrap
```

Run `flutter create` in each app directory when starting Version 1 implementation sprints (not required for F0.4 structure only).

## 4. Firebase Functions

```bash
cd firebase/functions
npm install
npm run build
```

## 5. Emulators

```bash
firebase emulators:start
```

Default ports are defined in root `firebase.json`.

## 6. Verify Clean State

```bash
git status   # should show no secrets or build artifacts
melos analyze   # after Flutter projects are initialized
```

## Prerequisites

- Flutter stable SDK
- Node.js 20+
- Firebase CLI
- Unity 6.x (for game development)
- Git LFS

## Default Environment

All local commands default to **development**. See [environment_guide.md](./environment_guide.md).
