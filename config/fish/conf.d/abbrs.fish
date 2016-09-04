if not set -q fish_initialized
  # Editors
  abbr -a a atom
  abbr -a e nvim

  # Homebrew | Cask
  abbr -a bi brew install
  abbr -a bci brew cask install
  abbr -a bcs brew cask search
  abbr -a bcu brew cask uninstall

  # Git Abbreviations
  abbr -a g git
  abbr -a ga git add
  abbr -a gaa git add --all
  abbr -a gaap git add --all --patch
  abbr -a gc git commit -v
  abbr -a gca git commit -v --amend
  abbr -a gcb git create-branch
  abbr -a gcl git clone
  abbr -a gco git checkout
  abbr -a gd git diff
  abbr -a gdc git diff --cached
  abbr -a gdw git diff --word-diff
  abbr -a gp git push
  abbr -a gpr git pull-request --browse
  abbr -a gpu git pull --rebase
  abbr -a gs git status -sb
  abbr -a gt gittower .

  # Ruby
  abbr -a be bundle exec
  abbr -a bu bundle update
  abbr -a gi gem install
  abbr -a gu gem update

  # Node
  abbr -a ni npm install
  abbr -a nis npm install --save
  abbr -a nisd npm install --save-dev
  abbr -a npmu npm-check -u
  abbr -a nr npm run

  abbr -a pi bundle exec pod install
  abbr -a pu bundle exec pod update

  set -U fish_initialized
end
