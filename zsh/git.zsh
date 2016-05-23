#!/bin/sh

eval "$(hub alias -s)"

alias ga='git add'
alias gaa='git add --all'
alias gaap='git add --all --patch'
alias gc='git commit -v'
alias gca='git commit -v --amend'
alias gcb='git create-branch'
alias gcl='git clone'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git push'
alias gpr='git pull-request --browse'
alias gpu='git pull --rebase'
alias gs='git status -sb'

gpc() {
  git push --set-upstream origin $(git-branch-current 2> /dev/null)
}
