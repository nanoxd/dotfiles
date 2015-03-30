# syncthing.fish created by Fernando Paredes<nano@fdp.io>

complete -c syncthing -f -o home= -d "Set configuration directory"
complete -c syncthing -A -f -o logflags= -d "Set log flags"
complete -c syncthing -A -f -o reset -d "Prepare to resync from cluster"
complete -c syncthing -A -f -o upgrade -d "Perform upgrade"
complete -c syncthing -A -f -o version -d "Show version"
