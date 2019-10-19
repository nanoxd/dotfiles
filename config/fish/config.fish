set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less

# ENVs
set -gx GOPATH "$HOME/dev/go"
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_TMUX 1
set -gx DYLD_LIBRARY_PATH "$HOME/.rustup/toolchains/nightly-x86_64-apple-darwin"
set -gx TEMPLATES "$HOME/dev/templates"
set -U fish_key_bindings fish_vi_key_bindings

# Set paths
set -Ua fish_user_paths /usr/local/bin $HOME/.bin $GOPATH/bin

# Rust
if test -d "$HOME/.cargo/bin"
  set -Ua fish_user_paths "$HOME/.cargo/bin"
end

# Yarn
if test -d (yarn global bin)
  set -Ua fish_user_paths (yarn global bin)
end

if test -f $HOME/.fish
  source $HOME/.fish
end

# Custom behavior

if test -d "/Applications/Postgres.app/Contents/Versions/latest/bin"
  set -Ua fish_user_paths "/Applications/Postgres.app/Contents/Versions/latest/bin"
end

if test -d "/usr/local/share/fish/vendor_completions.d/"
  set -gx fish_complete_path $fish_complete_path "/usr/local/share/fish/vendor_completions.d/"
end

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'
alias vim='nvim'
alias vimdiff='nvim -d'

bind \ca sudope
