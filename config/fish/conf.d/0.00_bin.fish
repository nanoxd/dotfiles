# Use our final activation step instead of Homebrew's vendor auto-activation.
set -g MISE_FISH_AUTO_ACTIVATE 0

# Make user-installed tools, including mise, available before tool initialization.
fish_add_path --path --move "$HOME/.bin" "$HOME/.local/bin"
