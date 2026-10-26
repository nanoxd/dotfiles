# AGENTS.md

Guidance for coding agents (Claude Code, Codex, etc.) working in this repository.

## Overview

Personal macOS dotfiles. There is no build system. Each tool's config lives
here and is symlinked into place.

## Deployment

`.mappings` (TOML) lists the symlinks, applied with
[`dot`](https://github.com/ubnt-intrepid/dot) (`cargo install dot`). Entries
under `[general]` apply everywhere and `[darwin]` only on macOS. When adding a
file that lives at a new home-directory path, add it to `.mappings`.

`config/` is linked as the whole of `~/.config`, so every app on the machine
writes into this repo. `.gitignore` ignores `config/*` and opts tracked tools
back in with `!config/<tool>/`. To track a new tool, add its allowlist line and
ignore any runtime state, logs, or credentials it writes beside its config.
Never commit secrets such as `config/gh/hosts.yml` or `aws/credentials`.

## Layout

- `config/fish/` – primary shell. `zshrc` and `zsh/` are kept working as a
  second shell. `SHELLS.md` documents how both set up PATH and mise.
- `config/nvim/` – Neovim 0.12+ with Lazy, Mason and fzf-lua. See its README.
- `config/tmux/` – tmux config (XDG path) with TPM plugins in `~/.tmux/plugins`.
  `C-h/j/k/l` hand off between Neovim splits and tmux panes through `is_vim`
  here and `lua/keys.lua` in Neovim.
- `config/rex/init.lua` – Rex terminal config. Ghostty (`config/ghostty/`) is
  still used on some machines.
- `hammerspoon/` – window management and Hyper-key app launching.
- `config/karabiner/karabiner.json` – Caps Lock to Hyper/Escape and key
  layers. Edited directly (no Goku).
- `config/skl/` – agent skills manifest. Edit `skills.toml`, run `skl sync`,
  commit both it and `skills.lock`.
- `config/mise/` – tool versions (Node, Zig).
- `pi/agent/` – Pi agent settings and extensions.
- Smaller configs: `bat`, `bd`, `gh`, `herdr`, `starship.toml`, `stylua`, `zed`,
  plus `gitconfig`, `gitignore` (global), `gitattributes`, and `lldbinit`.
- `bin/` – personal scripts on PATH as `~/.bin`. Git helpers (`git-conflicts`,
  `git-cut-branch`, `git-edit-new`, `git-fco`, `git-large-files`,
  `git-search`, `git-undo`, `run-command-on-git-revisions`) and utilities
  (`e`, `o`, `pbedit`, `cpssh`, `each_folder`, `change-extension`,
  `clean-even-numbered-files`, `webm-to-mp4`, `fish-profile`, `zupg`).

## Git configuration

Delta is the pager, conflicts use zdiff3, rebases autostash and autosquash,
commits are SSH-signed, and `fetch.followRemoteHEAD` keeps `git default-branch`
current. Aliases live in `gitconfig`.

## Validating changes

Check the tool you touched before committing:

- Fish: `fish -n <file>`. Zsh: `zsh -n zshrc`.
- tmux: `tmux -L check -f /dev/null start-server \; source-file -n ~/.config/tmux/tmux.conf`
- Rex: `rex config check`
- Neovim: `nvim --headless +qa` and `stylua --check config/nvim`
- Shell scripts: run them against a scratch directory, never real data.

## Commits

Prefix subjects with the area in brackets, for example `[tmux] ...`,
`[Neovim] ...`, `[bin] ...`, or `[Cleanup] ...`.
