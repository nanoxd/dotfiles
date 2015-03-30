function gfum -d "Git fetch upstream master and merge"
  git fetch upstream master
  and git merge upstream/master
end
