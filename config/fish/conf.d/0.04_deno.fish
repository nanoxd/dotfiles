if not set -q DENO_INSTALL; or test -z "$DENO_INSTALL"
    set -gx DENO_INSTALL "$HOME/.deno"
end
fish_add_path --path --append "$DENO_INSTALL/bin"
