# Gitignore Update Plan

## Goal
- Add a root `.gitignore` that ignores Xcode user state and other nonessential local artifacts.
- Stop tracking any currently committed user state files.

## Steps
1. Create `.gitignore` with Xcode/macOS and local build artifacts.
2. Remove tracked Xcode user state from git index (`git rm --cached`).
3. Confirm ignored status for the user state file.

## Verification (must be agreed before coding)
- `git status -sb` shows no tracked user state changes.
- `git check-ignore -v <path>` confirms the user state file is ignored.
