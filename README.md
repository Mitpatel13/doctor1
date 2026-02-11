# 📘 Spark Dating — Project Documentation

## 🔥 Project Overview

**Spark Dating** contains:

- A **Flutter mobile app** (root folder)
- A **React + Vite admin panel** (`admin-panel/`)
- Firebase integration for Auth / Firestore / Storage

This repository is currently organized as a mono-repo so both projects can be developed together. A helper script is included to split and push both apps into two independent GitHub repositories.

## 🧠 Features & Functionalities

### 📱 Mobile App (Flutter)

- Phone auth and account flows
- Profile and doctor/discovery style listing screens
- Booking, slot, payment, review modules
- GetX-based state management

### 🖥 Admin Panel (React)

- Attractive gradient-based dashboard UI with metric cards
- Live Firestore analytics + refresh actions
- Users table with search + gender filter + refresh
- Firebase config wiring (`src/firebase.js`) with Spark project defaults

## 📂 Code Structure

```text
.
├── admin-panel/
│   ├── src/
│   │   ├── App.jsx
│   │   ├── firebase.js
│   │   └── pages/
│   ├── package.json
│   └── vite.config.js
├── lib/                    # Flutter mobile app source
├── android/ ios/ web/ ...  # Flutter platform targets
├── scripts/
│   └── create_and_push_spark_repos.sh
└── pubspec.yaml
```

## 🚀 Run Locally

### Mobile app

```bash
flutter pub get
flutter run
```

### Admin panel

```bash
cd admin-panel
npm install
npm run dev
```

The admin panel already includes Spark Firebase defaults. You can still override with env vars in deployment if needed (`VITE_FIREBASE_*`).


### Optional Firebase env overrides

- `VITE_FIREBASE_MEASUREMENT_ID`
- `VITE_FIREBASE_DATABASE_URL`

### Firestore fields expected by dashboard

- `users.lastActiveAt` (timestamp) for daily active users
- `matches.createdAt` (timestamp) for new matches today

## ⬆️ Create New Repos and Push (Mobile + Admin)

Use the included script:

```bash
GITHUB_USERNAME=<your-user> \
MOBILE_REPO=spark-dating-mobile \
ADMIN_REPO=spark-dating-admin \
./scripts/create_and_push_spark_repos.sh
```

Notes:

- If the target repos already exist on GitHub, the script pushes directly.
- If you want the script to create repos through GitHub CLI, install/auth `gh` and run with `USE_GH_CLI=true`.
- Output repositories are staged under `exported-repos/` before push.
- Use `SKIP_PUSH=true` to only export/init repos without pushing (good for dry run).


### Admin-only repo push

If you only want to publish admin code (no Flutter app), run:

```bash
GITHUB_USERNAME=<your-user> \
ADMIN_REPO=spark-dating-admin \
./scripts/create_and_push_admin_repo.sh
```

## 🧪 Useful Checks

```bash
flutter analyze
flutter test
cd admin-panel && npm run build
```
