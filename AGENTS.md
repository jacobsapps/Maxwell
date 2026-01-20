## Verification via XcodeBuildMCP
This repo ships an MCP config at `mcp.json` that defines the XcodeBuildMCP server (runs `npx -y xcodebuildmcp@latest`). To turn it on, make sure your MCP host loads this file and starts the server; then verify it is live by calling a lightweight tool like `list_schemes` or `doctor`.

Quick, repeatable verification sequence (use the same derived data path for speed):
1) `session-set-defaults` with `projectPath`, `scheme`, `simulatorId`, `useLatestOS`.
2) `boot_sim`.
3) `build_sim` with `derivedDataPath: "/tmp/MaxwellDerivedData"` (or any stable path).
4) `test_sim` with the same `derivedDataPath` and `extraArgs: ["-only-testing:MaxwellTests/MaxwellTests"]`.
5) `get_sim_app_path` (platform `iOS Simulator`) → `get_app_bundle_id`.
6) `install_app_sim` → `launch_app_sim` → `describe_ui` and confirm expected `AXLabel` values.

Build verification (normal build + error reading):
- Set session defaults once: `session-set-defaults` with `projectPath`, `scheme`, `simulatorId`, and `useLatestOS`.
- Boot a simulator: `boot_sim`.
- Run a normal build with a stable derived data path: `build_sim` + `derivedDataPath`.
- If you need to confirm error logs, intentionally introduce a small compile error, run `build_sim`, and read the tool output for the file/line and compiler message; then immediately revert the change and rebuild.

Test verification (unit tests):
- Prefer a fast, reliable run: `test_sim` with `derivedDataPath` and `-only-testing:Target/Tests` in `extraArgs`.
- If full-suite tests time out, prebuild first (`build_sim`) and keep the same derived data path to reuse cached outputs.

Run + UI verification (simulator):
- Build first: `build_sim` with `derivedDataPath`.
- Get the app path: `get_sim_app_path` (platform `iOS Simulator`), then `get_app_bundle_id`.
- Boot + install + launch: `boot_sim`, `install_app_sim`, then `launch_app_sim`.
- Verify UI elements via `describe_ui` and confirm expected `AXLabel` values (text or button labels).

# Agent Instructions

## Git batching (sandbox write limits)
- Run read-only git commands normally.
- Batch git write commands into one escalated command per PR workflow.
- When asked to "make a PR" or "open a PR," treat that as permission to push.
- Ask once, then run: branch/switch, add, commit, push (and any needed git config).

## XcodeBuildMCP tests
- XcodeBuildMCP tool calls can time out at 60s; for reliability, prebuild with build_sim and run tests with -only-testing (or keep a stable derivedDataPath) before attempting a full-suite test_sim.
- Quick snippet to avoid timeouts:
  - build_sim with a stable derivedDataPath
  - test_sim with -only-testing and the same derivedDataPath

## TODO
- Refactor this PR workflow into a skill.
