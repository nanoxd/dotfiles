set -Ux BUN_INSTALL "$HOME/.bun"

if test -d $BUN_INSTALL/bin
    fish_add_path -amg "$BUN_INSTALL/bin"
else
    _warn_no_command bun
end
