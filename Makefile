DIR := ${CURDIR}

dotfiles:
	rcup -x Makefile

nuke:
	rcdn

link_xcode:
	ln -sfv ${DIR}/prefs/Xcode/FontAndColorThemes/* ~/Library/Developer/Xcode/UserData/FontAndColorThemes

