export ZSH="$HOME/.zsh"

# Add homebrew to path
if uname -s | grep -q Darwin; then
    export PATH="/usr/local/bin:$PATH"
    export EDITOR='nvim'
    export VISUAL='nvim'
    export PAGER='less'
fi

export PATH="$HOME/.bin:$HOME/.cargo/bin:`yarn global bin`:$PATH"

typeset -U config_files
config_files=($ZSH/*.zsh)

source <(sheldon source)

# Load ZSH Modules
autoload -U promptinit && promptinit
autoload -U colors && colors

function_files=($ZSH/functions/*)
for file in ${function_files}; do
    source "$file"
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}; do
    source "$file"
done

# Autocomplete
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
    compinit
else
    compinit -C
fi

# Pure Prompt
PURE_CMD_MAX_EXEC_TIME=5

# Source completion
for file in ${(M)config_files:#*/completion.zsh}; do
    source "$file"
done

unset config_files updated_at

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

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

source `brew --prefix`/etc/profile.d/z.sh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=0
export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1 # Display raw command like in Fish

if [[ -f "$HOME/.zshrc.local" ]]; then
    source "$HOME/.zshrc.local"
fi
