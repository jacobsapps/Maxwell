# Agent Instructions

## Git batching (sandbox write limits)
- Run read-only git commands normally.
- Batch git write commands into one escalated command per PR workflow.
- Ask once, then run: branch/switch, add, commit (and any needed git config).
- Do not push unless explicitly requested.

## TODO
- Refactor this PR workflow into a skill.
