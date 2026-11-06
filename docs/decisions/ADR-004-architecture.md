# ADR-004: Offline-First Transaction Engine with Outbox Pattern

## Status
Accepted

## Context
Retail, grocery, and restaurant environments often experience intermittent or severed internet connections. Cashiers must never be prevented from issuing bills or processing sales due to network latency or outage.

## Decision
1. **Local-First Writes:** Checkout operations execute and commit to a local SQLite database on the edge terminal first.
2. **Transactional Outbox:** The local database transaction saves order line items, payments, and an event in the local `outbox_events` table in a single atomic database transaction.
3. **Receipt Emission:** The physical/digital receipt is emitted immediately upon local commit.
4. **Asynchronous Background Synchronization:** A background synchronization worker polls the local outbox, pushes batches of events to the backend sync API with `X-Idempotency-Key`, and marks them synced upon server acknowledgment.
5. **Conflict Resolution Policy:**
   - Completed financial transactions are immutable and monotonic (additive).
   - Server validates tenant rules, records financial ledger entries, and acknowledges receipt.
   - Inventory adjustments are recorded as movements, never naive last-write-wins balance overwrites.

## Consequences
- **Positive:**
  - Zero cashier downtime during internet outages.
  - Sub-second checkout performance independent of network latency.
  - At-least-once synchronization delivery guaranteed by outbox persistence.
- **Negative / Trade-offs:**
  - Requires robust idempotency and background sync orchestration on the client.
