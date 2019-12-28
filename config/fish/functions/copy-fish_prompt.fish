function fish_prompt
  set -l last_status $status
  set -l cyan (set_color cyan)
  set -l yellow (set_color yellow)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l cwd $blue(pwd | sed "s:^$HOME:~:")

  # Output the prompt, left to right

  # Add a newline before new prompts
  echo -e ''

  # Print pwd or full path
  echo -n -s $cwd $normal

  echo -n (__fish_git_prompt)

  # Terminate with a nice prompt char
  echo -e ''

  if test $last_status -ne 0
    set_color red
    printf '❯ ' $last_status
    set_color normal
  else
    echo -e -n -s '❯ ' $normal
  end
end
