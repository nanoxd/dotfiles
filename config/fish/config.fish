set -gx VISUAL nvim
set -gx PAGER less
set -gx FZF_DEFAULT_COMMAND 'rg --files'
set -gx TEMPLATES "$HOME/dev/templates"

# Source local config if exists
if test -f $HOME/.fish
  source $HOME/.fish
end

# Initialize Starship prompt
starship init fish | source
