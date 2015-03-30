function lndot -d "Link dotfiles to home directory"
  ln -fs (pwd)/$argv ~/.$argv
end
