User: Asked for TODOs in repo.
Assistant: Listed current TODOs.
User: Requested long-press bulb menu with fitting/color submenus, toggle, and inheritance.
Assistant: Asked clarifications and proposed plan + verification.
User: Specified sizes/colors, dim broken, use most recent, proceed.
Assistant: Re-reviewed plan, requested verification confirmation.
User: Approved, no heavy migration, build and PR.
User: Asked to save detailed plan/context due to context limit.
Assistant: Saved plan/context and confirmed.
User: Asked to pull latest main and build plan.
Assistant: Pulled main, switched branch, implemented, and verified.

# Initial User Prompt
Are there any TODOs that need doing?

# Purpose and Decisions
- Add bulb config fields: fitting size, color option id, createdAt; keep working status and dim broken bulbs in UI.
- Use specific fitting sizes from a shared catalog with SVG asset icons; default fitting size GU10.
- Use a simplified color list: Warm 2700K, Neutral 4000K, Cool 5000K; store colorId and map to swatches.
- New bulbs inherit fitting + color from the most recently added bulb in the same room; working status defaults to true.
- Minimal migration only: add columns with defaults via a new migration (no backfill scripts).
- Build and run floor plan view model unit tests; create PR when done.

# Key Context (Files + Notes)
- Branch for work: `feature-bulb-longpress-menu-2`.
- Bulb model: `Maxwell/Data/Models/Bulb.swift`.
- DB schema/migrations: `Maxwell/Data/Store/AppDatabase.swift`.
- Data store: `Maxwell/Data/Store/MaxwellDataStore.swift`.
- Floor plan view model: `Maxwell/Models/FloorPlanBuilderViewModel.swift`.
- Floor plan bulb UI: `Maxwell/Feature/FloorPlan/Canvas/FloorPlanBulbView.swift`.
- Placement preview: `Maxwell/Feature/FloorPlan/Canvas/FloorPlanPlacementView.swift`.
- Bulb fitting catalog: `Maxwell/Feature/BulbGuide/Models/BulbFittingFamily.swift`.
- Color options: `Maxwell/Models/BulbColorOption.swift`.
- Bulb fitting SVG assets: `Maxwell/Assets.xcassets/*` (edison-screw, bayonet, bi-pin, gu10, g9-loop, g13-tube, r7s-linear, gx53, wedge).

# Session Plan Summary
- Update bulb model/store/migration for fittingSize, colorId, createdAt; add update methods.
- Extend floor plan state to load/store config, inherit from most recent room bulb, and expose update actions.
- Implement long-press context menu with fitting/color submenus and working/broken toggle; update bulb rendering color and placement preview.
- Verify: build/compile and run floor plan view model unit tests.
