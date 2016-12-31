# Editors
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less

# ENVs
set -x GOPATH "$HOME/Dev/go"
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_TMUX 1
set -x SLACK_URL "https://hooks.slack.com/services/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"

# Set paths
set -U fish_user_paths /usr/local/bin $HOME/.bin $GOPATH/bin (yarn global bin)

# Custom behavior
set -U fish_key_bindings fish_vi_key_bindings

if test -d "$HOME/Library/Android/sdk/platform-tools"
  set -U fish_user_paths "$HOME/Library/Android/sdk/platform-tools" $fish_user_paths
end

# Stack
if test -d "$HOME/.local/bin"
  set -U fish_user_paths "$HOME/.local/bin" $fish_user_paths
end

# Rust
if test -d "$HOME/.cargo/bin"
  set -U fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
end

if test -f $HOME/.fish
  source $HOME/.fish
end

export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
