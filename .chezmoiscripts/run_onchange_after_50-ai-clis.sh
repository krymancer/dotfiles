#!/bin/bash
# AI coding CLIs via their official installers (each updates itself afterwards).
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
