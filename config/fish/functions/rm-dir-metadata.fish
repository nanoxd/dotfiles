function rm-dir-metadata -d "Remove .DS_Store and ._* files"
  find . -name ".DS_Store" -or -name "._*" -delete
end
