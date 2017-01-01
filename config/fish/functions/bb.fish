function bb -d "Update and upgrade brew packages"
  brew update
  and brew upgrade
  and bclean
end
