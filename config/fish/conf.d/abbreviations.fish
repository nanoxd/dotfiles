function mac_abbr
  # Check if the operating system is macOS
  if test (uname) = "Darwin"
      # Pass all arguments to the abbr command
      abbr $argv
  end
end

abbr -a co code

if type -q fork
  mac_abbr -a f fork
end

# Homebrew
mac_abbr bi brew install

# Git
if type -q git
  abbr -a g git
  abbr -a ga git add
  abbr -a gaa git add --all
  abbr -a gaap git add --all --patch
  abbr -a gc git commit
  abbr -a gca git commit --amend
  abbr -a gcan git commit --amend --no-edit
  abbr -a gcb git switch -c
  abbr -a gcl git clone
  abbr -a gco git checkout
  abbr -a gd git diff
  abbr -a gdc git diff --cached
  abbr -a gdw git diff --word-diff
  abbr -a gin git introduced
  abbr -a gp git push
  abbr -a gpf git push --force-with-lease
  abbr -a gpom git pull origin main --rebase
  abbr -a gpr git pull-request --browse
  abbr -a gpu git pull --rebase
  abbr -a gs git status -sb
end

# Bun
if type -q bun
  abbr -a b bun
  abbr -a ba bun add
  abbr -a bad bun add -d
  abbr -a by bun install
  abbr -a br bun run
end

# Cargo
if type -q cargo
  abbr -a c cargo
  abbr -a cr cargo run
  abbr -a ct cargo test
end

if type -q docker
    abbr dc docker compose
end

if type -q trash
  abbr -a rm trash
end