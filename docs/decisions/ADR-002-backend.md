# ADR-002: Backend Architecture — Spring Boot 3 Modular Monolith

## Status
Accepted

## Context
Universal POS requires an enterprise-grade backend to serve as the authority for multi-tenant isolation, cross-branch synchronization, catalog pricing, and financial audits. Choosing microservices at this inception phase introduces unwarranted network overhead, distributed transaction complexity, and DevOps friction for a small engineering team.

## Decision
1. **Framework & Language:** Spring Boot 3.3+ on Java 21 LTS.
2. **Architecture:** Modular Monolith. Code is organized into strict bounded context packages (`identity`, `tenancy`, `catalog`, `orders`, `payments`, `inventory`, `synchronization`, `shared`).
3. **Module Boundaries:** Modules interact through public Java service contracts and internal application events. Cross-module database joins or direct repository queries across domain boundaries are forbidden.
4. **Data Access:** Spring Data JPA with Hibernate, backed by PostgreSQL.
5. **Security:** Spring Security 6 with stateless JWT authentication, tenant filtering, and RBAC authorization.

## Consequences
- **Positive:**
  - High developer velocity and single-deployment simplicity.
  - In-process transactions prevent distributed commit complexities.
  - Clear domain boundaries preserve an easy path to extract microservices in the future if scale warrants it.
- **Negative / Trade-offs:**
  - Must strictly enforce architectural discipline (e.g., using ArchUnit / Spring Modulith) to prevent boundary degradation.
