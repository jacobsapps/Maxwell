# Plan: Context Structure Update

## Goal
- Update agent rules to reflect branching-first, and new `context/prompts` + `context/spec` structure.
- Rename folders accordingly and update internal references.

## Steps
1. Rename `context/sessions` to `context/prompts` and move specs/plans into `context/spec`.
2. Update `AGENTS.md` to reflect the new folder names and filename rules.
3. Update references in existing docs to the new paths.
4. Update the current agent session entry to reflect these changes.

## Verification
- Manual check that `context/prompts/` contains only `YYYY-MM-DD-name` files and `context/spec/` contains specs/plans with updated paths.
