let mapleader = " "

" make `-` and `_` work like `o` and `O` without leaving you stuck in insert
nnoremap - o<esc>
nnoremap _ O<esc>

" Turn off the christmas lights
nnoremap <Leader><cr> :nohlsearch<cr>

" Expand %% into the directory of the current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Save with sudo
cmap w!! %!sudo tee > /dev/null %

" Yank text to the OS X clipboard
noremap <leader>y "*y

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" Fast saving
map <leader>w :w<cr>

" Remove whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" highlight last inserted text
nnoremap gV `[v`]

" Vim-tmux issue: https://github.com/neovim/neovim/issues/2048
if has('nvim')
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif

command! ProjectFiles call fzf#run(fzf#wrap({'source': 'git ls-files -co --exclude-standard'}))
nnoremap <leader>p :ProjectFiles<CR>