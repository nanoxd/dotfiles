function fish_right_prompt -d "Snorin - oh-my-zsh sorin inspired prompt - right side"

	# use this to DRY up some code
	function print_symbol
		printf (set_color $argv[1])$argv[2]' '
	end

    # last status
    test $status != 0; and printf (set_color red)"⏎ "

	if git rev-parse ^ /dev/null
        # symbols
		set seen  #only needed to be defined here for clearity

		for i in (git status --porcelain | cut -c 1-2 | uniq | tr -d ' ')
			# duplicates can get in due to the above command, however
			# keeping them out with various `awk`, `tr`, `sort`, etc can get
			# really messy so just do some scripting to get around it here.
			# If you know a clean way of doing this with just basic commands,
			# please PR!
			if not contains $i $seen
				switch $i
					# there's probably a gazillion cases I'm missing
					# but I tried to cover all of the ones I come across
					# in "normal" usage, as well as trying to keep close
					# to the oh-my-zsh source
					case "A"
						print_symbol green ✚
					case "AD"
                    case "D"
						print_symbol red ✖
                    case "RM"
					case "M"
						print_symbol blue ✹
					case "R"
						print_symbol magenta ➜
                    # I can't remember exaclty how to get one of these locally
                    # to test it, probably wrong
					case "*U*"
						print_symbol yellow ═
					case "??"
						print_symbol cyan ✭
				end
				set seen $seen $i
			end
		end
		# `seen` can't be defined as local becuase of how the scoping works
		# so just cleanup here
		set -e seen
	end

	# clean up since there's no way to define a local function in FISH
	# as of Aug 2019
	functions -e print_symbol
end
