export ZSH="$HOME/.zsh"

# Add homebrew to path
if uname -s | grep -q Darwin; then
    export PATH="/usr/local/bin:$PATH"
    export EDITOR='nvim'
    export VISUAL='nvim'
    export PAGER='less'
fi

export PATH="$HOME/.bin:$HOME/.cargo/bin:$PATH"

eval "$(sheldon source)"

# Pure Prompt
PURE_CMD_MAX_EXEC_TIME=5

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
