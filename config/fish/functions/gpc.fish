function gpc -d "Push current branch and set upstream to origin"
    git push --set-upstream origin (git branch --show-current)
end
