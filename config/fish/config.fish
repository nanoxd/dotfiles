# Fisher plugin manager (keeping for reference)
# set -g fisher_path $HOME/.config/fish/fisher
# set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
# set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

# for file in $fisher_path/conf.d/*.fish
#     builtin source $file 2> /dev/null
# end

# Additional environment variables not in conf.d
set -gx VISUAL nvim
set -gx PAGER less
set -gx FZF_FIND_FILE_COMMAND 'rg --files'
set -U FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_DEFAULT_COMMAND 'rg --files'
set -gx FZF_TMUX 1
set -gx TEMPLATES "$HOME/dev/templates"
set -gx FZF_CTRL_T_COMMAND 'rg --files'

# Custom paths (fish_user_paths is managed by Fish itself)
set -e fish_user_paths
set -U fish_user_paths /usr/local/bin $HOME/.bin $HOME/.cargo/bin

# Source local config if exists
if test -f $HOME/.fish
  source $HOME/.fish
end

# Initialize Starship prompt
starship init fish | source
