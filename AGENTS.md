## Planning and verification requirements
- Handle any required git branching or switching first, before changing any files.
- Before any work begins in a new session, create a clear, unambiguous plan and document it in `context/spec/` as a Markdown file with an appropriate name.
- Do not create additional plan/spec files within the same session unless the user explicitly asks. Keep updates in the existing session prompt document instead.
- The plan must include explicit verification steps (build, unit tests, or simulator run) and those steps must be agreed in advance before any coding starts. If verification is obvious (e.g., a file move or rename), proceed without asking and run a basic build/compile step.
- When describing verification steps in docs or responses, use plain language (e.g., “build and compile”) rather than tool-specific phrasing like derived-data paths.
- Before any code is committed, pushed, or the task is considered done, execute the agreed verification steps and confirm the feature works as intended.
- Create a new agent session entry in `context/prompts/` for every session using the `YYYY-MM-DD-name` filename format (kebab-case after the date).
- Each agent session file must be updated throughout the session and include: a very terse transcript at the top (one ~15-word line per user/assistant message), the initial user prompt in full, a brief purpose/decisions summary, and the session plan summary.
- Store specifications, design documents, and standalone plans in `context/spec/`.

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

## Skills (use when relevant)
- `.codex/skills/xcodebuildmcp-verification` for build/test/run verification via XcodeBuildMCP.
- `.codex/skills/pr-workflow` for commit/push/PR updates and change summaries.
- `.codex/skills/swift-concurrency-expert` for Swift concurrency review/remediation.
- `.codex/skills/swiftui-ui-patterns` for SwiftUI layout/component patterns.
- `.codex/skills/swiftui-view-refactor` for SwiftUI view cleanup and structure.
- `.codex/skills/swiftui-performance-audit` for SwiftUI performance diagnosis guidance.
- `.codex/skills/swiftui-liquid-glass` for iOS 26+ Liquid Glass usage.
- `.codex/skills/sqlite-data-usage` for SQLiteData persistence guidance and references.

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

## PR workflow skill
- Use `.codex/skills/pr-workflow` for commit/push/PR updates and change summaries.

# Agent guide for Swift and SwiftUI

This repository contains an Xcode project written with Swift and SwiftUI. Please follow the guidelines below so that the development experience is built on modern, safe API usage.

## Architecture (Maxwell)
- Three tabs: Floor Plan (builder, B1 focus), Interactive Floor Plan, Summary.
- V1 floor plan editor: rectangles only; expand later to custom/merged shapes.
- Gestures: touch-to-join squares, long-press to add bulbs, drag to move.
- Prefer default SwiftUI components where possible.
- MVVM with `@Observable` view models and a shared data source.
- Factory for DI; PointFree SQLite for local persistence.
- CloudKit sync is deferred; no entitlements/configuration yet. Design the data layer so it can be added later.
- Main-actor constrained by default; any background work must use the `@concurrent` attribute on a function.

Example:
```swift
@concurrent
func loadBulbStates() async throws -> [BulbState] {
    // background work here
}
```

## Core instructions

- Target iOS 26.0 or later. (Yes, it definitely exists.)
- Swift 6.2 or later, using modern Swift concurrency.
- SwiftUI backed up by `@Observable` classes for shared data.
- Do not introduce third-party frameworks without asking first.
- Avoid UIKit unless requested.


## Swift instructions

- Assume strict Swift concurrency rules are being applied.
- The app is main-actor constrained by default; use the `@concurrent` attribute on a function for background work.
- Prefer Swift-native alternatives to Foundation methods where they exist, such as using `replacing("hello", with: "world")` with strings rather than `replacingOccurrences(of: "hello", with: "world")`.
- Prefer modern Foundation API, for example `URL.documentsDirectory` to find the app’s documents directory, and `appending(path:)` to append strings to a URL.
- Never use C-style number formatting such as `Text(String(format: "%.2f", abs(myNumber)))`; always use `Text(abs(change), format: .number.precision(.fractionLength(2)))` instead.
- Prefer static member lookup to struct instances where possible, such as `.circle` rather than `Circle()`, and `.borderedProminent` rather than `BorderedProminentButtonStyle()`.
- Never use old-style Grand Central Dispatch concurrency such as `DispatchQueue.main.async()`. If behavior like this is needed, always use modern Swift concurrency.
- Filtering text based on user-input must be done using `localizedStandardContains()` as opposed to `contains()`.
- Avoid force unwraps and force `try` unless it is unrecoverable.


## SwiftUI instructions

- Always use `foregroundStyle()` instead of `foregroundColor()`.
- Always use `clipShape(.rect(cornerRadius:))` instead of `cornerRadius()`.
- Always use the `Tab` API instead of `tabItem()`.
- Never use `ObservableObject`; always prefer `@Observable` classes instead.
- Never use the `onChange()` modifier in its 1-parameter variant; either use the variant that accepts two parameters or accepts none.
- Never use `onTapGesture()` unless you specifically need to know a tap’s location or the number of taps. All other usages should use `Button`.
- Never use `Task.sleep(nanoseconds:)`; always use `Task.sleep(for:)` instead.
- Never use `UIScreen.main.bounds` to read the size of the available space.
- Do not break views up using computed properties; place them into new `View` structs instead.
- Do not force specific font sizes; prefer using Dynamic Type instead.
- Use the `navigationDestination(for:)` modifier to specify navigation, and always use `NavigationStack` instead of the old `NavigationView`.
- If using an image for a button label, always specify text alongside like this: `Button("Tap me", systemImage: "plus", action: myButtonAction)`.
- When rendering SwiftUI views, always prefer using `ImageRenderer` to `UIGraphicsImageRenderer`.
- Don’t apply the `fontWeight()` modifier unless there is good reason. If you want to make some text bold, always use `bold()` instead of `fontWeight(.bold)`.
- Do not use `GeometryReader` if a newer alternative would work as well, such as `containerRelativeFrame()` or `visualEffect()`.
- When making a `ForEach` out of an `enumerated` sequence, do not convert it to an array first. So, prefer `ForEach(x.enumerated(), id: \.element.id)` instead of `ForEach(Array(x.enumerated()), id: \.element.id)`.
- When hiding scroll view indicators, use the `.scrollIndicators(.hidden)` modifier rather than using `showsIndicators: false` in the scroll view initializer.
- Place view logic into view models or similar, so it can be tested.
- Avoid `AnyView` unless it is absolutely required.
- Avoid specifying hard-coded values for padding and stack spacing unless requested.
- Avoid using UIKit colors in SwiftUI code.


## SwiftData instructions

If SwiftData is configured to use CloudKit:

- Never use `@Attribute(.unique)`.
- Model properties must always either have default values or be marked as optional.
- All relationships must be marked optional.


## Project structure

- Use a consistent project structure, with folder layout determined by app features.
- Never use spaces in folder names.
- Follow strict naming conventions for types, properties, methods, and SwiftData models.
- Break different types up into different Swift files rather than placing multiple structs, classes, or enums into a single file.
- Write unit tests for core application logic.
- Only write UI tests if unit tests are not possible.
- Add code comments and documentation comments as needed.
- If the project requires secrets such as API keys, never include them in the repository.


## PR instructions

- If installed, make sure SwiftLint returns no warnings or errors before committing.
