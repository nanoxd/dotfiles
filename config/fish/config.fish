set -gx VISUAL nvim
set -gx FZF_DEFAULT_COMMAND 'rg --files'

if test -f $HOME/.fish
    source $HOME/.fish
end

if status is-interactive
    starship init fish | source
end
