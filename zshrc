source_files_in() {
    local dir="$1"

    if [[ -d "$dir" && -r "$dir" && -x "$dir" ]]; then
        for file in "$dir"/*; do
           [[ -f "$file" && -r "$file" ]] && . "$file"
        done
    fi
}

export ZSH="$HOME/.zsh"

# Add homebrew to path
if uname -s | grep -q Darwin; then
    export PATH="/usr/local/bin:$PATH"
    export EDITOR='nvim'
    export VISUAL='nvim'
    export PAGER='less'
fi

export PATH="$HOME/.bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"

# Android
ANDROID_DIR="$HOME/Library/Android/sdk/platform-tools"
if [[ -d $ANDROID_DIR ]]; then
    export PATH="$ANDROID_DIR:$PATH"
fi

# Haskell
STACK_DIR="$HOME/.local/bin"
if [[ -d $STACK_DIR ]]; then
    export PATH="$STACK_DIR:$PATH"
fi

export FZF_DEFAULT_COMMAND='rg --files'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=0
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1 # Display raw command like in Fish

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi

source "$ZSH/plugins.zsh"
source_files_in "$ZSH/plugins"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export GPG_TTY=$(tty)

export DENO_INSTALL="/Users/nano/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/nano/.bun/_bun" ] && source "/Users/nano/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
