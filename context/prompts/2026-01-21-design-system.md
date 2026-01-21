U: Request lightbulb-themed design system with colors, components, gradients, and button styles.
A: Plan created; will confirm verification steps before implementing design system tokens/styles.
U: Remove plan- prefix from spec files; build-only verification; keep design system in a folder.
A: Renamed plan- spec files; updated references; will build for verification after design system changes.
U: Proceed with design system work now.
A: Implemented design system folder, tokens, components, and ran build verification.
U: Create gitignore, ignore Xcode user state, and handle other unnecessary files.
A: Added root .gitignore, removed tracked user state, verified ignore rules.

# Initial User Prompt
"I'd like you to create a simple design system we can use for this app. Think things like:
- colours
- common components that we might need
- gradients that might exist
- button styles potentially
- anything very slightly different to maybe default system components
Have a think about what would make sense for a lightbulb-themed app. Look at the colours that we've got in the lightbulb documentation and just go ahead and build a design system, reading the plan and understanding what we might need."

# Purpose / Decisions Summary
- Purpose: Define a lightbulb-themed design system for Maxwell based on documented CCT color swatches.
- Decisions: Verification is build-only; design system can live in a single folder (no namespace required).
- Decisions: Added root .gitignore; verification via git status and git check-ignore.

# Session Plan Summary
- See `context/spec/design-system.md` for planned steps and verification.
- See `context/spec/gitignore.md` for gitignore steps and verification.
