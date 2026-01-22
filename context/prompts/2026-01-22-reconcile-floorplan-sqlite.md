Transcript:
user: Asked to reconcile floor plan UI demo with SQLite data model persistence.
assistant: Proposed plan to map UI state to SQLite, add update APIs, and test build/unit tests.
user: Approved plan, emphasized Factory DI for datastore services, asked about DTO separation.
assistant: Agreed to separate UI models from SQLite models with mapping, continued implementation.
user: Confirmed to continue.
assistant: Implemented SQLite-backed persistence with mapping and Factory DI; build and tests passed.

Initial User Prompt:
We've built a floor plan UI demo, and we've also got a SQLite data model that is going to be the data layer of our app. Can you please reconcile them so that the floor plan directly saves into the SQLite data model?

Purpose/Decisions:
- Purpose: persist the floor plan builder state into SQLiteData while keeping UI models separate.
- Decision: keep FloorPlan UI models as domain types and map to/from SQLite models in the view model.
- Decision: use Factory for datastore/service injection and default to in-memory database for previews.
- Decision: store one rectangle Shape per Room and persist bulb placements in room-local coordinates.

Session Plan Summary:
- Wire FloorPlanBuilderViewModel to a MaxwellDataStore service and load/save from SQLite.
- Add update APIs in the data store for renaming/reordering floors, room transforms, shapes, and bulb placements.
- Map floor plan UI geometry to SQLite shapes/placements with local/global coordinate conversion.
- Verify by building and running unit tests.
