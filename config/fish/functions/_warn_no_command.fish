function _warn_no_command
    status is-interactive; or return
    set -l switch "$__fish_config_dir/.allow_missing_command"
    if not test -e "$switch"
        printf 'Command not found: %s. To silence this, run: touch "%s"\n' "$argv[1]" "$switch" >&2
    end
end
