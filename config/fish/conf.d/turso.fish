if test -d $HOME/.turso
    fish_add_path -amg $HOME/.turso
end

if test -f $HOME/.turso/env.fish
    source $HOME/.turso/env.fish
end
