set -l base03  002b36
set -l base02  "black"
set -l base01  586e75
set -l base00  657b83
set -l base0   839496
set -l base1   93a1a1
set -l base2   "white"
set -l base3   fdf6e3
set -l yellow  "yellow"
set -l orange  cb4b16
set -l red     "red"
set -l magenta "magenta"
set -l violet  6c71c4
set -l blue    "blue"
set -l cyan    "cyan"
set -l green   "green"

# Used by fish's completion; see
# http://fishshell.com/docs/2.0/index.html#variables-color

set -g fish_color_normal      $base0
set -g fish_color_command     $violet
set -g fish_color_quote       $cyan
set -g fish_color_redirection $base0
set -g fish_color_end         $base0
set -g fish_color_error       $red
set -g fish_color_param       $blue
set -g fish_color_comment     $base01
set -g fish_color_match       $cyan
set -g fish_color_search_match "--background=$base02"
set -g fish_color_operator    $orange
set -g fish_color_escape      $cyan

# Used by fish_prompt

set -g fish_color_hostname    $cyan
set -g fish_color_cwd         $green
set -g fish_color_git         $magenta
