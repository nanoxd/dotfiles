# Set paths
set -U fish_user_paths /usr/local/sbin /usr/local/bin /usr/local/share/npm/bin /usr/local/share/python $HOME/bin $GOPATH/bin /Applications/Postgres.app/Contents/Versions/9.3/bin

# Load Solarized for colors
. $HOME/.config/fish/solarized.fish

# Editors
set -U EDITOR vim
set -U VISUAL vim
set -U PAGER less

# ENVs
set -x GOPATH "$HOME/Dev/Code/go"
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications" # Install location

# Custom behavior
fish_user_abbreviations
set fish_key_bindings fish_vi_key_bindings

# Source Fry
. /usr/local/share/fry/fry.fish

if test -f $HOME/.fish
  . $HOME/.fish
end

# Use nvm
test -s ~/.nvm-fish/nvm.fish; and source ~/.nvm-fish/nvm.fish
