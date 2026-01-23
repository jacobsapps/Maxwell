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
User: Asked for screenshot; assistant added screenshot and PR update.
User: Requested tap instead of long press, status submenu, color icon shape.
Assistant: Switched menu to tap, added status submenu, kept color swatch icon; rebuilt/tests.

# Initial User Prompt
Are there any TODOs that need doing?

# Purpose and Decisions
- Add bulb config fields: fitting size, color option id, createdAt; keep working status and dim broken bulbs in UI.
- Use specific fitting sizes from a shared catalog with SVG asset icons; default fitting size GU10.
- Use a simplified color list: Warm 2700K, Neutral 4000K, Cool 5000K; store colorId and map to swatches.
- New bulbs inherit fitting + color from the most recently added bulb in the same room; working status defaults to true.
- Minimal migration only: add columns with defaults via a new migration (no backfill scripts).
- UI menu now opens on tap (Menu) instead of long-press; status is a submenu with Working/Broken choices.
- Build and run floor plan view model unit tests; PR includes UI screenshot.

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
- UI screenshot stored at `docs/screenshots/2026-01-23/bulb-longpress-menu.png` and linked in PR.

# Session Plan Summary
- Update bulb model/store/migration for fittingSize, colorId, createdAt; add update methods.
- Extend floor plan state to load/store config, inherit from most recent room bulb, and expose update actions.
- Implement tap-to-open menu with fitting/color submenus and status submenu; update bulb rendering color and placement preview.
- Verify: build/compile and run floor plan view model unit tests.
