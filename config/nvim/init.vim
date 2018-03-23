" Basics Settings {{{
scriptencoding utf-8
let mapleader = " "

set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set ruler
set showcmd    " display incomplete commands
set relativenumber
set number
set hidden     " The current buffer can be backgrounded without saving
set cursorline " Highlight current line

set noerrorbells visualbell t_vb= " turn off bell on ESC
set synmaxcol=1000 " Don't try to highlight lines longer than X
set lazyredraw    " reduced screen flicker

" Search
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

" Sensible side scrolling, makes it like other editors.
" Reduce scroll jump with cursor goes off the screen.
set sidescroll=1
set sidescrolloff=3

set shell=/usr/local/bin/zsh

" Persistent Undo
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
  set undodir=~/.config/nvim/backups
  set undofile
endif

" When vimrc is edited, reload it
autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim

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

map <leader>w :w<cr>
" Fast saving

" Remove whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" highlight last inserted text
nnoremap gV `[v`]

source ~/.config/nvim/plugins.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Look, Style, and Feel
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Adds 24bit color support
if has('termguicolors')
  set termguicolors
elseif has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

colorscheme deep-space
let g:airline_theme = 'deep_space'
let g:airline#extensions#tabline#enabled = 1

" Whitespace defaults
set smartindent
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list " Show “invisible” characters

function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=78
endfunction

function! s:disableWhiteSpaceChecking()
  let b:airline_whitespace_disabled = 1
endfunction

highlight ColorColumn ctermbg=green
call matchadd('ColorColumn', '\%81v', 100)

""""Language specific whitespace

autocmd FileType make set noexpandtab " make uses real tabs

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Procfile,Thorfile,Brewfile,Dangerfile,config.ru}  set ft=ruby

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
autocmd BufRead,BufNewFile *.{pl,cgi} call s:disableWhiteSpaceChecking()
autocmd BufRead,BufNewFile *.{pl,cgi} set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

runtime! macros/matchit.vim    " % to bounce from do to end etc.
set ffs=unix,dos,mac           " Default file types
set noeb vb t_vb=              " Disable beeps and flashes
let g:syntastic_enable_signs=1 " Enable syntastic syntax checking

" Remember last location in file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-tmux issue: https://github.com/neovim/neovim/issues/2048
if has('nvim')
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif

let g:netrw_banner = 0                      " hide banner
let g:netrw_list_hide='.*\.swp$,\.DS_Store' " hide swp, DS_Store files
let g:netrw_liststyle=3                     " set tree style listing
let g:netrw_sort_options='i'                " case insensitive
