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

`chezmoi apply` also:

1. installs packages from `packages/` (`Brewfile` on macOS; `arch.txt`, plus `arch-<hostname>.txt` if one exists on Arch Linux),
2. runs `mise install` for the runtimes in `~/.config/mise/config.toml`,
. on Linux, installs the T3 Code server (nightly) as a user service, with `t3-update.timer` pulling new nightlies every 3 hours.

Neovim config lives in its own repo ([config.nvim](https://github.com/krymancer/config.nvim)) and is pulled in via `.chezmoiexternal.toml`.

## Not in this repo (set up by hand)

- SSH keys (`~/.ssh/id_ed25519`); add the new public key to GitHub and to `dot_config/git/allowed_signers`
- `gh auth login`
- `~/.kube/config-k3s` (copy from the k3s server)
- `~/.vnc/passwd` (`x11vnc -storepasswd`); the Linux boxes log into XFCE automatically (LightDM autologin) so x11vnc works after a reboot
- The Linux boxes never sleep: sleep targets are masked and the lid switch is ignored
- Battery charging stops at 80% (`battery-charge-limit.service`), since they stay plugged in
- `tailscale up`

## Daily use

```sh
chezmoi edit --apply ~/.config/fish/config.fish   # edit a managed file
chezmoi re-add                                     # pull in edits made directly to target files
chezmoi diff                                       # preview changes
chezmoi update                                     # git pull + apply
chezmoi cd                                         # jump to this repo to commit/push
```
