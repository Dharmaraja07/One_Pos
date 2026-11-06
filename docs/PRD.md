# Universal POS — Product Requirements Document (PRD)

## 1. Executive Summary
**Universal POS** is a modern, enterprise-grade, offline-first, multi-tenant SaaS Point of Sale platform. It is engineered to serve businesses spanning single-terminal mom-and-pop stores, grocery shops, and retail chains to multi-course restaurants, hotels, and enterprise franchises with hundreds of branches.

Instead of developing fragmented applications for different verticals or business tiers, Universal POS employs a single unified code engine powered by a **configurable feature-entitlement system** and dynamic modular presentation.

---

## 2. Target Market & Personas

### 2.1 Initial & Future Geography
- **Primary Market:** India (deep localization: INR currency, GST structure CGST/SGST/IGST, HSN/SAC codes, UPI dynamic QR payments, Indian fiscal formats).
- **Secondary / Expansion:** Global multi-currency, multi-jurisdiction tax configurations.

### 2.2 Target Business Segments
1. **Micro & Small Retail:** Quick billing, minimal clicks, barcode scanning, basic cash/UPI checkout.
2. **Supermarkets & Grocery:** High-speed barcode scanning, weigh-scale integration, batch/expiry tracking, low-stock triggers.
3. **Food & Beverage (F&B):** Table layouts, KDS (Kitchen Display System), KOT (Kitchen Order Tickets), split bills, modifiers, tips.
4. **Services & Salons:** Appointments, staff commissions, service billing.
5. **Enterprise Multi-Branch:** Centralized catalog, inter-branch stock transfers, consolidated audit logs, warehouse management.

### 2.3 User Personas
- **Cashier / POS Operator:** Needs lightning-fast order entry, keyboard shortcuts, offline resilience, and zero friction during payment.
- **Store Manager:** Manages cash drawers, shifts, stock adjustments, end-of-day X/Z reports, and refunds.
- **Enterprise Executive / Owner:** Requires aggregated real-time sales reporting, multi-branch comparisons, and role-based access control.
- **System Administrator:** Configures organization settings, feature entitlements, device pairing, and integration keys.

---

## 3. Core Functional Requirements

### 3.1 Authentication & Multi-Tenancy
- Hierarchical tenancy model: `Tenant` -> `Organization` -> `Branch` -> `Device`.
- Role-Based Access Control (RBAC) with fine-grained branch-level permissions.
- Secure terminal/device registration with cryptographic device tokens.
- Entitlement checks at both API and client presentation levels.

### 3.2 Offline-First Transaction Processing
- Complete standalone checkout capability without active network connectivity.
- Guaranteed local persistence of completed transactions using SQLite + Drift.
- Transactional Outbox pattern for queueing synchronization events.
- Deterministic conflict resolution (no blind last-write-wins for financial or stock balances).
- Idempotent API sync endpoints preventing duplicate billing or charges.

### 3.3 Core Billing & Catalog
- Unified catalog supporting standard products, variants, barcode aliases, and composite items.
- Dynamic tax engine supporting inclusive/exclusive taxes, compound GST rules, and exemptions.
- Order holding, bill splitting, customer association, discounts (item and cart level).
- Multi-tender payments (Cash, UPI, Cards, Store Credit).

---

## 4. Non-Functional Requirements

### 4.1 Reliability & Resilience
- **Offline Availability:** 100% uptime for local checkout on registered devices.
- **Zero Financial Loss:** Every locally confirmed checkout is committed to persistent storage before receipt emission and queued for outbox sync.
- **Crash Recovery:** Unfinished carts and transactional outbox queues survive app crashes and OS reboots.

### 4.2 Performance
- **Local Transaction Completion:** < 150 ms from payment confirmation to receipt print trigger.
- **Barcode Lookup:** < 50 ms for catalogs with 50,000+ local SKUs.
- **Server API Latency:** p95 < 120 ms for authenticated tenant API requests.

### 4.3 Security & Compliance
- Zero raw credit/debit card or CVV storage.
- Passwords hashed using BCrypt / Argon2 with salt.
- Short-lived JWT access tokens accompanied by rotating refresh tokens.
- Complete tenant data isolation enforced on the server; client tenant claims are never trusted blindly.
- Immutable audit log for sensitive actions (price overrides, discounts, refunds, register open/close).

---

## 5. Phased Roadmap Summary
- **Phase 1:** Foundation & Architecture (Monorepo, Spring Boot & Flutter scaffolding, Flyway, Docker, CI/CD).
- **Phase 2:** Authentication, Tenancy & Entitlements.
- **Phase 3:** Core POS Billing & Local Catalog.
- **Phase 4:** Offline Engine, Outbox & Background Sync.
- **Phase 5:** Inventory Movement Ledger & Stock Management.
- **Phase 6:** Payments & Certified Hardware Integration.
- **Phase 7:** Industry Verticals (F&B / Restaurant, Grocery, Retail).
- **Phase 8-12:** CRM, Advanced Reporting, Enterprise Multi-Branch, AI Ecosystem.
