# dotfiles

Managed with [chezmoi](https://chezmoi.io) across:

| Host  | OS                 |
|-------|--------------------|
| rogue | macOS              |
| judy  | Arch Linux         |
| panam | Arch Linux         |

## Bootstrap a new machine

```sh
# macOS: install Homebrew first (https://brew.sh), then
brew install chezmoi
# Arch Linux
sudo pacman -S chezmoi

chezmoi init --apply krymancer
```

Run it from a real terminal (or `ssh -t`): paru needs a TTY.

`chezmoi apply` also:

1. installs packages from `packages/` (`Brewfile` on macOS; on Arch Linux `arch.txt`, plus `arch-<hostname>.txt` if one exists),
2. runs `mise install` for the runtimes in `~/.config/mise/config.toml`,
3. installs Claude Code, Codex, opencode, Cursor Agent, Grok (and Pi on Linux) with their official installers if missing (they self-update),
4. on Linux:
   - enables `sshd`, `tailscaled` and rootless podman (`podman.socket`), and lets the tailnet and the k3s/Termix box through `ufw`,
   - gives systemd user services a full PATH (`~/.config/environment.d/10-path.conf`) so T3 Code finds the provider CLIs and mise runtimes,
   - installs the T3 Code server (nightly) as a user service, with `t3-update.timer` pulling new nightlies every 3 hours,
   - logs into XFCE automatically (LightDM autologin) and runs x11vnc,
   - never sleeps (sleep targets masked, lid switch ignored) and stops charging at 80%, since these are always-on, plugged-in laptops.

Neovim config lives in its own repo ([config.nvim](https://github.com/krymancer/config.nvim)) and is pulled in via `.chezmoiexternal.toml`.

## Not in this repo (set up by hand)

- SSH keys (`~/.ssh/id_ed25519`); add the new public key to GitHub and to `dot_config/git/allowed_signers`
- `gh auth login`, and signing in to Claude Code / Codex
- `~/.kube/config-k3s` (copy from the k3s server, or from another machine)
- `~/.vnc/passwd` (`x11vnc -storepasswd`, max 8 characters)
- `sudo tailscale up` (remove the old machine from the Tailscale admin console first, or the new one becomes `<name>-1`)
- T3 Code: `t3 connect --headless` to link it to T3 Connect; after a reinstall, deregister the old environment on the T3 Connect page

## Daily use

```sh
chezmoi edit --apply ~/.config/fish/config.fish   # edit a managed file
chezmoi re-add                                     # pull in edits made directly to target files
chezmoi diff                                       # preview changes
chezmoi update                                     # git pull + apply
chezmoi cd                                         # jump to this repo to commit/push
```
