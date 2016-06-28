function bb -d "Update and upgrade brew packages"
  brew update
  and brew upgrade --all
  and bclean
end
