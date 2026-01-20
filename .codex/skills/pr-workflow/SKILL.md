---
name: pr-workflow
description: Commit, push, and update pull requests in this repo. Use when asked to commit changes, open/update a PR, or summarize what changed for a PR.
---

# PR Workflow (Maxwell)

## Overview
Use this skill to stage changes, create commits, push to the current branch, and update the existing pull request. Follow AGENTS.md git batching rules.

## Workflow

1) **Inspect scope**
- `git status -sb` to confirm branch and modified files.
- `git diff --stat` (and file-level diffs as needed) to ensure only intended changes are included.

2) **Select PR/branch**
- Prefer the current branch if it already has an open PR.
- If a PR number is provided, use it for updates.

3) **Prepare commit**
- Stage only relevant files; keep unrelated changes out of the commit.
- Do not amend unless explicitly requested.

4) **Batch git writes**
- Run `git add ... && git commit -m "..." && git push` in one command.
- If the user asked to "make/open a PR," treat that as permission to push.

5) **Update PR metadata**
- Use `gh pr edit <number> --title "..." --body "..."` to update title/body.
- Include a concise summary and testing notes.

6) **Report**
- Provide a short change summary and tests run.

## PR body template

Use this structure unless the repo has its own template:

```
## Summary
- ...

## Testing
- Not run (not requested)
```

## Guardrails

- Avoid committing unrelated files.
- Do not force-push.
- Do not amend unless requested.
- If the working tree contains unrelated changes, call them out before committing.
