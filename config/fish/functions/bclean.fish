function bclean -d "Cleanup brew packages"
  brew cleanup
  and brew cask cleanup
  and brew prune
end
