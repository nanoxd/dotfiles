#!/usr/bin/env zsh
export LSCOLORS='exfxcxdxbxegedabagacad'
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_HIST_BEEP
setopt NO_LIST_BEEP

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST

setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt LOCAL_OPTIONS

# Set vim bindings
bindkey -v

bindkey '^r' history-incremental-search-backward

zmodload zsh/terminfo
if (( $+widgets[history-substring-search-up] && $+widgets[history-substring-search-down] )); then
  if [[ "$(uname -s)" == "Darwin" ]]; then
    [[ -n "$terminfo[cuu1]" ]] && bindkey "$terminfo[cuu1]" history-substring-search-up
    [[ -n "$terminfo[cud1]" ]] && bindkey "$terminfo[cud1]" history-substring-search-down
  else
    [[ -n "$terminfo[kcuu1]" ]] && bindkey "$terminfo[kcuu1]" history-substring-search-up
    [[ -n "$terminfo[kcud1]" ]] && bindkey "$terminfo[kcud1]" history-substring-search-down
  fi

  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

# Directory Changing
setopt autocd
setopt autopushd
setopt pushdsilent
setopt pushdignoredups
setopt pushdtohome
