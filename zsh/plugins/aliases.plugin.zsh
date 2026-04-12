#!/usr/bin/env zsh

function base64d() {
  echo "$@" | base64 -D - | jq .
}

function mkdir() {
  command mkdir -p "$@"
}

function p() {
  if [ -n "$1" ] && [ -f "$1" ]; then
    bat "$@"
  else
    eza -lh "$@"
  fi
}

# tm - creates new tmux session, or switch to existing one.
function tm() {
    [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
    if [ $1 ]; then
      tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
    fi
    session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

alias rm='trash'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls='eza'
alias ll='ls -l'
alias la='ls -al'

if (( $+commands[brew] )); then
  function brew() {
    case "$1" in
      cleanup)
        command brew cleanup --prune-prefix
        ;;
      bump)
        command brew update
        command brew upgrade
        brew cleanup
        ;;
      *)
        command brew "$@"
        ;;
    esac
  }

  alias bi='brew install'
fi

alias rm-mac-metadata='find . -name ".DS_Store" -or -name "._*" -delete'

# Editors
alias co='code'
alias vim='nvim'
alias vimdiff='nvim -d'

[[ "$(uname -s)" == "Darwin" ]] && alias f='fork'

alias sync='rsync -az --progress'

# Bun
alias b='bun'
alias ba='bun add'
alias bad='bun add -d'
alias by='bun install'
alias br='bun run'

# Rust
alias c='cargo'
alias cr='cargo run'
alias ct='cargo test'

# Git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gaap='git add --all --patch'
alias gc='git commit'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcb='git switch -c'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdw='git diff --word-diff'
alias gin='git introduced'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpr='gh pr view --web'
alias gpu='git pull --rebase'
alias gs='git status -sb'

function gpc() {
  git push --set-upstream origin "$(git branch --show-current)"
}
