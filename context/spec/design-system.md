# Design System Plan (Lightbulb Theme)

## Goals
- Define a lightbulb-themed design system for Maxwell (colors, gradients, components, button styles, and subtle customizations).
- Base color palette on the CCT (Kelvin) swatches from `context/spec/light-bulb-types.md`.
- Keep SwiftUI-first, iOS 26+, and app-wide reuse via a small set of tokens and styles.

## Scope
- **Design tokens**: Core colors, semantic colors, neutrals, and temperature accents (warm/neutral/cool).
- **Gradients**: A small set derived from bulb glow and glass/reflection ideas.
- **Components**: Buttons, cards/tiles, tags/chips, section headers, and text styles.
- **Implementation**: SwiftUI helpers (Color/Gradient extensions, `ButtonStyle`s, small reusable views).

## Proposed Implementation
1. Add a `DesignSystem` folder (Swift files) in `Maxwell/`.
2. Define `Color` tokens that map to the CCT swatches and a small neutral set.
3. Define `Gradient` tokens (e.g., warm glow, neutral glow, cool glow).
4. Create reusable component styles:
   - Primary + secondary button styles
   - Card/tile container style
   - Tag/chip style
   - Section header view
5. Optionally update `ContentView` to preview the system.

## Verification Steps (agreed)
- Use XcodeBuildMCP to run a simulator build:
  1) `session-set-defaults` with `projectPath`, `scheme`, `simulatorId`, `useLatestOS`.
  2) `boot_sim`.
  3) `build_sim` with `derivedDataPath: "/tmp/MaxwellDerivedData"`.

## Notes
- Avoid non-ASCII characters unless already present.
- Keep styles minimal and reusable; avoid heavy layout assumptions.
