# Editors
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less

# ENVs
set -x GOPATH "$HOME/dev/go"
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -x FZF_TMUX 1
set -x DYLD_LIBRARY_PATH "$HOME/.rustup/toolchains/nightly-x86_64-apple-darwin"
set -x GITHUB_ACCESS_TOKEN (cat ~/.token)
set -x TEMPLATES "$HOME/dev/templates"

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

# Yarn
if test -d (yarn global bin)
  set -U fish_user_paths (yarn global bin) $fish_user_paths
  set -x PATH $PATH $HOME"/.config/yarn/global/node_modules/.bin"
end

if test -f $HOME/.fish
  source $HOME/.fish
end

export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

if test -d "/Applications/Postgres.app/Contents/Versions/latest/bin"
  set -U fish_user_paths "/Applications/Postgres.app/Contents/Versions/latest/bin" $fish_user_paths
end

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/nano/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/nano/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/nano/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/nano/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /Users/fernando.paredes/.config/yarn/global/node_modules/tabtab/.completions/electron-forge.fish ]; and . /Users/fernando.paredes/.config/yarn/global/node_modules/tabtab/.completions/electron-forge.fish
