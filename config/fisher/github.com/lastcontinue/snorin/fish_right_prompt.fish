function fish_right_prompt -d "Snorin - oh-my-zsh sorin inspired prompt - right side"

	# use this to DRY up some code
	function print_symbol
		printf (set_color $argv[1])$argv[2]' '
	end

    # last status
    test $status != 0; and printf (set_color red)"⏎ "

	if git rev-parse ^ /dev/null
        #take advantage of Fish `String` commands
		for i in (git status --porcelain |
                    cut -c 1-2 |
                    string trim |
                    string replace "AM" "A" |
                    string replace "MM" "M" |
                    sort |
                    uniq)
			switch $i
                # There's quite a few cases missing according to
                # https://git-scm.com/docs/git-status
                # but I tried to cover all of the ones I come across
                # in "normal" usage, as well as trying to keep close
                # to the oh-my-zsh source
                # Always double-check your Git status before commiting
                case "AD"
                    #this can happen if you add a file, then delete it after staging the change
                    #IMHO these two just cancel each other out
                case "A"
                    print_symbol green ✚
                case "D"
                    print_symbol red ✖
                case "M"
                    print_symbol blue ✹
                case "R"
                    print_symbol magenta ➜
                case "UU"
                    print_symbol yellow ═
                # this is usually a new file... usually
                case "\?\?"
                    print_symbol cyan ✭
                case "*"
                    print_symbol yellow ◊
                    #if you start getting this a lot,
                    #please open an issue or file a PR
                    #I wanted something generic that didn't really mean "good" or "bad"
            end
		end
	end
end
