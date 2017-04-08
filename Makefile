dotfiles:
	rcup -x apps -x Makefile -x vscode-extensions

vscode-save:
	code --list-extensions > vscode-extensions
