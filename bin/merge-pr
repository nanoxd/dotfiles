#!/bin/bash

if [[ -z "$1" ]]; then
  echo " => Usage: $0 user:branch"
  exit 64
fi

user=$(cut -d ":" -f1 <(echo "$1"))
repo="homebrew-cask"
branch=$(cut -d ":" -f2 <(echo "$1"))

if ls | grep -q brew-cask.rb; then
  echo -n " => Switch to master… "
  if git checkout master; then
    echo "OK"
  else
    echo " => Git error"
    exit 69
  fi
else
  echo " => We’re not at root of $repo"
  exit 64
fi

echo " => Fetch $1"
git fetch "git://github.com/$user/$repo" "$branch"

sha=$(git rev-parse --verify FETCH_HEAD)
echo " => SHA: $sha"

echo " => Cherry-pick commit to master"
git cherry-pick "$sha"

echo "git commit --amend --signoff" | pbcopy

echo " => You can now look around and finish the merge"
echo " => Use: git commit --amend --signoff (just ⌘ + V)"
echo " => "
echo " => Format for commit message is usually:"
echo " => "
echo " => Software Name 1.2.3"
echo " => "
echo " => Closes #123."
echo " => "
echo " => Signed-off by: John Doe <john@doe.com>"

exit 0
