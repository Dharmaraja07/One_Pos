# Universal POS — Developer Setup & Contribution Guide

## 1. System Requirements
- **Operating System:** macOS, Linux, or Windows (WSL2 recommended for Windows).
- **Java:** Java 21 LTS (e.g., Eclipse Adoptium Temurin 21).
- **Flutter:** Flutter 3.24+ (Dart 3.5+).
- **Docker:** Docker Desktop, Colima, or OrbStack with Docker Compose.
- **Git:** Git 2.38+.

---

## 2. Repository Layout & Conventions
The codebase is a monorepo organized into:
- `apps/`: Customer-facing apps (e.g., `pos_app`).
- `packages/`: Reusable multi-platform packages (`core`, `design_system`, `networking`, `local_database`).
- `backend/`: Spring Boot modular monolith (`universal-pos-core`).
- `infrastructure/`: Docker Compose configurations and environment definitions.
- `docs/`: Architecture documentation, ADRs, and guides.

---

## 3. Getting Started Locally

### 3.1 Start Database Infrastructure
```bash
cd infrastructure/docker
docker compose up -d
```
PostgreSQL will be running on `localhost:5432` with database `universalpos`.

### 3.2 Run Backend (Spring Boot)
```bash
cd backend/universal-pos-core
./mvnw clean spring-boot:run
```
The API starts on `http://localhost:8080`.
Verify backend health:
```bash
curl http://localhost:8080/api/v1/health
```

### 3.3 Run Flutter POS Client
```bash
cd apps/pos_app
flutter pub get
flutter run -d chrome # or macos / windows / android
```

---

## 4. Engineering Standards & Code Hygiene
- **Commit Messages:** Follow Conventional Commits format: `feat(catalog): add SKU barcode lookup endpoint`, `fix(pos): resolve cart roundoff error`.
- **Formatting:** Respect [`.editorconfig`](file:///Users/dharma/MY%20Projects/MYPOS/.editorconfig). Run `dart format .` for Flutter and `./mvnw spotless:check` or standard IDE format for Java.
- **Testing:** Do not merge code without accompanying unit and integration tests.
