---
name: rest-api-design
description: Apply REST API best practices when designing, reviewing, or changing endpoints. Use nouns, correct status codes, clear errors, and stable versioning.
---

# REST API design

Apply REST conventions before designing or changing any API.

This skill fires whenever the agent is about to design, add, modify, or review REST API endpoints. It keeps the API predictable and consistent.

## Read existing direction

If `API.md` exists at the project root, read it. If `CONTEXT.md` exists, read it so the API uses the project's domain language.

## Core practices

### Resources

- Name resources with nouns, plural for collections: `/users`, `/orders`, `/products`.
- Keep nesting shallow. Two levels is usually enough: `/users/123/orders`.
- Do not put verbs in paths. Use `/users/123` with `DELETE`, not `/deleteUser/123`.

### Endpoint patterns

| Endpoint | Method | Result |
| --- | --- | --- |
| `/users` | GET | list users |
| `/users` | QUERY | search users with a complex query body |
| `/users` | POST | create a user |
| `/users/123` | GET | read one user |
| `/users/123` | PUT | replace the user |
| `/users/123` | PATCH | update part of the user |
| `/users/123` | DELETE | remove the user |

Use this pattern consistently across every resource.

### HTTP methods

| Method | Use for |
| --- | --- |
| GET | read a resource or collection |
| QUERY | read a resource or collection using a complex query body (RFC 10008) |
| POST | create a new resource under a collection |
| PUT | full replacement of a resource |
| PATCH | partial update of a resource |
| DELETE | remove a resource |

Do not use GET for writes. Do not use POST for deletions or read-only queries that could be GET or QUERY.

#### QUERY (RFC 10008)

Use `QUERY` when the query is too large, too complex, or too sensitive to put in the URL:

- long filter or search expressions
- structured query languages (SQL, JSONPath, GraphQL-like queries)
- inputs that should not appear in logs or bookmarks

`QUERY` is safe and idempotent, so caches and retries can treat it like GET. It expects a request body with a matching `Content-Type`. Use `Accept-Query` to advertise supported query formats.

Reserve GET for short, simple queries.

### Status codes

- **200** for successful read or update.
- **201** for successful creation, with a `Location` header when it fits.
- **204** for successful deletion with no body.
- **400** for client errors the user can fix.
- **401** when authentication is required or failed.
- **403** when the caller is authenticated but not authorized.
- **404** when the resource does not exist.
- **409** for conflicts the caller can resolve.
- **500** for unexpected server errors only.

Do not return 200 with an error body.

### Errors

Return a consistent error object:

```json
{
  "error": "short_machine_readable_code",
  "message": "Human-readable explanation",
  "details": { ... }
}
```

- Be specific about what went wrong and how to fix it.
- Do not leak internal stack traces or secrets.

### Requests and responses

- Use ISO 8601 for dates.
- Prefer JSON. Use consistent field naming, usually `camelCase` or `snake_case` but never both.
- Accept and return stable identifiers, not auto-increment integers if the API is public.
- Support filtering, sorting, and pagination on collections. Use query parameters: `?status=open&sort=created_at&limit=20&offset=40`.

### Versioning

- Version the API in the URL (`/v1/users`) or header (`Accept: application/vnd.api.v1+json`).
- Do not break existing clients without a new version.

## If API.md exists

Apply its rules first. If the requested change contradicts `API.md`, tell the user and ask how to resolve it.

## If API.md is missing

Proceed with the practices above. If the API is large or the team needs a written direction, suggest creating `API.md` to capture the direction.
