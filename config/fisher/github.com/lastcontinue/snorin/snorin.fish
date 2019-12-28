#! /bin/env fish
function snorin_random_chevrons -d "randomly sets snorin_chevrons colors for N number of chevrons."
    set -l possible_colors red yellow green blue cyan magenta white brred brmagenta brwhite
    set -l shuf_colors
    #If shuf is installed, use this. Doesn't do duplicates
    if type shuf > /dev/null 2>&1
        set shuf_colors (shuf -i1-10 -n$argv[1])
    #jot is installed by default on MacOS so 'easy win' here. Ocassionaly does duplicates
    else if type jot > /dev/null 2>&1
        set shuf_colors (jot -r $argv[1] 1 10)
    else
        echo "ERROR: either 'shuf' or 'jot' needs to be installed to use this function"
        return 1 
    end
    set color_list
    for c in $shuf_colors
        set color_list $color_list $possible_colors[$c]
    end
    set snorin_chevrons $color_list
    set -e color_list
    echo $snorin_chevrons
end
