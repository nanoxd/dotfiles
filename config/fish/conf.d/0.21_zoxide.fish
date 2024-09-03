if command -q zoxide
    zoxide init fish | source
else
    _warn_no_command zoxide
end