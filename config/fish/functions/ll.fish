if command -q eza
    function ll
        ls -l --smart-group $argv
    end
else
    function ll
        ls -hlt $argv
    end
end