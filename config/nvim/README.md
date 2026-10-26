# Neovim

This configuration targets Neovim 0.12 or newer. It uses Lazy for plugins, Mason for language servers and formatters, and Neovim's native Treesitter highlighting. Pickers use fzf-lua, which needs `fzf` on `PATH`. Plugin revisions are recorded in `lazy-lock.json`.

## Setup

On macOS, install the command-line dependencies and Xcode Command Line Tools before opening Neovim.

```sh
brew install neovim tree-sitter-cli ripgrep fd fzf node
xcode-select --install # only if the Command Line Tools are missing
```

Rust editing also needs a Rust toolchain with `cargo`, `rustc`, and `rustfmt`. The dotfiles deployment maps this directory to `~/.config/nvim`.

Open `nvim` and allow the initial plugin, parser, language-server, and formatter downloads to finish. Mason installs StyLua, prettierd, and the language servers. Swift uses the `sourcekit-lsp` that ships with Xcode and formats with `swiftformat` (`brew install swiftformat`). Rustaceanvim owns the Rust language server, and emmylua_ls handles Lua (settings in `.emmyrc.json`). Python uses ty for types and Ruff for linting, import sorting, and formatting. ESLint and oxlint attach only in projects that configure them. JavaScript and TypeScript buffers get one server based on the nearest project markers: denols for Deno projects, the native TypeScript 7 server (`tsc --lsp`) when the project has no local TypeScript or a 7.x one, and ts_ls for projects pinned to older TypeScript.

## Maintenance

Use `:Lazy restore` to return plugins to the committed revisions. Use `:Lazy update` for an intentional upgrade, then review and commit the lockfile. After restoring or updating Treesitter, run `:TSUpdate` and let parser installation finish before quitting.

Use `:MasonToolsInstall` to install missing formatters, `:MasonToolsUpdate` to update them, and `:Mason` to manage language servers. The plugin lockfile does not pin those external tools or parser binaries.

Run `:checkhealth nvim-treesitter rustaceanvim conform lazy vim.lsp` after upgrades. Conform may report that the optional `prettier` fallback is missing when `prettierd` is available. Full `:checkhealth` also checks optional language providers and runtimes that this configuration does not require.

## Common keys

The leader is Space.

| Key | Action |
| --- | --- |
| Ctrl-P | Find files |
| `\` | Search file contents |
| Space-e | File explorer (oil; edit the buffer and `:w` to rename, move, or delete) |
| Space-p | Yank history (`[y`/`]y` cycle after a put) |
| Space-u | Undo tree |
| Space-fm | Marks |
| `]h` / `[h` | Next / previous Git hunk |
| Space-hs, Space-hr, Space-hp | Stage, reset, preview hunk |
| Space-th | Toggle inlay hints |
| Enter / Backspace | Grow / shrink the selection by syntax node |
| Ctrl-h/j/k/l | Move between windows, then tmux panes |
| Space-fr | Resume last picker |
| Space-S | Search and replace |
| `gd`, `gR`, `gi` | Definition, references, implementations (fzf-lua) |
| `grn`, `gra`, `grt`, `gO`, `K` | Neovim defaults: rename, code action, type definition, symbols, hover |
| Space-d | Line diagnostics |
| Space-r | Rust runnables, in Rust buffers |
| `af`, `if`, `ac`, `ic` | Function and class text objects |

Folds come from the language server or Treesitter and start open. Diagnostics show as signs, with the full message under the cursor line. Formatting runs on save. Use `:ConformInfo` to inspect the formatter selected for the current buffer. `:w!!` expands to `:SudaWrite` for a privileged save.
