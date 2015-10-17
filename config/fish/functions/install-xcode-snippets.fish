function install-xcode-snippets -d "Install Xcode snippets in ~/dev/xcode-snippets"
  set snippets "$HOME/dev/xcode-snippets"
  for snippet in $snippets/*.swift
    xcodesnippet install $snippet
    echo "Installing $snippet"
  end
end
