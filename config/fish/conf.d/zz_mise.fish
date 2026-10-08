# Keep user commands ahead of Homebrew, then let mise select project tools.
fish_add_path --path --move "$HOME/.bin" "$HOME/.local/bin"

# Activate after other PATH entries so project tool versions take precedence.
if command -q mise
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
        # mise emits nothing if inherited PATH already contains its shims.
        set -l mise_data "$HOME/.local/share/mise"
        if set -q XDG_DATA_HOME; and test -n "$XDG_DATA_HOME"
            set mise_data "$XDG_DATA_HOME/mise"
        end
        if set -q MISE_DATA_DIR; and test -n "$MISE_DATA_DIR"
            set mise_data "$MISE_DATA_DIR"
        end
        fish_add_path --path --move "$mise_data/shims"
    end
else
    _warn_no_command mise
end
