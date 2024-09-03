if command -q eza
    function l
        ls -a $argv
    end
else
    function l --wraps='ls -At' --description 'alias l ls -At'
        ls -At $argv
    end
end