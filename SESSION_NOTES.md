# Codex Notifications — Session Notes

## What I want
- When Codex finishes responding and is waiting on me, show a macOS notification.
- When Codex needs my approval/permissions, show a macOS notification.
- This should work in iTerm2.

## Current state (as of 2026-01-20)
- Official Codex notification hook is configured in `~/.codex/config.toml`.
- Custom notify script is installed at `~/.codex/notify.py`.
- ZSH prompt-hook and proxy-based attempts have been removed from `.zshrc` so Codex runs normally.

## Files changed
- `/Users/jacob/.codex/config.toml` — added `notify` hook and `[tui] notifications`.
- `/Users/jacob/.codex/notify.py` — new notification handler.
- `/Users/jacob/.zshrc` — removed previous `codex()` wrapper.
- `/Users/jacob/Writing/Maxwell/scripts/codex_notify_proxy.py` — earlier proxy experiment (no longer used).

## Official hook configuration (current)
Added near the top of `~/.codex/config.toml`:

```toml
notify = ["python3", "/Users/jacob/.codex/notify.py"]

[tui]
notifications = ["agent-turn-complete", "approval-requested"]
```

## Notify script behavior (`~/.codex/notify.py`)
- Expects a single JSON argument from Codex.
- For `approval-requested`: shows "Codex: approval needed".
- For `agent-turn-complete`: shows "Codex: your input" and includes the last assistant message (trimmed).
- Uses `terminal-notifier` if available and activates iTerm2 (`com.googlecode.iterm2`).
- Falls back to `osascript` if `terminal-notifier` is not installed.

## Things tried (chronological)
1) ZSH `preexec`/`precmd` hook to notify after commands matching `codex|claude`.
   - Issue: only fires when the process exits; Codex is interactive, so no notification while waiting.

2) Proxy-based PTY wrapper (`scripts/codex_notify_proxy.py`) to scan Codex output for prompts.
   - Added ANSI-stripping and debug logging to improve matching.
   - Still unreliable in practice; removed wrapper from `.zshrc`.

3) Official Codex hook via `notify` + `tui.notifications`.
   - This is the documented, supported approach and should fire when Codex finishes a turn or requests approval.

## iTerm2 / macOS notification caveats
- If no banners appear, check System Settings → Notifications for:
  - iTerm2 (terminal-notifier path) and
  - Script Editor / osascript (fallback path).
- Focus/Do Not Disturb can suppress alerts.

## Relevant sources
```text
https://developers.openai.com/codex/config-advanced
https://community.openai.com/t/feature-request-notifications-when-codex-is-done-with-a-task/1269665
https://kanman.de/en/posts/codex-desktop-notifications/
```

## Next steps to validate
- Restart Codex so it re-reads config.
- Quick test:
  - `python3 ~/.codex/notify.py '{"type":"agent-turn-complete","thread-id":"test","last-assistant-message":"Test notification"}'`
- If no notification shows, enable iTerm2 / Script Editor notifications in System Settings.
