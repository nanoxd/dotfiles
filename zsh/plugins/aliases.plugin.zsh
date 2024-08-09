#!/usr/bin/env zsh

function base64d() {
  echo "$@" | base64 -D - | jq .
}

function mkdir() {
  command mkdir -p "$@"
}

function ip() {
  ifconfig lo0 | grep 'inet '  | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet '  | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet '  | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
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

alias ls="eza"
alias ll='ls -l'
alias la="ls -al"

if which brew >/dev/null 2>&1; then
  function brew() {
    case "$1" in
      cleanup)
        command brew cleanup --prune-prefix
        ;;
      bump)
        command brew update
        command brew upgrade --all
        brew cleanup
        ;;
      *)
        command brew "$@"
        ;;
    esac
  }

  alias bi='brew install'
fi

if which yarn >/dev/null 2>&1; then
  alias ya='yarn add'
  alias yad='yarn add --dev'
  alias yag='yarn global add'
  alias yr='yarn run'
  alias yu='yarn upgrade-interactive --latest'
fi

alias be='bundle exec'
alias bu='bundle update'
alias rm-mac-metadata='find . -name ".DS_Store" -or -name "._*" -delete'

# Editors
alias co='code'
alias vim="nvim"
alias vimdiff="nvim -d"

if [ "$(uname -s)" = "Darwin" ]; then
  alias f='fork'
fi

alias sync='rsync -az --progress'

# NPM
alias ni='npm i'
alias nis='npm i --save'
alias nisd='npm i --save-dev'
alias npmu='npm-check -u'
alias nr='npm run'

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
alias gin="git introduced"
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpr='git pull-request --browse'
alias gpu='git pull --rebase'
alias gs='git status -sb'

function gpc() {
  git push --set-upstream origin $(git-branch-current 2> /dev/null)
}
