if command -q eza
    function la
        ls -la --smart-group $argv
    end
else
    function la
        ls -hlt $argv
    end
end