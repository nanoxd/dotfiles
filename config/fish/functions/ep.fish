function ep -d "Open Editor with FZF file search"
  if test (count $argv) -gt 0
    command $EDITOR $argv
  else
    fzf -m | xargs $EDITOR
  end
end
