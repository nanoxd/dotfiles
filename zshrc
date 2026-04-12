export ZSH="$HOME/.zsh"

if [[ "$(uname -s)" == "Darwin" ]]; then
    export EDITOR='nvim'
    export VISUAL='nvim'
fi

export PATH="$HOME/.bin:$HOME/.local/bin:$HOME/go/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --files'
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=0
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1 # Display raw command like in Fish

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

source "$ZSH/plugins.zsh"
for file in "$ZSH"/plugins/*; do
    [[ -f "$file" && -r "$file" ]] && source "$file"
done

export GPG_TTY=$TTY

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

[[ -f "$HOME/.turso/env" ]] && source "$HOME/.turso/env"
