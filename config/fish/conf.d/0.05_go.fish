set -gx GOPATH $HOME/go

if test -d $GOPATH/bin
    fish_add_path -amg $GOPATH/bin
else
    _warn_no_command go
end