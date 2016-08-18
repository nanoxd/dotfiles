export ZSH="$HOME/.zsh"

# Add homebrew to path
if uname -s | grep -q Darwin; then
  export PATH="/usr/local/bin:$PATH"
fi

export PATH="$HOME/.bin:$PATH"
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

typeset -U config_files
config_files=($ZSH/*.zsh)

source <(antibody init)
antibody bundle < ~/.zshrc.plugins

# Load ZSH Modules
autoload -U promptinit && promptinit
autoload -U colors && colors

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
prompt pure

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

export PATH="/usr/local/opt/gnupg/libexec/gpgbin:$PATH"
