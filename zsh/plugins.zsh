### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    if (( ! $+commands[git] )); then
        print -u2 'Zinit installation requires git.'
        return 0
    fi
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    if ! { command mkdir -p "$HOME/.local/share/zinit" &&
           command chmod g-rwX "$HOME/.local/share/zinit" &&
           command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"; }; then
        print -u2 'Zinit installation failed. Continuing without managed plugins.'
        return 0
    fi
    print -P "%F{33} %F{34}Installation successful.%f%b"
fi

[[ -r "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]] || return 0
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" || return 0
(( $+functions[zinit] )) || return 0
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

# fzf-tab must load after compinit and before plugins that wrap widgets.
zinit wait lucid light-mode for \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
  atinit"zicompinit; zicdreplay" \
      Aloxaf/fzf-tab \
  zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

zinit light-mode for \
  djui/alias-tips \
  zsh-users/zsh-history-substring-search
