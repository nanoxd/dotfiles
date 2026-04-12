if command -q eza
    function ls --wraps eza
        eza $argv
    end

    function l --wraps eza
        eza -a $argv
    end

    function la --wraps eza
        eza -la --smart-group $argv
    end

    function ll --wraps eza
        eza -l --smart-group $argv
    end

    function lt --wraps eza
        eza -Tlh -L 2 --git --git-ignore $argv
    end
else
    _warn_no_command eza

    function l
        command ls -At $argv
    end

    function la
        command ls -hlt $argv
    end

    function ll
        command ls -hlt $argv
    end
end
