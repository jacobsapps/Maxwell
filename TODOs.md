# To Do's

We need to execute this plan.

## Floor Plan Touch Bug Fix Plan
1) Fix coordinate transforms to account for rotation in touch→model mapping and drag translations.
2) Prevent canvas pan/zoom/rotate from competing with room/bulb drags using an explicit drag-in-progress state.
3) Update room containment/overlap checks to handle rotated rooms (oriented bounds).
4) Add a reset-view control to restore default zoom/rotation (and optionally offset), wiring shared transform state.
5) Add/extend unit tests for rotated-room containment and overlap behavior.

## Verification
- Build and compile.
- Run unit tests.
- Quick simulator run to confirm drag/placement and reset-view behavior.
