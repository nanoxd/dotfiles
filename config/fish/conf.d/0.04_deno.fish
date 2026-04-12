set -gx DENO_INSTALL $HOME/.deno

if test -d $DENO_INSTALL/bin
    fish_add_path -amg $DENO_INSTALL/bin
else
    _warn_no_command deno
end
