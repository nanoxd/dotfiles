# Display the compressed current working path on the right
# If the previous command returned any kind of error code, display that too

function _ruby_version
  echo (ruby --version | cut -d' ' -f 1-2)
end

function fish_right_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l red (set_color -o red)
  set -l magenta (set_color -o magenta)
  set -l normal (set_color normal)

  echo -n -s $cyan (_ruby_version)

  if test $last_status -ne 0
    set_color red
    printf ' [error: %d]' $last_status
    set_color normal
  end
end
