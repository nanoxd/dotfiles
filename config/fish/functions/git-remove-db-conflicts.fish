function git-remove-db-conflicts -d "Removes Dropbox Conflict nodes"
  find . -name '*(*conflicted copy*)*' | sed 's/.*/"&"/' | xargs rm 
end
