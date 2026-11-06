# Universal POS — Product & Engineering Roadmap

## Phase 1: Foundation and Architecture (CURRENT)
- [x] Workspace inspection & baseline setup
- [x] Engineering documentation & Architecture Decision Records (ADRs)
- [ ] Infrastructure Docker Compose & environment templates
- [ ] Spring Boot 3.3+ backend scaffolding with Java 21 LTS & Maven Wrapper
- [ ] Flyway baseline migration
- [ ] Backend Health and Diagnostics API (`/api/v1/health`)
- [ ] Backend automated unit & integration test harness
- [ ] Flutter packages (`packages/core`, `packages/design_system`)
- [ ] Flutter POS application (`apps/pos_app`) with BLoC & GoRouter
- [ ] Flutter health diagnostic screen & Dio client integration
- [ ] GitHub Actions CI workflow

## Phase 2: Authentication and SaaS Multi-Tenancy
- [ ] Tenant, Organization, Branch, and Device registration
- [ ] JWT authentication with rotating refresh tokens
- [ ] RBAC (Roles & Permissions)
- [ ] Feature entitlement engine

## Phase 3: Core POS Billing
- [ ] Product catalog, variants, and barcode search
- [ ] Cart management, item discounts, and tax engine (GST/HST/VAT)
- [ ] Checkout workflow and order state machine
- [ ] Receipt layout generation & local sales history

## Phase 4: Offline Engine & Outbox Sync
- [ ] Drift SQLite local database persistence
- [ ] Atomic Transactional Outbox pattern
- [ ] Background sync worker with exponential backoff
- [ ] Idempotency guarantee & conflict resolution

## Phase 5: Inventory Ledger
- [ ] Double-entry style auditable inventory movement ledger
- [ ] Suppliers, purchase orders, and goods receiving
- [ ] Low-stock alerts and physical stock reconciliation

## Phase 6: Payments and Hardware
- [ ] Cash drawer management & register open/close
- [ ] UPI dynamic QR payment & provider reconciliation
- [ ] Certified payment terminal integration
- [ ] ESC/POS thermal printer engine

## Phase 7: Industry Verticals (F&B / Grocery / Retail)
- [ ] Restaurant table management, KDS, modifiers & split bills
- [ ] Grocery weigh-scale and fast barcode multi-scanning

## Phases 8 - 12: CRM, Reporting, Enterprise & Ecosystem
- [ ] Customer loyalty & membership tiers
- [ ] Daily/Monthly sales, tax, gross profit, and X/Z reports
- [ ] Multi-branch consolidated inventory & warehouse transfers
- [ ] Performance profiling & hardened security audits
