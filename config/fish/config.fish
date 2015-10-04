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

# Source rbenv
if test -d "$HOME/.rbenv/bin"
  set -U fish_user_paths $HOME/.rbenv/bin $fish_user_paths
end

status --is-interactive; and . (rbenv init -|psub)

if test -d "$HOME/Library/Android/sdk/platform-tools"
  set --universal fish_user_paths "$HOME/Library/Android/sdk/platform-tools" $fish_user_paths
end

if test -f $HOME/.fish
  source $HOME/.fish
end

# SSH nonsense, mac specific
if status --is-login
  set PPID (echo (ps -p %self -o 'ppid=') | xargs)
  if ps -p $PPID | grep ssh
    tmux has-session -t remote; and tmux attach-session -t remote; or tmux new-session -s remote; and kill %self
    echo "tmux failed to start; using plain fish shell"
  end
end
