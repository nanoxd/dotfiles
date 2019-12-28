# Bind word expansion (and command completion) to the Tab key.
bind --sets-mode expand \t expand:execute

# During expansion, bind Backspace to revert the operation.
bind --mode expand --sets-mode default --key backspace --silent expand:revert

# Bind Tab to cycle through the available expansions.
bind --mode expand \t expand:choose-next

# If the user enters any key other than Backspace, exit expand mode and passthrough keys to the default binding.
bind --mode expand --sets-mode default '' ''

# vi mode workaround
# vi mode shall return to insert mode instead of the default mode
bind --mode insert --sets-mode vi_expand \t expand:execute
bind --mode vi_expand --sets-mode insert --key backspace --silent expand:revert
bind --mode vi_expand \t expand:choose-next
bind --mode vi_expand --sets-mode insert '' ''
