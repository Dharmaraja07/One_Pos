# ADR-001: Frontend Architecture — Flutter with BLoC and Clean Architecture

## Status
Accepted

## Context
Universal POS must run across desktop (Windows, macOS), mobile/tablet (Android, iOS), and web browsers for administration. The application requires offline-first operation, high transaction speed at checkout, predictable state management, and clear decoupling between UI rendering and business logic.

## Decision
1. **Framework:** Flutter (Dart 3.5+) targeting multi-platform deployment from a single shared codebase.
2. **State Management:** BLoC / Cubit pattern (`flutter_bloc`). BLoC provides explicit event-driven transitions, immutability, and straightforward testability without coupling logic to Flutter widget lifecycles.
3. **Architecture:** Clean Architecture with Feature-First modularity:
   - `presentation`: UI widgets, BLoCs, routes.
   - `domain`: Pure Dart entities, use cases, repository contracts.
   - `data`: Repository implementations, Drift SQLite DAO, Dio API client.
4. **Navigation:** `go_router` for declarative routing and deep-linking.
5. **Local Persistence:** Drift with SQLite for high-performance offline querying and transactional outbox support.
6. **Networking:** `dio` with custom interceptors for authentication, tenant headers, and offline retry logic.

## Consequences
- **Positive:**
  - One unified codebase for all platforms.
  - Testable business logic isolated in the domain layer.
  - Predictable offline behavior with SQLite.
- **Negative / Trade-offs:**
  - Strict boilerplate discipline required for Clean Architecture and BLoC (offset by clear code structure and high reliability).
