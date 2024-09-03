if command -q eza
    function ls
        eza $argv
    end
end