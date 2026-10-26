# Use our final activation step instead of Homebrew's vendor auto-activation.
set -g MISE_FISH_AUTO_ACTIVATE 0

# Sorts after 0.00_brew.fish so user commands, including mise, stay ahead of
# Homebrew for the tool setup that follows.
fish_add_path --path --move "$HOME/.bin" "$HOME/.local/bin"
