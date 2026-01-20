---
name: xcodebuildmcp-verification
description: Verify Maxwell changes using XcodeBuildMCP (build/test/run on simulator). Use when asked to verify, build, test, or run the app via simulator.
---

# XcodeBuildMCP Verification (Maxwell)

## Overview
Use this skill to validate changes with XcodeBuildMCP. It mirrors the AGENTS.md verification sequence and uses a stable derived data path for speed.

## Preflight

- Ensure the MCP server is running: call `doctor` or `list_schemes`.
- Set session defaults once:
  - `projectPath`: `Maxwell.xcodeproj`
  - `scheme`: `Maxwell`
  - `simulatorId`: choose a valid iOS Simulator ID
  - `useLatestOS`: `true`

## Quick verification sequence

1) `boot_sim`
2) `build_sim` with `derivedDataPath: "/tmp/MaxwellDerivedData"`
3) `test_sim` with the same `derivedDataPath` and `extraArgs: ["-only-testing:MaxwellTests/MaxwellTests"]`
4) `get_sim_app_path` (platform `iOS Simulator`) -> `get_app_bundle_id`
5) `install_app_sim` -> `launch_app_sim` -> `describe_ui` and verify expected `AXLabel` values

## Reliability guidance

- If tests time out, run `build_sim` first and reuse the same derived data path.
- Prefer `-only-testing` for fast, deterministic unit tests.
- For error log validation, introduce a tiny compile error, run `build_sim`, capture the file/line, then immediately revert and rebuild.

## Report format

- Build/test status (pass/fail) with key log lines if available.
- Simulator used and derived data path.
- UI verification results (notable `AXLabel` checks).
