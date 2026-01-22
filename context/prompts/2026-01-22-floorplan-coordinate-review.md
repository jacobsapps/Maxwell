user: Asked for careful review of coordinate and gesture handling; requested simplification and improvements.
assistant: Planned coordinate-space refactor and verification steps for gesture reliability.
user: Told us to create a new branch and implement fixes to improve reliability.
assistant: Centralized metrics/coordinate space, updated palette drag, ran build/tests; launch aborted by user.
user: Ordered immediate push and PR with no further changes.

# Initial User Prompt
do a really careful review of the whole coordinate approach. Pull down the latest main (by the way, because I've already merged in your latest PR). Make a new branch. Please carefully review the way we're doing any kind of coordinate work and gesture handling, and make improvements as you see fit. The more you can simplify and coalesce everything together, the better

# Purpose / Decisions Summary
- Purpose: simplify and stabilize coordinate and gesture handling for the floor plan.
- Decisions: centralize the canvas coordinate space at a common ancestor and pass shared metrics directly to both canvas and overlay.

# Session Plan Summary
- Move the named coordinate space to the common ancestor (builder) and reuse a single constant.
- Replace preference-based canvas metrics with a single GeometryReader and pass metrics through.
- Update palette drag to use the shared coordinate space and keep placement transforms consistent.
- Verification: build and compile, run unit tests, and launch simulator to validate gesture behavior.
