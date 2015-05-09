# Set paths
set -U fish_user_paths /usr/local/sbin /usr/local/bin /usr/local/share/npm/bin $HOME/.bin $GOPATH/bin /Applications/Postgres.app/Contents/Versions/9.3/bin

# Load Solarized for colors
source $HOME/.config/fish/solarized.fish

# Editors
set -U EDITOR vim
set -U VISUAL vim
set -U PAGER less

# ENVs
set -x GOPATH "$HOME/Dev/go"
set -x HOMEBREW_CASK_OPTS "--appdir=/Applications" # Install location

# Custom behavior
fish_user_abbreviations
set fish_key_bindings fish_vi_key_bindings

# Source Chruby
if test -d /usr/local/share/chruby
  source /usr/local/share/chruby/chruby.fish
  source /usr/local/share/chruby/auto.fish
end

if test -f $HOME/.fish
  source $HOME/.fish
end

# Use nvm
source $HOME/.config/fish/wrappers/nvm.fish

# SSH nonsense, mac specific
if status --is-login
  set PPID (echo (ps -p %self -o 'ppid=') | xargs)
  if ps -p $PPID | grep ssh
    tmux has-session -t remote; and tmux attach-session -t remote; or tmux new-session -s remote; and kill %self
    echo "tmux failed to start; using plain fish shell"
  end
end
