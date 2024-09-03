function _warn_no_command
    set -l switch $__fish_config_dir/.allow_missing_command
    if not test -e $switch
        printf "Command NOT FOUND: %s; If do NOT want to see this, run `touch %s`\n" $argv[1] $switch
    end
end