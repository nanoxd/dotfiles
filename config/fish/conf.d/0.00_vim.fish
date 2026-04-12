set -gx EDITOR nvim

alias vim=nvim
alias vimdiff='nvim -d'

if status is-interactive
    fish_vi_key_bindings
end
