---
name: sqlite-data-usage
description: Guidance for working with Point-Free SQLiteData in Maxwell (data layer, repositories, and future CloudKit sync). Use when implementing or reviewing persistence, SQLiteData models, or Factory registrations that touch SQLiteData.
---

# SQLiteData Usage (Maxwell)

## Overview
Use this skill when implementing or reviewing Maxwell's persistence layer with Point-Free SQLiteData. It points to the authoritative sources and the repo-specific constraints for local-only persistence.

## Workflow
1. Confirm scope: SQLite local only; no CloudKit entitlements yet.
2. Read references: `references/sqlite-data-sources.md` for official sources to consult when web access is allowed.
3. Implement repository protocols and data models that keep UI code isolated from persistence details.
4. Document any sync assumptions so they can be revisited when CloudKit is enabled.

## Notes
- Keep guidance minimal until sources are reviewed; do not invent API details.
- If Factory registration patterns are needed, add official Factory sources to the references file when provided.
