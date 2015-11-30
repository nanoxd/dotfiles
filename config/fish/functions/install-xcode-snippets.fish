function install-xcode-snippets -d "Install Xcode snippets in ~/dev/xcode-snippets"
  echo "Removing CodeSnippet directory"
  rm -rf ~/Library/Developer/Xcode/UserData/CodeSnippets
  echo "Linking synced code snippets"
  ln -s ~/.dotfiles/apps/Xcode/CodeSnippets ~/Library/Developer/Xcode/UserData/CodeSnippets
end
