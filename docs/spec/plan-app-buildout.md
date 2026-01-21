# Maxwell App Buildout Plan

## Goals
- Build a three-tab SwiftUI app for managing home light bulbs with a shared data source.
- Support floor plan creation, interactive placement, and a summary view (guide later).
- Use MVVM with `@Observable` view models, DI via Factory, and local persistence via PointFree SQLite (CloudKit sync deferred).

## Non-Goals (for now)
- Advanced automation rules or schedules.
- Third-party integrations beyond the existing libraries.

## Assumptions
- iOS 26+ target, Swift 6.2, strict concurrency.
- Factory DI and PointFree SQLite are already integrated.
- CloudKit configuration and entitlements are **not** set up yet.
- The app is main-actor constrained by default; any background work must be annotated with `@concurrent`.

## Architecture Overview
- **Models**: Room, Floor, Bulb, BulbState, ShapeNode (floor plan geometry), Placement.
- **Persistence**: SQLite for local storage; design for future CloudKit sync but do not assume it exists yet.
- **View Models**: `@Observable` types per feature, with shared data source.
- **Navigation**: `TabView` using the `Tab` API; `NavigationStack` within tabs.
- **Concurrency**: Default main actor; use the `@concurrent` attribute on a function only when explicitly doing background work.

Example:
```swift
@concurrent
func loadBulbStates() async throws -> [BulbState] {
    // background work here
}
```

## Data Model Draft
- Floor: id, name, order, optional image/geometry.
- Room: id, floorId, name, polygon/shape, order.
- Bulb: id, roomId, name, type, state, colorTemp, brightness, lastUpdated.
- Placement: id, floorId, bulbId, position (x,y), orientation, shape.
- BulbTypeGuide: id, name, description, capabilities.

## Feature Plan (High-Level)
1. **Core data layer**
   - Define SwiftData/SQLite models and relationships (optional where required).
   - CRUD operations and sync strategy.
   - Sample data seeding for previews/tests.
2. **Shared data source + DI**
   - Repository layer with protocols.
   - Factory registrations for repositories and view models.
3. **Tab 1: Floor Plan (builder)**
   - Floor selector.
   - Geometry editor for rooms/floors (rectangles only for V1).
   - Simple interactions: touch to join adjacent squares.
4. **Tab 2: Interactive Floor Plan**
   - Place bulbs on floor plan.
   - Long-press to add bulbs; drag to move them.
   - Toggle state, adjust brightness, see live state.
5. **Tab 3: Summary**
   - Summary list grouped by room with bulbs and state (guide deferred).
6. **Testing**
   - Unit tests for repository + view model logic.
   - UI tests only where unit tests are insufficient.

## Milestones
- M1: Data model + repository + DI wired; basic UI skeleton with tabs.
- M2: Floor plan builder + storage of geometry (rectangles + join).
- M3: Interactive placement + state updates.
- M4: Summary view (guide deferred).
- M5: Polish + tests + performance pass.

## Verification Steps (must be agreed before coding)
- Use XcodeBuildMCP sequence:
  1) `session-set-defaults` with `projectPath`, `scheme`, `simulatorId`, `useLatestOS`.
  2) `boot_sim`.
  3) `build_sim` with `derivedDataPath: "/tmp/MaxwellDerivedData"`.
  4) `test_sim` with `derivedDataPath: "/tmp/MaxwellDerivedData"` and `extraArgs: ["-only-testing:MaxwellTests/MaxwellTests"]`.
  5) `get_sim_app_path` (platform `iOS Simulator`) → `get_app_bundle_id`.
  6) `install_app_sim` → `launch_app_sim` → `describe_ui` and confirm expected `AXLabel` values.

## Decisions Captured
- Tabs: Floor Plan (builder, B1 focus), Interactive Floor Plan, Summary.
- V1 floor plan editor: rectangles only; expand later to custom/merged shapes.
- Gestures: touch-to-join squares, long-press to add bulbs, drag to move.
- Prefer default SwiftUI components where possible.
- Sync deferred until after main app buildout; design data layer to allow it later.
