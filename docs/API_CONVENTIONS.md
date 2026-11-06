# Universal POS — API Conventions & Standards

## 1. Protocol & URL Structure
- **Protocol:** HTTPS only in non-local environments.
- **Versioning:** URL path versioning: `/api/v1/{module}/{resource}`.
- **Content Type:** `application/json; charset=utf-8`.

---

## 2. Standard Request & Response Structure

### 2.1 Success Envelope
All successful responses conform to the standard `ApiResponse<T>` envelope:

```json
{
  "success": true,
  "data": { ... },
  "message": "Operation completed successfully",
  "timestamp": "2026-11-06T05:32:00Z"
}
```

For paginated resources:
```json
{
  "success": true,
  "data": [ ... ],
  "pagination": {
    "page": 0,
    "size": 20,
    "totalElements": 150,
    "totalPages": 8,
    "isLast": false
  },
  "timestamp": "2026-11-06T05:32:00Z"
}
```

### 2.2 Error Envelope
Errors conform to RFC 7807 (Problem Details) semantics:

```json
{
  "success": false,
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "The requested entity was not found",
    "details": [
      {
        "field": "productId",
        "message": "Product with ID 8a9134... does not exist"
      }
    ]
  },
  "timestamp": "2026-11-06T05:32:00Z"
}
```

---

## 3. Standard HTTP Status Codes
- `200 OK`: Successful GET, PUT, or POST action that returns data.
- `201 Created`: Successful resource creation (includes `Location` header where applicable).
- `204 No Content`: Successful request with no body to return (e.g., DELETE).
- `400 Bad Request`: Validation failure, ill-formed JSON body, or business rule violation.
- `401 Unauthorized`: Missing or invalid JWT authentication token.
- `403 Forbidden`: Authenticated user lacks permission or attempted cross-tenant access.
- `404 Not Found`: Resource does not exist or belongs to another tenant.
- `409 Conflict`: Resource state conflict (e.g., duplicate barcode, optimistic lock failure).
- `422 Unprocessable Entity`: Syntactically valid request that fails business domain validation.
- `500 Internal Server Error`: Unhandled server exception (sanitized in production, no stack traces leaked).

---

## 4. Idempotency & Offline Synchronization Headers
All offline sync operations and payment requests require an idempotency key:
- Header: `X-Idempotency-Key: <client-generated-uuid>`
- Header: `X-Device-Id: <client-registered-device-uuid>`
- Header: `X-Tenant-Id: <tenant-uuid>` (Validated against JWT claim)

If a request with an existing `X-Idempotency-Key` has already been processed, the backend returns the cached original result without re-executing business logic.
