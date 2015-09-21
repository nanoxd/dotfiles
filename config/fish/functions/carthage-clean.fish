function carthage-clean -d "Clean up carthage cache"
  if test -d "$HOME/Library/Caches/org.carthage.CarthageKit"
    rm -rf $HOME/Library/Caches/org.carthage.CarthageKit
    echo "Removing Carthage cache"
  end

  if test -d "$HOME/Library/Developer/Xcode/DerivedData"
    rm -rf $HOME/Library/Developer/Xcode/DerivedData
    echo "Removing Xcode DerivedData"
  end
end
