# Universal POS — Security Architecture & Guidelines

## 1. Authentication & Session Management
- **Token Strategy:** Short-lived JSON Web Tokens (JWT) signed with RSA-256 or HMAC-SHA256 (minimum 256-bit secret). Default expiration: 15 minutes.
- **Refresh Token Rotation:** Refresh tokens are single-use, stored securely, and automatically revoked upon reuse detection (anti-theft).
- **Password Security:** Salted BCrypt (work factor 12) or Argon2id for password storage. Strict entropy requirements (minimum 10 characters, upper, lower, digit, symbol).
- **Device Pairing:** Edge terminals must complete a one-time activation ceremony using an admin-generated pairing code to obtain an enterprise device certificate / token.

---

## 2. Multi-Tenant Authorization (Zero Trust)
- **Authoritative Identity:** Tenant IDs, Organization IDs, and User Permissions supplied in request bodies or query parameters are **NEVER** trusted.
- The server extracts tenant and user context strictly from validated cryptographic claims in the signed JWT token.
- Cross-tenant access attempts trigger security alerts and return generic `404 Not Found` or `403 Forbidden` responses.

---

## 3. Financial & Payment Security
- **PCI DSS Scope Reduction:** Universal POS will **never** store, transmit, or process raw credit/debit card numbers (PANs) or CVVs on application servers.
- Certified payment gateway SDKs and hardware pinpads tokenizing cards at the edge must be used exclusively.
- All payment transaction events reference external payment gateway transaction IDs and provider tokens for reconciliation.

---

## 4. Operational & Code Hygiene
- All sensitive environment configurations (database credentials, JWT signing keys, payment secrets) must be injected via environment variables or secret vaults.
- No secrets or credentials may ever be committed to Git.
- Detailed logs must mask personally identifiable information (PII), phone numbers, and authentication tokens.
- CORS policies must be tightly scoped to authorized tenant frontend origins.
