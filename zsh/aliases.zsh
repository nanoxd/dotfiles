#!/bin/sh

if which brew >/dev/null 2>&1; then
  brew() {
    case "$1" in
      cleanup)
        command brew cleanup
        command brew cask cleanup
        command brew prune
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
  alias bci='brew cask install'
  alias bcs='brew cask search'
  alias bcu='brew cask uninstall'

  alias podi='bundle exec pod install'
  alias podu='bundle exec pod update'
fi

alias be='bundle exec'
alias bu='bundle update'
alias gemi='gem install'
alias gemu='gem update'
alias rm-mac-metadata='find . -name ".DS_Store" -or -name "._*" -delete'

base64d() {
  echo "$@" | base64 -D - | jq .
}

mkdir() {
  mkdir -p "$@"
}

mkcd() {
  mkdir $@ && cd $@
}
