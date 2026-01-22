# Floor Plan Creator — Full Design Spec and Plan

## Goal
Deliver the full Floor Plan screen vision (control + construction modes) using iOS 26 Liquid Glass controls, with interactive placement of rooms and bulbs, spatial navigation, and collision feedback.

## Current Status (Prototype)
- Floor selector (left) and palette (right) exist as Liquid Glass panels and hide while placing.
- Freeform canvas supports pan/zoom/rotate (when not placing) and placement of rooms/bulbs.
- Rooms can be dragged after placement; bulbs can be dragged within rooms.
- Overlap detection exists (axis-aligned) with a gradient glow when overlapping during placement/drag.

## Design Vision (from sketch)
The Floor Plan screen has two modes:

### 1) Control Mode (controls visible)
- **Left: Floor selector**
  - Vertical list of floors.
  - “Add Above” at top (adds floor above highest floor).
  - “Add Below” at bottom (adds floor below lowest floor).
  - Tap a floor to select it and display its plan.
  - Long‑press a floor to rename (simple alert text field is acceptable).
- **Right: Palette**
  - Palette contains **Room** and **Light** (bulb) items.
  - Users drag from palette to place items on the floor plan.
- **Bottom: Tab bar**
  - Existing app tabs remain visible.

### 2) Construction Mode (controls hidden)
- When a user begins placing or manipulating a room/bulb, the left and right controls animate off screen.
- Controls return when the interaction ends (drop/cancel).

## Interaction Requirements
- **Pan**: one‑finger drag to move the view around the plan.
- **Pinch**: zoom in/out of the plan.
- **Rotate**: two‑finger rotation rotates the plan.
- **Drag**: move existing rooms or bulbs.
- **Scale/resize**: while holding a room from the palette, pinch to change size.
- **Rotate while placing**: while holding a room from the palette, rotate it.

## Placement Rules
- **Rooms**
  - Drag from palette to place.
  - If overlapping with another room, placement is blocked.
  - While overlapping, show a gradient glow around the room edges.
- **Bulbs**
  - Drag from palette to place.
  - Bulbs must be dropped **onto an existing room**.
  - If not over a room, placement is blocked.

## Collision/Overlap Feedback
- Rooms glow with a gradient stroke while overlapping or touching another room.
- Collision detection should eventually consider rotation (current prototype is axis‑aligned only).

## Visual Design (Liquid Glass)
- All controls use iOS 26 Liquid Glass:
  - Floor selector panel and palette panel are glass surfaces.
  - Buttons use `.buttonStyle(.glass)` (or `.glassProminent` where needed).
- Controls are visually consistent and grouped using `GlassEffectContainer`.
- Panels animate offscreen while in construction mode and return afterward.

## Data Model (V1)
- Floors: list with name + id.
- Rooms: rectangles only (center, size, rotation).
- Bulbs: point within room + id + room reference.

## Testing/Verification (agreed)
- Build only: `build_sim` using XcodeBuildMCP with `derivedDataPath: "/tmp/MaxwellDerivedData"`.
- Simulator run: `boot_sim`, `install_app_sim`, `launch_app_sim`, `describe_ui` to confirm interaction.

## Open Items / Next Steps (to complete full vision)
1) **Room interaction completeness**
   - Add rotate + resize gestures for already‑placed rooms (not just during placement).
   - Update collision detection to account for rotated rectangles.
2) **Bulb placement UX**
   - Show a target highlight when hovering over a room.
   - Snap bulbs to room center or a subtle grid on drop.
3) **Construction mode polish**
   - Animate control panels offscreen on drag start and back on drop.
   - Ensure controls are fully non‑interactive while hidden.
4) **Canvas interaction quality**
   - Add inertial panning or easing (optional).
   - Clamp extreme zoom levels.
5) **Floor selector UX**
   - Enforce a minimum of one floor.
   - Visual distinction between floors (subtle numbering/order indicator).
6) **Accessibility + feedback**
   - Add accessibility identifiers to key controls.
   - Provide haptic feedback on successful placement and blocked overlap.
7) **Tests**
   - Unit tests for overlap detection (including rotation), floor insertion order, bulb placement rules.

## Definition of Done
- Control mode and construction mode behave as described.
- Liquid Glass controls match the design language.
- Rooms and bulbs can be placed and manipulated without overlap bugs.
- Collision glow appears on overlap and prevents invalid placement.
- Floor selection and renaming work as specified.

