if command -q eza
    function lt
        ls -Tlh -L 2 --git --git-ignore $argv
    end
end