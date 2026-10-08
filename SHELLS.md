# Shell setup

Zsh and Fish initialize Homebrew, add user commands and tool directories, then activate mise. Interactive shells use mise's directory-change hooks. Fish scripts use mise shims. Zsh scripts do not read `.zshrc` automatically, so use `mise exec -- <command>` when a script needs project tools.

User commands in `~/.bin` and `~/.local/bin` take precedence over Homebrew. Cargo, Bun, Deno, and Go directories provide fallback commands. Custom `CARGO_HOME`, `BUN_INSTALL`, `DENO_INSTALL`, and `GOPATH` values are preserved, including multiple Go workspace paths.

Install `mise` in `~/.local/bin` or through Homebrew. Run `mise install` to install the versions configured in `config/mise/config.toml`. The shells do not pin Node to a particular installation directory.

Starship, zoxide, eza, and trash are optional. Fish reports missing interactive tools on stderr and stays quiet for scripts. Create `~/.config/fish/.allow_missing_command` to suppress those notices.

Zsh bootstraps Zinit on first interactive startup and continues without managed plugins if installation fails. Fish plugin names live in `config/fish/fish_plugins`. Use `fisher update` after installing Fisher to restore them.

Machine-specific overrides remain in `~/.zshrc.local` and `~/.fish`. Fish's Homebrew mise auto-activation is disabled because `conf.d/zz_mise.fish` handles activation after the other PATH setup.
