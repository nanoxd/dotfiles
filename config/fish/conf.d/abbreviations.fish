status is-interactive; or exit

abbr -a co code

abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'

# macOS-only
if test (uname) = Darwin
    abbr -a bi brew install
    type -q fork; and abbr -a f fork
end

# Git
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

type -q docker; and abbr -a dc docker compose
type -q trash; and abbr -a rm trash
