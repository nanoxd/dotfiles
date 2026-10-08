if command -q brew
    command brew shellenv fish | source
else
    for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew
        if test -x "$brew_bin"
            "$brew_bin" shellenv fish | source
            break
        end
    end
end
