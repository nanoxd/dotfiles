function fish_prompt -d "Snorin - oh-my-zsh sorin inspired prompt"
    # Main
	printf (set_color cyan)(prompt_pwd)' '

    #Determine if git repo is set...
	if git rev-parse ^ /dev/null
        #still not 100% sure this is correct in case of a rebase conflict...
        git branch -qv | grep "\*" | grep -q detached
            and set -l current_branch (git rev-parse HEAD | cut -c1-7)
            or set -l current_branch (git symbolic-ref --short HEAD)
            or set -l current_branch '???'
        printf (set_color blue)git(set_color brwhite):(set_color red)$current_branch' '
    end

    # print fun part of prompt
    if test -n "$snorin_chevrons"
        for chevron in $snorin_chevrons
            printf (set_color $chevron)'❯'
        end
        printf ' '
    else
        printf (set_color green)'❯ '
    end
    set_color normal
end
