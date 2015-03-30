test -f /usr/local/share/fish/completions/git.fish; and source /usr/local/share/fish/completions/git.fish

## Hub
# hub create
complete -f -c git -n '__fish_git_needs_command' -a create -d 'Create this repository on GitHub and add GitHub as origin'
complete -f -c git -n '__fish_git_using_command create' -s p -d 'Create this repository as private'
complete -f -c git -n '__fish_git_using_command create' -s d -d "Set this repository's description"
complete -f -c git -n '__fish_git_using_command create' -s h -d "Set this repository's homepage"

# hub pull-request
complete -f -c git -n '__fish_git_needs_command' -a pull-request -d 'Open a pull request on GitHub'
complete -f -c git -n '__fish_git_using_command pull-request' -s f -d "Don't check for outgoing changes"
complete -f -c git -n '__fish_git_using_command pull-request' -s o -l browse -d 'Open the pull request in a web browser'
complete -f -c git -n '__fish_git_using_command pull-request' -s i -r -d 'The issue (ID or URL) to convert to a pull request'
complete -f -c git -n '__fish_git_using_command pull-request' -s b -r -d 'The base repository to use in the pull request'
complete -f -c git -n '__fish_git_using_command pull-request' -s h -r -d 'The head to use in the pull request'

# hub fork
complete -f -c git -n '__fish_git_needs_command' -a fork -d 'Make a fork of a remote repository on GitHub and add as remote'
complete -f -A -c git -n '__fish_git_using_command fork' -l no-remote -d 'Skips creation of the new remote'

# hub browse
complete -f -c git -n '__fish_git_needs_command' -a browse -d 'Open a GitHub page in the default browser'
complete -f -c git -n '__fish_git_using_command browse' -s u -d 'The user that owns the repository to browse'

# hub compare
complete -f -c git -n '__fish_git_needs_command' -a compare -d 'Open a compare page on GitHub'
complete -f -c git -n '__fish_git_using_command compare' -s u -d 'The user that owns the repository to compare'

# hub ci-status
complete -f -c git -n '__fish_git_needs_command' -a ci-status -d 'Display latest status of CI'
complete -f -c git -n '__fish_git_using_command ci-status' -s v -d 'Print the URL to CI build results'

## Git-extras
# alias back commits-since contrib
# delete-tag fresh-branch gh-pages graft info local-commits release rename-tag repl
# setup show-tree squash summary touch
complete -f -c git -n '__fish_git_needs_command' -a alias -d 'Define, search and show aliases'
complete -f -c git -n '__fish_git_needs_command' -a back -d 'Undo and stage latest commits'
complete -f -c git -n '__fish_git_needs_command' -a commits-since -d 'Show commit logs since date'
complete -f -c git -n '__fish_git_needs_command' -a contrib -d 'Show users contributions'
complete -f -c git -n '__fish_git_needs_command' -a delete-submodule -d 'Delete submodules'
complete -f -c git -n '__fish_git_needs_command' -a delete-tag -d 'Delete local and remote tags'
complete -f -c git -n '__fish_git_needs_command' -a fresh-branch -d 'Create empty local branch'
complete -f -c git -n '__fish_git_needs_command' -a gh-pages -d 'Create the GitHub Pages branch with an initial index.html file'
complete -f -c git -n '__fish_git_needs_command' -a graft -d 'Merge and destroy a given branch'
complete -f -c git -n '__fish_git_needs_command' -a info -d 'Returns info on current repository'
complete -f -c git -n '__fish_git_needs_command' -a local-commits -d 'List local commits'
complete -f -c git -n '__fish_git_needs_command' -a release -d 'Commit, tag, and push changes to the repository'
complete -f -c git -n '__fish_git_needs_command' -a rename-tag -d 'Rename a tag'
complete -f -c git -n '__fish_git_needs_command' -a repl -d 'git read-eval-print-loop'
complete -f -c git -n '__fish_git_needs_command' -a setup -d 'Set up a git repository'
complete -f -c git -n '__fish_git_needs_command' -a show-tree -d 'Show branch tree of commit history'
complete -f -c git -n '__fish_git_needs_command' -a squash -d 'Import changes from a branch'
complete -f -c git -n '__fish_git_needs_command' -a summary -d 'Show repository summary'
complete -f -c git -n '__fish_git_needs_command' -a touch -d 'Touch and add file to the index'

# git-bug
complete -f -c git -n '__fish_git_needs_command' -a bug -d 'Create bug branch'
complete -f -A -c git -n '__fish_git_using_command bug' -a finish -d 'Merge and delete the bug branch'

# git-changelog
complete -f -c git -n '__fish_git_needs_command' -a changelog -d 'Generate the changelog report'
complete -f -c git -n '__fish_git_using_command changelog' -s l -l list -d 'Show commit logs from the current version'
complete -f -c git -n '__fish_git_using_command changelog' -l no-merges -d 'Filter out merge commits'

# git-count
complete -f -c git -n '__fish_git_needs_command' -a count -d 'Show commit count'
complete -f -c git -n '__fish_git_using_command count' -l all -d 'Show details'

# git-effort
complete -f -c git -n '__fish_git_needs_command' -a effort -d 'Show effort statistics on file(s)'
complete -f -c git -n '__fish_git_using_command effort' -l above -d 'Ignore files with commits <= a value'

# git-feature
complete -f -c git -n '__fish_git_needs_command' -a feature -d 'Create feature branch'
complete -f -A -c git -n '__fish_git_using_command feature' -a finish -d 'Merge and delete the feature branch'

# git-ignore
complete -f -c git -n '__fish_git_needs_command' -a ignore -d 'Add .gitignore patterns'
complete -f -c git -n '__fish_git_using_command ignore' -s l -l local -d 'Set the context to the local .gitignore file (default)'
complete -f -c git -n '__fish_git_using_command ignore' -s g -l global -d 'Set the context to the global .gitignore file'

# git-refactor
complete -f -c git -n '__fish_git_needs_command' -a refactor -d 'Create refactor branch'
complete -f -A -c git -n '__fish_git_using_command refactor' -a refactor -d 'Merge and delete the refactor branch'

# git-undo
complete -f -c git -n '__fish_git_needs_command' -a undo -d 'Remove latest commits'
complete -f -c git -n '__fish_git_using_command undo' -s h -l hard -d 'Wipe your commit(s). Changes are not recoverable'
complete -f -c git -n '__fish_git_using_command undo' -s s -l soft -d 'Only roll back the commit but changes remain unstaged'
