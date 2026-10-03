#!/bin/bash
# AI coding CLIs (Claude Code, Codex, opencode, Cursor, Grok, Pi) via their official installers;
# each updates itself afterwards.
# Only installs what's missing.
set -euo pipefail
# Already on PATH, so installers don't append PATH lines to shell rc files
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"

if [ ! -x "$HOME/.local/bin/claude" ]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

if [ ! -x "$HOME/.local/bin/codex" ]; then
  curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh
fi

if [ ! -x "$HOME/.opencode/bin/opencode" ]; then
  curl -fsSL https://opencode.ai/install | bash -s -- --no-modify-path
fi

if [ ! -x "$HOME/.local/bin/cursor-agent" ]; then
  curl -fsS https://cursor.com/install | bash
fi

# SHELL=/bin/sh: the grok installer appends a PATH block to the rc file of $SHELL
# (config.fish here); 00-path.fish already puts ~/.grok/bin on PATH.
if [ ! -x "$HOME/.grok/bin/grok" ]; then
  curl -fsSL https://x.ai/cli/install.sh | SHELL=/bin/sh bash
fi

# Pi (Linux only, used by T3 Code). Its installer needs node/npm (mise shims) and asks questions
# on /dev/tty; setsid detaches it from the terminal so it runs unattended and leaves rc files alone.
if [ "$(uname -s)" = Linux ] && [ ! -x "$HOME/.local/bin/pi" ]; then
  PATH="$HOME/.local/share/mise/shims:$PATH" setsid -w sh -c 'curl -fsSL https://pi.dev/install.sh | sh'
fi
