# SOLARIZED HEX     TERMCOL
# --------- ------- -------
# base03    #002b36 brblack
# base02    #073642 black
# base01    #586e75 brgreen
# base00    #657b83 bryellow
# base0     #839496 brblue
# base1     #93a1a1 brcyan
# base2     #eee8d5 white
# base3     #fdf6e3 brwhite
# yellow    #b58900 yellow
# orange    #cb4b16 brred
# red       #dc322f red
# magenta   #d33682 magenta
# violet    #6c71c4 brmagenta
# blue      #268bd2 blue
# cyan      #2aa198 cyan
# green     #859900 green

set -l base03 "--bold black"
set -l base02 "black"
set -l base01 "--bold green"
set -l base00 "--bold yellow"
set -l base0 "--bold blue"
set -l base1 "--bold cyan"
set -l base2 "white"
set -l base3 "--bold white"
set -l yellow "yellow"
set -l orange "--bold red"
set -l red "red"
set -l magenta "magenta"
set -l violet "--bold magenta"
set -l blue "blue"
set -l cyan "cyan"
set -l green "green"

set -g fish_color_normal $base0
set -g fish_color_command $base0
set -g fish_color_quote $cyan
set -g fish_color_redirection $base0
set -g fish_color_end $base0
set -g fish_color_error $red
set -g fish_color_param $blue
set -g fish_color_comment $base01
set -g fish_color_match $cyan
set -g fish_color_search_match "--background=$base02"
set -g fish_color_operator $orange
set -g fish_color_escape $cyan

# Used by fish_prompt
set -g fish_color_host $yellow
set -g fish_color_cwd $cyan
set -g fish_color_prompt_symbol $magenta
