function p -d "Prints the contents of a directory or file"
    if test (count $argv) -gt 0 && test -f $argv[1] || not isatty
        bat $argv
    else
        eza -lh $argv
    end
end

