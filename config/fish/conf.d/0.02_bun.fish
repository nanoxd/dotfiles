if not set -q BUN_INSTALL; or test -z "$BUN_INSTALL"
    set -gx BUN_INSTALL "$HOME/.bun"
end
fish_add_path --path --append "$BUN_INSTALL/bin"
