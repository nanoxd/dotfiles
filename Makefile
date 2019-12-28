DIR := ${CURDIR}

dotfiles:
	rcup -x Makefile

nuke:
	rcdn

link_xcode:
	cp -r ${DIR}/prefs/Xcode/FontAndColorThemes/* ~/Library/Developer/Xcode/UserData/FontAndColorThemes

