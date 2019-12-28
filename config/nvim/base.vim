
scriptencoding utf-8

set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set ruler
set showcmd    " display incomplete commands
set relativenumber
set number
set hidden     " The current buffer can be backgrounded without saving
set cursorline " Highlight current line
set mouse=a " Enable mouse support

" Whitespace defaults
set smartindent
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list " Show “invisible” characters
set ffs=unix,dos,mac           " Default file types

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
set autoread " When file is written to outside of vim, read again

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

if exists('$TMUX')
    set clipboard=
  else
    set clipboard=unnamed "sync with OS clipboard
endif

" Adds 24bit color support
if has('termguicolors')
  set termguicolors
elseif has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Set ripgrep as grep engine
set grepprg=rg\ --vimgrep
set grepformat^=%f:%l:%c:%m

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language Changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make {{{
autocmd FileType make set noexpandtab " Use Tabs
" }}}

" Ruby {{{
autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Procfile,Thorfile,Brewfile,Dangerfile,config.ru,Fastfile}  set ft=ruby
" }}}

" Set Sass files as sass autocmd BufRead,BufNewFile *.scss set filetype=scss

autocmd BufRead,BufNewFile *.txt call s:setupWrapping()

" Python {{{
autocmd FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
" }}}

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Markdown {{{
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
" }}}

" Go {{{
autocmd BufRead,BufNewFile *.go set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" }}}

" Perl {{{
autocmd BufRead,BufNewFile *.{pl,cgi} call s:disableWhiteSpaceChecking()
autocmd BufRead,BufNewFile *.{pl,cgi} set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" }}}

" Remember last location in file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:netrw_banner = 0                      " hide banner
let g:netrw_list_hide='.*\.swp$,\.DS_Store' " hide swp, DS_Store files
let g:netrw_liststyle=3                     " set tree style listing
let g:netrw_sort_options='i'                " case insensitive

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets only once the value of g:env to the running environment
" from romainl
" https://gist.github.com/romainl/4df4cde3498fada91032858d7af213c2
function! Config_setEnv() abort
  if exists('g:env')
    return
  endif

  if has('win64') || has('win32') || has('win16')
    let g:env = 'WINDOWS'
  else
    let g:env = toupper(substitute(system('uname'), '\n', '', ''))
  endif
endfunction

