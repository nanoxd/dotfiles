# Set paths
set -U fish_user_paths /usr/local/sbin /usr/local/bin $HOME/.bin $GOPATH/bin /Applications/Postgres.app/Contents/Versions/9.3/bin

# Load Solarized for colors
source $HOME/.config/fish/solarized.fish

# Editors
set -U EDITOR nvim
set -U VISUAL nvim
set -U PAGER less

# ENVs
set -x GOPATH "$HOME/Dev/go"
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications" # Install location
set -x SLACK_URL "https://hooks.slack.com/services/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"

# Custom behavior
fish_user_abbreviations
set fish_key_bindings fish_vi_key_bindings

if test -d "$HOME/Library/Android/sdk/platform-tools"
  set --universal fish_user_paths "$HOME/Library/Android/sdk/platform-tools" $fish_user_paths
end

if test -f $HOME/.fish
  source $HOME/.fish
end

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Disable Cocoapods Deterministic UUIDs
export COCOAPODS_DISABLE_DETERMINISTIC_UUIDS=YES
