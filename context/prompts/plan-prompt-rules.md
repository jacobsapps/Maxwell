# Plan: Prompt Rules + Context Restructure

## Goal
- Rename documentation structure to `context/` with `sessions/` and `prompts/`.
- Update agent rules to describe new agent-session format and branching-first exception.
- Create a new agent-session entry for this work.

## Steps
1. Create a new branch for the work.
2. Move existing documentation into `context/` and rename subfolders: `prompt/` → `sessions/`, `spec/` → `prompts/`.
3. Update `AGENTS.md` to reflect the new folder names and agent-session requirements, including transcript + initial prompt.
4. Update internal doc references to the new paths.
5. Create the current session entry in `context/sessions/` and include transcript + initial prompt + plan summary.

## Verification
- Manual check that `context/` exists with `sessions/` and `prompts/`, and that `AGENTS.md` reflects the new rules.
