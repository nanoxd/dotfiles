if not set -q GOPATH; or test -z "$GOPATH"
    set -gx GOPATH "$HOME/go"
end
for go_path in (string split : -- "$GOPATH")
    if test -n "$go_path"
        fish_add_path --path --append "$go_path/bin"
    end
end
