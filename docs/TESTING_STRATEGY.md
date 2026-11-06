# Universal POS — Automated Testing Strategy

## 1. Testing Pyramid Overview

```
       / \
      / E2E \       <-- Minimal, critical smoke flows across Flutter + Backend
     /-------\
    /  Integ  \     <-- Controller MockMvc, Testcontainers, SQLite Drift migration tests
   /-----------\
  /    Unit     \   <-- Domain Use Cases, BLoCs, Entities, Calculation Engines
 /---------------\
```

---

## 2. Backend Testing (Spring Boot)

### 2.1 Unit Tests (JUnit 5 + Mockito)
- Test isolated business logic in domain services and calculation engines (e.g., tax calculation, pricing rules, inventory ledger logic).
- No Spring application context loading; run fast in memory.

### 2.2 Integration Tests (Spring Web Slice & Testcontainers)
- `@WebMvcTest`: Test REST controllers, serialization, Bean Validation, and HTTP status code mappings.
- `@SpringBootTest` + `Testcontainers`: Run against an authentic containerized PostgreSQL instance. Validates Flyway migrations, JPA queries, and transactional boundaries.

---

## 3. Frontend Testing (Flutter)

### 3.1 Unit & BLoC Tests (`bloc_test`, `test`)
- Test BLoC state transitions given sequence of events.
- Test pure Dart domain entities, value objects, and repository parsing logic.

### 3.2 Widget Tests
- Verify UI component rendering, responsive breakpoints, loading skeletons, and error dialogs without requiring backend dependencies.

### 3.3 Offline & Outbox Tests
- Simulate database write, app restart, and background outbox sync dispatching.
- Verify idempotency headers on repeated sync attempts.
