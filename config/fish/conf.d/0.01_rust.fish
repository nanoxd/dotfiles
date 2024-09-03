if set -q CARGO_HOME
    fish_add_path -amg $CARGO_HOME/bin
else if test -d $HOME/.cargo/bin
    fish_add_path -amg $HOME/.cargo/bin
else
    _warn_no_command cargo
end