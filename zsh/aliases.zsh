#!/bin/sh

base64d() {
  echo "$@" | base64 -D - | jq .
}

mkdir() {
  command mkdir -p "$@"
}

mkcd() {
  mkdir $@ && cd $@
}

android-method-count() {
  unzip -p "$@" classes.dex | head -c 92 | tail -c 4 | hexdump -e '1/4 "%d\n"'
}

ip() {
  ifconfig lo0 | grep 'inet '  | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet '  | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet '  | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls='ls -G'
alias ll='ls -alhG'
alias sbgit='git config user.email fernando.paredes@shiftboard.com'


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

alias a='atom'
alias e='nvim'
alias be='bundle exec'
alias bu='bundle update'
alias gemi='gem install'
alias gemu='gem update'
alias rm-mac-metadata='find . -name ".DS_Store" -or -name "._*" -delete'

if [ "$(uname -s)" = "Darwin" ]; then
  alias gt='gittower .'
fi

***REMOVED***
***REMOVED***

alias sync='rsync -az --progress'

# NPM
alias ni='npm i'
