function bclean -d "Cleanup brew packages"
  brew cleanup
  and brew prune
end
