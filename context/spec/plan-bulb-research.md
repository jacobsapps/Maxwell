# Plan: Light Bulb Research Documentation

## Goal
Create comprehensive documentation for a light bulb management app covering bulb types, fittings, shapes, color temperatures (with hex swatches), and representative fitting images.

## Steps
1. Gather reputable web sources for bulb types, fittings, shapes, and color temperature ranges.
2. Draft a Markdown document summarizing bulb properties, types, and lookup tables for fittings/shapes/temperatures with descriptions and hex color guidance.
3. Create a local `context/assets/bulb-fittings/` image set (simple SVG icons) for common fitting styles.
4. Cross-check the documentation for completeness and consistency.

## Verification
- Run: `xcodebuild -list -project Maxwell.xcodeproj` to confirm build tooling availability and project visibility.
- Run: `xcodebuild -project Maxwell.xcodeproj -scheme Maxwell -destination 'platform=iOS Simulator,name=iPhone 15' build` to validate a successful build (or record the environment limitation if unavailable).
