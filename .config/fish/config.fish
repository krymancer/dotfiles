if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

set JAVA_HOME /usr/local/jdk-21
set GATLING_HOME ~/gatling/3.10

fish_add_path /usr/local/jdk-21/bin
fish_add_path /usr/local/zig/0.12.0/
fish_add_path /usr/local/go/bin
fish_add_path /usr/local/nvim/bin/
fish_add_path ~/gatling/3.10/bin
fish_add_path ~/.cargo/bin

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/junho/.ghcup/bin # ghcup-env

# pnpm
set -gx PNPM_HOME "/home/junho/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
