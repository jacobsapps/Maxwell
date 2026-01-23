user: Requested room name editing on floor plan with inline label that updates data.
assistant: Proposed plan covering model updates, UI edit field, summary changes, and verification.
user: Clarified room names exist in DB, requested label near room bottom, summary to show names, more tests.
assistant: Confirmed plan, noted model lacks name field, and asked for verification approval.
user: Approved changes and requested a PR when finished.

# Initial User Prompt
hello, I would like you to implement a feature that allows users to change the name of a room on a floor plan. The room's name should be changeable from the floor plan. The center of the room should have the name of the room on it in a simple UI label, and then if they tap the UI label, maybe it's a text field, because if they tap it, it should be able to let them change the name of it. This updates the data.

# Purpose / Decisions Summary
- Purpose: enable inline room naming on the floor plan and surface stored room names in Summary.
- Decisions: place the room label near the lower edge to avoid centered lights; commit edits on submit or focus loss.
- Verification: build and compile succeeded; unit tests not run (manual testing by requester).

# Session Plan Summary
- Add room names to the in-memory model and data store updates, plus view-model rename support.
- Update the floor plan room view with a lower-edge label and inline TextField editing.
- Update Summary to display room names and add unit tests.
- Verification: build and compile; run Maxwell unit tests.
