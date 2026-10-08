set -l cargo_home "$HOME/.cargo"
if set -q CARGO_HOME; and test -n "$CARGO_HOME"
    set cargo_home "$CARGO_HOME"
end
fish_add_path --path --append "$cargo_home/bin"
