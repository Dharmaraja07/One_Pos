# ADR-003: Database Architecture — PostgreSQL with Flyway and UUIDv4

## Status
Accepted

## Context
A financial Point of Sale requires ACID transaction guarantees, exact decimal precision for money and taxes, resilience against network partitions, and strict multi-tenant data segregation.

## Decision
1. **RDBMS:** PostgreSQL 16+.
2. **Primary Keys:** UUIDv4 generated at creation time. This enables edge POS terminals to generate unique IDs offline for orders, payments, and stock movements without sequence collisions when syncing.
3. **Monetary Storage:** `NUMERIC(15, 4)` for unit prices, tax rates, and calculations; `NUMERIC(12, 2)` for final rounded tender amounts. Stored with an explicit `currency` column (`VARCHAR(3)`). Floating-point types (`FLOAT`, `DOUBLE`) are strictly disallowed for money.
4. **Time & Timezones:** UTC timestamps (`TIMESTAMPTZ`) throughout.
5. **Schema Migrations:** Managed exclusively by Flyway. Uncontrolled Hibernate `ddl-auto` is disabled in all non-test environments (`validate` mode).
6. **Multi-Tenancy:** Discriminator column `tenant_id` on all tenant-specific tables, enforced through application-level filters and optional PostgreSQL Row-Level Security (RLS).

## Consequences
- **Positive:**
  - Guaranteed consistency and financial precision.
  - Offline ID generation without centralized sequence bottleneck.
  - Verifiable and auditable schema progression via Flyway.
- **Negative / Trade-offs:**
  - UUIDv4 keys take 16 bytes vs 8-byte BIGINT and can cause B-tree fragmentation (mitigated with targeted indexing and high-capacity PostgreSQL storage).
