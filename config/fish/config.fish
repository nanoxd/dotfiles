set -g fisher_path $HOME/.config/fish/fisher
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end


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
set fish_greeting

# Set paths
set -e fish_user_paths
set -U fish_user_paths /usr/local/bin $HOME/.bin $GOPATH/bin $HOME/.cargo/bin

if test -f $HOME/.fish
  source $HOME/.fish
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

if command -v zoxide &> /dev/null
  zoxide init fish | source
end

