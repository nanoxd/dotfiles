set -l cargo_bin (set -q CARGO_HOME; and echo $CARGO_HOME/bin; or echo $HOME/.cargo/bin)

if test -d $cargo_bin
    fish_add_path -amg $cargo_bin
else
    _warn_no_command cargo
end
