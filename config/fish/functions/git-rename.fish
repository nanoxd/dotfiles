function git-rename
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='Fernando Paredes'; GIT_AUTHOR_EMAIL='nano@fdp.io'; GIT_COMMITTER_NAME='Fernando Paredes'; GIT_COMMITTER_EMAIL='nano@fdp.io';" HEAD
end

