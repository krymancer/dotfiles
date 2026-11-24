# T3 Code: no product telemetry. The desktop app imports the login shell's
# environment, so this also covers the app on macOS.
set -gx T3CODE_TELEMETRY_ENABLED false
