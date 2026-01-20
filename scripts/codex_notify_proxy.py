#!/usr/bin/env python3
import fcntl
import os
import pty
import re
import select
import signal
import struct
import subprocess
from typing import Optional
import sys
import termios
import tty

DEFAULT_REGEX = (
    r"(^|[\r\n])\s*(codex|assistant|you|user)\s*[:>]\s*$"
    r"|(^|[\r\n])\s*[>›]\s*$"
    r"|needs your input"
    r"|permission|approve|allow|proceed|confirm|requires your approval"
)
ANSI_RE = re.compile(r"\x1b\\[[0-9;?]*[ -/]*[@-~]")


def _notify(title: str, message: str) -> bool:
    if subprocess.call(["/usr/bin/osascript", "-e", f'display notification "{message}" with title "{title}"'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL) == 0:
        return True
    if shutil_which("terminal-notifier"):
        subprocess.call(["terminal-notifier", "-title", title, "-message", message], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    if shutil_which("notify-send"):
        subprocess.call(["notify-send", title, message], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        return True
    return False


def shutil_which(cmd: str) -> Optional[str]:
    for path in os.environ.get("PATH", "").split(os.pathsep):
        candidate = os.path.join(path, cmd)
        if os.path.isfile(candidate) and os.access(candidate, os.X_OK):
            return candidate
    return None


class PtyProxy:
    def __init__(self, argv: list[str]) -> None:
        self.argv = argv
        self.master_fd = -1
        self.child_pid = -1
        regex = os.environ.get("CODEX_NOTIFY_OUTPUT_REGEX", DEFAULT_REGEX)
        self.pattern = re.compile(regex, re.IGNORECASE)
        self.armed = True
        self.buffer = ""
        self.debug = bool(os.environ.get("CODEX_NOTIFY_DEBUG"))
        self.debug_log = os.environ.get("CODEX_NOTIFY_DEBUG_LOG", "/tmp/codex_notify.log")

    def _debug(self, message: str) -> None:
        if not self.debug:
            return
        try:
            with open(self.debug_log, "a", encoding="utf-8") as handle:
                handle.write(message.rstrip() + "\n")
        except OSError:
            pass

    def _set_winsize(self) -> None:
        if self.master_fd < 0:
            return
        try:
            winsize = fcntl.ioctl(sys.stdin.fileno(), termios.TIOCGWINSZ, b"\0" * 8)
            rows, cols, xp, yp = struct.unpack("HHHH", winsize)
            fcntl.ioctl(self.master_fd, termios.TIOCSWINSZ, struct.pack("HHHH", rows, cols, xp, yp))
        except OSError:
            pass

    def _on_winch(self, _signum, _frame) -> None:
        self._set_winsize()

    def run(self) -> int:
        self.child_pid, self.master_fd = pty.fork()
        if self.child_pid == 0:
            os.execvp(self.argv[0], self.argv)
            raise SystemExit(1)

        old_tty = termios.tcgetattr(sys.stdin)
        tty.setraw(sys.stdin.fileno())
        signal.signal(signal.SIGWINCH, self._on_winch)
        self._set_winsize()

        try:
            while True:
                rlist, _, _ = select.select([self.master_fd, sys.stdin], [], [])
                if self.master_fd in rlist:
                    try:
                        data = os.read(self.master_fd, 1024)
                    except OSError:
                        break
                    if not data:
                        break
                    os.write(sys.stdout.fileno(), data)
                    if self.armed:
                        chunk = data.decode(errors="ignore")
                        clean_chunk = ANSI_RE.sub("", chunk)
                        self.buffer += clean_chunk
                        if len(self.buffer) > 4096:
                            self.buffer = self.buffer[-4096:]
                        if self.pattern.search(self.buffer):
                            notified = _notify("Needs your input", "Codex is waiting")
                            self._debug(f"match: notified={notified} regex={self.pattern.pattern}")
                            self.armed = False
                            self.buffer = ""
                if sys.stdin in rlist:
                    data = os.read(sys.stdin.fileno(), 1024)
                    if not data:
                        try:
                            os.close(self.master_fd)
                        except OSError:
                            pass
                        break
                    os.write(self.master_fd, data)
                    self.armed = True
                    self.buffer = ""
                    self._debug("input: re-armed")
        finally:
            termios.tcsetattr(sys.stdin, termios.TCSADRAIN, old_tty)

        _, status = os.waitpid(self.child_pid, 0)
        if os.WIFEXITED(status):
            return os.WEXITSTATUS(status)
        if os.WIFSIGNALED(status):
            return 128 + os.WTERMSIG(status)
        return 1


def main() -> None:
    codex_bin = os.environ.get("CODEX_BIN", "/opt/homebrew/bin/codex")
    argv = [codex_bin] + sys.argv[1:]
    if not os.path.isfile(codex_bin):
        sys.stderr.write(f"codex-notify: codex binary not found at {codex_bin}\n")
        sys.exit(127)
    proxy = PtyProxy(argv)
    sys.exit(proxy.run())


if __name__ == "__main__":
    main()
