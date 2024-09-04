function gpc -d "Git push and set branch to origin"
  git push --set-upstream origin (git-branch-current 2> /dev/null)
end
