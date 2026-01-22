Transcript:
User: Request Summary tab list by floor with rooms and bulbs using design system.
Assistant: Proposed plan with verification, asked for confirmation.
User: Confirmed; requested simulator run and unit tests for new view model.
Assistant: Updated plan to include build, tests, and simulator run.
User: Approved and asked to continue.
Assistant: Implemented Summary list UI, added SummaryViewModel + tests, ran build/tests/simulator.
User: Asked to make a PR, add accessibility labels/identifiers, and update agent rules.
Assistant: Added tab accessibility identifiers/labels and updated AGENTS; will PR without verification per request.
User: Requested identifiers only, ContentUnavailableView empty state, and SwiftUI rule update.
Assistant: Updated Summary empty state and identifiers; rebuilt successfully.
User: Requested ContentUnavailableView overlay approach and PR update.
Assistant: Switched SummaryView to List overlay for empty state and will update PR.

Initial user prompt:
Hello! We have the ability to create floor plans and save them to a SQL-like data model in this app. What I'd like you to do is build out the second tab, the one with a summary, essentially showing a SwiftUI list with sections for each floor and which rooms exist and which light bulbs exist on each room. Please use standard system components and our design system in the work.

Purpose / Decisions Summary:
- Add a Summary tab list grouped by floor, showing rooms and bulbs, using design system components.
- Introduce a Summary view model helper with unit tests.
- Verify with build, unit tests, and simulator launch; UI automation stayed on non-summary tabs.
 - Add accessibility labels/identifiers for tab verification and update agent rules to prefer them.
 - Skip additional verification per user request to finish quickly.
 - Keep identifiers only, use ContentUnavailableView for empty states, and update SwiftUI guidance; build completed.
 - Use a List overlay ContentUnavailableView for empty summary state, then update PR.

Session Plan Summary:
- Review Summary tab and data model to shape the list structure.
- Implement Summary list UI plus view model helpers and unit tests.
- Verify by build and compile, run unit tests, and run on simulator.
