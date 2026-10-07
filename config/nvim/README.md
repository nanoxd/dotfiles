# Neovim

This configuration targets Neovim 0.12 or newer. It uses Lazy for plugins, Mason for language servers and formatters, and Neovim's native Treesitter highlighting. Plugin revisions are recorded in `lazy-lock.json`.

## Setup

On macOS, install the command-line dependencies and Xcode Command Line Tools before opening Neovim.

```sh
brew install neovim tree-sitter-cli ripgrep node
xcode-select --install # only if the Command Line Tools are missing
```

Rust editing also needs a Rust toolchain with `cargo`, `rustc`, and `rustfmt`. The dotfiles deployment maps this directory to `~/.config/nvim`.

Open `nvim` and allow the initial plugin, parser, language-server, and formatter downloads to finish. Mason installs StyLua, Black, isort, and prettierd. Rustaceanvim owns the Rust language server. TypeScript and Deno choose one server based on the nearest project markers.

## Maintenance

Use `:Lazy restore` to return plugins to the committed revisions. Use `:Lazy update` for an intentional upgrade, then review and commit the lockfile. After restoring or updating Treesitter, run `:TSUpdate` and let parser installation finish before quitting.

Use `:MasonToolsInstall` to install missing formatters, `:MasonToolsUpdate` to update them, and `:Mason` to manage language servers. The plugin lockfile does not pin those external tools or parser binaries.

Run `:checkhealth nvim-treesitter rustaceanvim telescope conform lazy` after upgrades. Conform may report that the optional `prettier` fallback is missing when `prettierd` is available. Full `:checkhealth` also checks optional language providers and runtimes that this configuration does not require.

## Common keys

The leader is Space.

| Key | Action |
| --- | --- |
| Ctrl-P | Find files |
| `\\` | Search file contents |
| Space-e | File explorer |
| Space-p | Clipboard history |
| Space-S | Search and replace |
| `gd`, `gR`, `grt` | Definition, references, type definitions |
| Space-d | Line diagnostics |
| Space-r | Rust runnables, in Rust buffers |
| `af`, `if`, `ac`, `ic` | Function and class text objects |

Formatting runs on save. Use `:ConformInfo` to inspect the formatter selected for the current buffer. `:w!!` expands to `:SudaWrite` for a privileged save.
