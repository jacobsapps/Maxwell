# Maxwell Data Model

## Scope
Defines the data model for Maxwell's floor-plan-based light bulb management. This document focuses on entities, relationships, constraints, and behaviors needed for floor plan editing, room management, and bulb placement. No implementation details.

## Core Concepts (Glossary)
- Floor Plan: A collection of floors belonging to a single home/project.
- Floor: A named level (e.g., Basement, Ground, Floor 2).
- Room: A contiguous area composed of one or more shapes; rooms can be moved, rotated, or reshaped.
- Shape: A geometric primitive that composes a room (rectangles in V1; extensible later).
- Room Connection (Edge): The boundary adjacency between rooms, represented by a shared edge or explicit connection record.
- Bulb: A light source placed within a room; can be of multiple types and supports a simple working state.
- Placement: Spatial positioning of a bulb within a room, including orientation.
- Bulb Type Catalog: Externally provided list of bulb types (agent-maintained).

## Entities and Relationships

### Floor Plan
- Owns a collection of floors.
- Fields: id, name.

### Floor
- Belongs to a floor plan.
- Supports ordering and user-facing naming.
- Fields: id, floorPlanId, name, orderIndex.
- Behavior: users can add, remove, and reorder floors.

### Room
- Belongs to a floor.
- Composed of one or more shapes (one-to-many).
- Can be moved, rotated, and reshaped through gestures.
- Fields: id, floorId, name, orderIndex, transform (translation/rotation/scale).
- Constraint: a room's shapes must form a single contiguous area.
- Constraint: rooms may not overlap other rooms on the same floor.

### Shape
- Belongs to a room.
- Represents a geometric primitive and its local transform.
- V1 shape type: rectangle only, with future extensibility to other primitives and composite shapes.
- Fields: id, roomId, shapeType, size (width/height), localPosition (x/y), localRotation, localScale.
- Constraint: shapes in a room can be oriented and sized differently; contiguity across shapes defines the room.

### Room Connection (Edge)
- Represents adjacency between rooms via shared edges.
- Derived on demand from geometry; not stored.
- Purpose: enforce non-overlap and prevent dragging rooms into each other.

### Bulb
- Belongs to a room (bulbs cannot exist without a room in V1).
- References a bulb type from the external catalog.
- Supports a simple working state and optional failure timestamp.
- Fields: id, roomId, name, bulbTypeId, isWorking, markedNotWorkingAt.

### Bulb Placement
- Represents spatial placement of a bulb within a room.
- Fields: id, bulbId, roomId, position (x/y), orientation, attachedShapeId (optional).
- Constraint: placement must lie within the room boundary.

### Bulb Type Catalog (External)
- Maintained by separate agent/service.
- Local model stores a stable reference (bulbTypeId) and can cache display name/capabilities if needed for offline use.
- Bulb type properties to support app detail views:
  - Identity: id, name, manufacturer (optional), modelNumber (optional).
  - Technology: technologyType (incandescent, halogen, CFL, linear fluorescent, LED, HID, induction, OLED).
  - Form factor: fittingFamily, fittingSize, shapeCode.
  - Color: cctKelvin, cctLabel (warm/neutral/cool), cctHex (UI swatch).
  - Optics: beamAngleDegrees (optional), reflectorType (PAR/BR/MR, optional), diffusion (clear/frosted, optional).
  - Electrical: wattage, voltageRange (min/max), dimmable, driverType (LED, optional).
  - Performance: lumens, efficacyLumensPerWatt (optional), cri (optional), lifetimeHours, warmUpTimeSeconds (optional).
  - Compliance: certifications (UL/ETL/CE, optional), enclosureRating (optional), mercuryContentMg (CFL/fluorescent, optional).

## Geometry and Coordinate System
- Define a floor-level coordinate space.
- Each room has a stable local coordinate system that does not change when shapes are added or removed.
- Room transform (translation/rotation/scale) maps room-local coordinates into floor space.
- Shapes and bulb placements store room-local coordinates and do not change when the room moves/rotates/resizes.
- Coordinate units are consistent across the app (exact units are not user-facing).
- Freeform placement (no grid snapping in V1).

## Required Behaviors (Data-Level)
- Create/remove floors.
- Create/remove rooms on a floor.
- Create/modify shapes within a room; shapes can vary in orientation and size.
- Ensure room contiguity from connected shapes.
- Enforce non-overlap between rooms on the same floor.
- Move, rotate, and reshape rooms (room transform changes; shapes and bulb placements remain room-local).
- Add/remove bulbs in rooms.
- Move bulbs within rooms; placements remain valid within room bounds.
- Select rooms and floors for editing and placement.
- Summary tab lists rooms and bulbs without considering geometry.

## Constraints and Invariants
- Each room belongs to exactly one floor.
- A room's shapes must form a single contiguous area.
- Rooms do not overlap on the same floor.
- Bulbs must belong to exactly one room.
- Bulb placements must be inside the room boundary.
- Room connections must represent adjacency on the same floor.

## Derived vs Stored Data
- Room connections are derived from geometry and not stored.
