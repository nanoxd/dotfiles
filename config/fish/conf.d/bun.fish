if command -q bun
    set -Ux BUN_INSTALL "$HOME/.bun"
    fish_add_path -amg "$BUN_INSTALL/bin"
else
    _warn_no_command bun
end