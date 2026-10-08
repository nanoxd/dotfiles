export ZSH="$HOME/.zsh"

typeset -U path PATH
path=("$HOME/.bin" "$HOME/.local/bin" $path)

if (( $+commands[brew] )); then
    eval "$(command brew shellenv zsh)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv zsh)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
    export EDITOR='nvim'
    export VISUAL='nvim'
fi

path=("$HOME/.bin" "$HOME/.local/bin" $path)

export FZF_DEFAULT_COMMAND='rg --files'

# alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=0
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1 # Display raw command like in Fish

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

export DENO_INSTALL="${DENO_INSTALL:-$HOME/.deno}"
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export GOPATH="${GOPATH:-$HOME/go}"

for dotfiles_tool_bin in "${CARGO_HOME:-$HOME/.cargo}/bin" "$BUN_INSTALL/bin" "$DENO_INSTALL/bin"; do
    [[ -d "$dotfiles_tool_bin" ]] && path+=("$dotfiles_tool_bin")
done
for dotfiles_go_root in "${(@s/:/)GOPATH}"; do
    [[ -n "$dotfiles_go_root" && -d "$dotfiles_go_root/bin" ]] && path+=("$dotfiles_go_root/bin")
done
unset dotfiles_tool_bin dotfiles_go_root

[[ -f "$HOME/.turso/env" ]] && source "$HOME/.turso/env"

if (( $+commands[mise] )); then
    if [[ -o interactive ]]; then
        eval "$(mise activate zsh)"
    else
        eval "$(mise activate zsh --shims)"
        # Activation can leave inherited shims behind Homebrew in PATH.
        path=("${MISE_DATA_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/mise}/shims" $path)
    fi
fi

[[ -o interactive ]] || return 0

[[ -r "$ZSH/plugins.zsh" ]] && source "$ZSH/plugins.zsh"
for file in "$ZSH"/plugins/*(N); do
    [[ -f "$file" && -r "$file" ]] && source "$file"
done

[[ -n "$TTY" ]] && export GPG_TTY="$TTY"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"
return 0
