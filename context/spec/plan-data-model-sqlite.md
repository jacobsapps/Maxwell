# Plan: SQLiteData Data Model (Maxwell)

## Goal
Implement the initial SQLiteData-backed data model for floors, rooms, shapes, bulbs, and placements based on `context/spec/data-model.md`.

## Scope
- Define SQLiteData `@Table` models for core entities.
- Add database migrations for the new tables.
- Provide minimal repository or data access scaffolding for future use.
- Keep schema CloudKit-compatible (UUID primary keys, no unique constraints, no foreign keys).
- Do not persist hard-coded data (no bulb type cache tables yet).

## Steps
1. Inspect existing data layer, migrations, and dependency injection patterns.
2. Add new `@Table` models for FloorPlan, Floor, Room, Shape, Bulb, BulbPlacement, and optional BulbType cache.
3. Implement migrations to create the new tables.
4. Add repository or data access helpers as needed by current architecture.
5. Add unit tests for all data functionality implemented in this step.

## Verification (must run before completion)
- XcodeBuildMCP: build iOS Simulator target.
- XcodeBuildMCP: run unit tests for `MaxwellTests/MaxwellTests` (or the closest existing unit test target).

## Notes
- Do not enable CloudKit entitlements yet; keep schema compatible for future sync.
- Default to main-actor access; use `@concurrent` for background work only when necessary.
