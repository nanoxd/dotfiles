"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "

set nocompatible " No reason to limit ourselves to vi compatibility
set ruler
set history=3000
set showcmd       " display incomplete commands
set laststatus=2
set noshowmode " Hide the default mode text
set relativenumber
set number
set autoread " Reload files changed outside vim
set hidden " The current buffer can be put to the background without writing to disk;
set cursorline " Highlight current line
set wildmenu " Autocomplete for command mode

" Search
set incsearch  " Highlight while searching
set hlsearch   " Highlight all matches after entering search pattern
set ignorecase " Case insensitve pattern matching
set smartcase  " Override ignorecase if pattern contains upcase

" Split settings:
set winwidth=84
set winheight=10
set winminheight=10
set winheight=999

" Turns off swap files
set nobackup
set nowritebackup
set noswapfile

set shell=/bin/zsh

" Persistent Undo
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Set encoding
set encoding=utf-8

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" make `-` and `_` work like `o` and `O` without leaving you stuck in insert
nnoremap - o<esc>
nnoremap _ O<esc>

" Turn off the christmas lights
nnoremap <Leader><cr> :nohlsearch<cr>

" Expand %% into the directory of the current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Save with sudo
cmap w!! %!sudo tee > /dev/null %

if exists('$TMUX')
    set clipboard=
  else
    set clipboard=unnamed                             "sync with OS clipboard
endif

" Yank text to the OS X clipboard
noremap <leader>y "*y

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" Fast saving
map <leader>w :w<cr>

" Remove whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" Convert 1.8 Ruby hashes to 1.9+
nnoremap <F12> :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<return>

" Plugins "
source ~/.vimrc.plugins

autocmd FileType go nmap <Leader>g :w\|:!go run %<cr>

"" CtrlP
" Adds ; as the Ctrl+P fuzzy search
nmap ; :CtrlPBuffer<CR>
" Show the damn dotfiles
let g:ctrlp_show_hidden = 1

let g:rspec_command = "!rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" SplitJoin
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Look, Style, and Feel
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
colorscheme solarized
set background=dark
call togglebg#map("<F5>")
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1

set guifont=Ubuntu\ Mono\ derivative\ Powerline:h18

" Whitespace defaults
set autoindent
set smartindent
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" Show “invisible” characters
set list
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=78
endfunction

highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', 100)

""""Language specific whitespace

" make uses real tabs
autocmd FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Procfile,Thorfile,config.ru}  set ft=ruby

" Set Sass files as sass
autocmd BufRead,BufNewFile *.scss set filetype=scss

autocmd BufRead,BufNewFile *.txt call s:setupWrapping()

" make Python follow PEP8
autocmd FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Markdown files end in .md
autocmd BufRead,BufNewFile *.md set filetype=markdown
" Enable spellchecking for Markdown
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell

" Set syntax for Go
autocmd BufRead,BufNewFile *.go set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" % to bounce from do to end etc.
runtime! macros/matchit.vim

set ffs=unix,dos,mac "Default file types

" Disable beeps and flashes
set noeb vb t_vb=

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1

" Remember last location in file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The Silver Searcher
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Generate ctags for Ruby
nmap <silent> <leader>rt :!ctags -R --languages=ruby --exclude=.git --exclude=log . (bundle list --paths)<cr>

" Source custom Solarized settings
source ~/.vim/settings/solarized.vim
