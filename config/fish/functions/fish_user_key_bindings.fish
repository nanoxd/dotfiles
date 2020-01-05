function fish_user_key_bindings
    ### bang-bang ###
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
    ### bang-bang ###
    ### expand ###
    bind --sets-mode expand \t expand:execute
    bind --mode expand --sets-mode default --key backspace --silent expand:revert
    bind --mode expand \t expand:choose-next
    bind --mode expand --sets-mode default '' ''
    bind --mode insert --sets-mode vi_expand \t expand:execute
    bind --mode vi_expand --sets-mode insert --key backspace --silent expand:revert
    bind --mode vi_expand \t expand:choose-next
    bind --mode vi_expand --sets-mode insert '' ''
    ### expand ###
end

fzf_key_bindings
