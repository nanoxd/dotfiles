# Nano's Dotfiles

Config for the tools I use every day on macOS: Fish, Neovim, tmux, Rex,
Hammerspoon, Karabiner, and Git. Borrow ideas rather than copying it wholesale.

## Setup

```sh
git clone git@github.com:nanoxd/dotfiles.git ~/.dotfiles
cargo install dot
cd ~/.dotfiles && dot link
mise install
```

`.mappings` lists every symlink. `config/` becomes `~/.config`, and
`.gitignore` opts in the tools that are tracked there. `SHELLS.md` covers shell
setup and `config/nvim/README.md` covers Neovim.
