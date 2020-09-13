if &compatible
  set nocompatible
endif

function! InstallPackager() abort
  if has('nvim')
    silent !git clone https://github.com/kristijanhusak/vim-packager
          \ ~/.config/nvim/pack/packager/opt/vim-packager
  else
    silent !git clone https://github.com/kristijanhusak/vim-packager ~/.vim/pack/packager/opt/vim-packager
  endif
endfunction

" Load packager only when needed
function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call packager#add('sheerun/vim-polyglot')

  " Vim Enhancements
  call packager#add('AndrewRadev/splitjoin.vim')
  call packager#add('andymass/vim-matchup')
  call packager#add('danro/rename.vim')
  call packager#add('jiangmiao/auto-pairs')
  call packager#add('nelstrom/vim-visual-star-search')
  call packager#add('tpope/vim-abolish')
  call packager#add('tpope/vim-commentary')
  call packager#add('tpope/vim-surround')
  call packager#add('tpope/vim-vinegar')
  call packager#add('norcalli/nvim-colorizer.lua', { 'type': 'opt' })
  call packager#add('FooSoft/vim-argwrap')
  call packager#add('junegunn/rainbow_parentheses.vim')
  call packager#add('tpope/vim-repeat')
  call packager#add('justinmk/vim-sneak')
  call packager#add('mhinz/vim-signify')
  call packager#add('romainl/vim-qf')

  " Text Objects
  call packager#add('kana/vim-textobj-user')
  call packager#add('beloglazov/vim-textobj-quotes')
  call packager#add('Julian/vim-textobj-variable-segment')

  " Tools
  call packager#add('christoomey/vim-conflicted')
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('junegunn/fzf', { 'do': './install --all && ln -s $(pwd) ~/.fzf'})
  call packager#add('junegunn/fzf.vim')
  call packager#add('rhysd/committia.vim')
  call packager#add('tpope/vim-fugitive')
  call packager#add('editorconfig/editorconfig-vim')
  call packager#add('honza/vim-snippets')
  call packager#add('vim-test/vim-test')
  call packager#add('rhysd/clever-f.vim')

  "Loaded only for specific filetypes on demand. Requires autocommands below.
  call packager#add('fatih/vim-go', { 'do': ':GoInstallBinaries', 'type': 'opt' })
  call packager#add('neoclide/coc.nvim', { 'do': function('InstallCoc') })
  call packager#add('Chiel92/vim-autoformat')
  call packager#add('pest-parser/pest.vim')

  " UI
  call packager#add('itchyny/lightline.vim')
  call packager#add('jacoborus/tender.vim')
endfunction

function! InstallCoc(plugin) abort
  exe '!cd '.a:plugin.dir.' && yarn install'
  call coc#add_extension('coc-eslint', 'coc-pyls', 'coc-rust-analyzer', 'coc-tsserver', 'coc-html', 'coc-css', 'coc-json', 'coc-snippets', 'coc-elixir', 'coc-explorer')
endfunction

command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()
command! InstallPackager call InstallPackager()

"Load plugins only for specific filetype
"Note that this should not be done for plugins that handle their loading using ftplugin file.
"More info in :help pack-add
augroup packager_filetype
  autocmd!
  autocmd FileType go packadd vim-go
augroup END

""" General
let mapleader=" "
set ruler
set mouse=a " Enable mouse support
set hidden " The current buffer can be backgrounded without saving
set cmdheight=2 " More space for displaying messages
set pumheight=12 " Makes popup menu smaller
set showcmd " display incomplete commands
set iskeyword+=- " Set Hyphen as part of a text object

" Split settings:
set splitbelow " Horizontal splits will automatically be below
set splitright " Vertical splits will automatically be to the right
set winwidth=84
set winheight=10
set winminheight=10
autocmd BufWritePost $MYVIMRC nested source $MYVIMRC

" Whitespace
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set smartindent
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list " Show “invisible” characters
set ffs=unix,dos,mac " Default file types

" Turns off swap files
set nobackup
set nowritebackup
set noswapfile
set autoread " When file is written to outside of vim, read again

" Persistent Undo
" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
  set undodir=~/.config/nvim/backups
  set undofile
endif

""" Display

" Adds 24bit color support
if has('termguicolors')
  set termguicolors
endif
set noshowmode
set relativenumber
set number
set lazyredraw " reduced screen flicker

syntax on
set t_Co=256
set cursorline
colorscheme tender

" Allow transparency
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

if has('nvim')
  augroup term
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup END
endif

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ],
      \ },
      \ 'colorscheme': 'tender',
      \ 'mode_map': {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'VL',
      \ "\<C-v>": 'VB',
      \ 'c' : 'C',
      \ 's' : 'S',
      \ 'S' : 'SL',
      \ "\<C-s>": 'SB',
      \ 't': 'T',
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" Sensible side scrolling, makes it like other editors.
" Reduce scroll jump with cursor goes off the screen.
set sidescroll=1
set sidescrolloff=3

" Search
set ignorecase " Case insensitve pattern matching
set smartcase " Override ignorecase if pattern contains upcase

"""
" Set ripgrep as grep engine
set grepprg=rg\ --column\ --no-heading\ --smart-case\ --follow\ --vimgrep
set grepformat=%f:%l:%c:%m,%f:%l:%m

" Netrw
let g:netrw_banner = 0 " hide banner
let g:netrw_list_hide='.*\.swp$,\.DS_Store' " hide swp, DS_Store files
let g:netrw_liststyle=3 " set tree style listing
let g:netrw_sort_options='i' " case insensitive

""" Mappings

" make `-` and `_` work like `o` and `O` without leaving you stuck in insert
nnoremap - o<esc>
nnoremap _ O<esc>

" Expand %% into the directory of the current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Save with sudo
cmap w!! %!sudo tee > /dev/null %

" Yank text to the OS X clipboard
noremap <leader>y "*y

nnoremap gV `[v`] " highlight last inserted text

" Generate new vertical split
nnore map <silent> vv <C-w>v

" Smart `0`
" `0` goes to the beginning of the text on first press and to the beginning
" of the line on second press. It alternates afterwards.
nnoremap <expr> 0 virtcol('.') - 1 <= indent('.') && col('.') > 1 ? '0' : '_'

" nmap <C-p> :Files<CR>
nmap <C-g> :GFiles<CR>
nmap <leader>; :Buffers<CR>
nmap <C-t> :Tags<CR>
nnoremap \ :Rg<space>

" Ignore mappings
nmap Q <silent>
nmap q: <silent>

nnoremap <silent> <leader>w :ArgWrap<CR>

autocmd FileType rust set expandtab tabstop=4 softtabstop=4 shiftwidth=4
" autocmd FileType rust nmap <leader>t :RustTest<CR>

""" vim-polyglot
let g:vim_markdown_conceal = 0 " Remove concealing in vim-markdown

""" coc.vim

set updatetime=100
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set signcolumn=auto:1

" Older version that would move through items in list
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Completion
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Introduce function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:coc_float_scroll(forward) abort
  let float = coc#util#get_float()
  if !float | return '' | endif
  let buf = nvim_win_get_buf(float)
  let buf_height = nvim_buf_line_count(buf)
  let win_height = nvim_win_get_height(float)
  if buf_height < win_height | return '' | endif
  let pos = nvim_win_get_cursor(float)
  if a:forward
    if pos[0] == 1
      let pos[0] += 3 * win_height / 4
    elseif pos[0] + win_height / 2 + 1 < buf_height
      let pos[0] += win_height / 2 + 1
    endif
    let pos[0] = pos[0] < buf_height ? pos[0] : buf_height
  else
    if pos[0] == buf_height
      let pos[0] -= 3 * win_height / 4
    elseif pos[0] - win_height / 2 + 1  > 1
      let pos[0] -= win_height / 2 + 1
    endif
    let pos[0] = pos[0] > 1 ? pos[0] : 1
  endif
  call nvim_win_set_cursor(float, pos)
  return ''
endfunction

nnoremap <silent><expr> <down> coc#util#has_float() ? coc#util#float_scroll(1) : "\<down>"
nnoremap <silent><expr> <up> coc#util#has_float() ? coc#util#float_scroll(0) : "\<up>"
inoremap <silent><expr> <down> coc#util#has_float() ? <SID>coc_float_scroll(1) : "\<down>"
inoremap <silent><expr> <up> coc#util#has_float() ? <SID>coc_float_scroll(0) : "\<up>"
vnoremap <silent><expr> <down> coc#util#has_float() ? <SID>coc_float_scroll(1) : "\<down>"
vnoremap <silent><expr> <up> coc#util#has_float() ? <SID>coc_float_scroll(0) : "\<up>"

" " Show all diagnostics.
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>

" Display Explorer
:nmap <space>e :CocCommand explorer<CR>

""" fzf

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_follow_symlinks = get(g:, 'fzf_follow_symlinks', 0)
let s:fzf_files_command     = 'rg --color=never --hidden --files --glob "!.git/*"'
let s:fzf_all_files_command = 'rg --color=never --no-ignore --hidden --files'
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

function! s:fzf_file_preview_options(bang) abort
  return fzf#vim#with_preview('right:60%:hidden', '?')
endfunction

function! s:build_fzf_options(command, bang) abort
  let cmd = g:fzf_follow_symlinks ? a:command . ' --follow' : a:command
  return extend(s:fzf_file_preview_options(a:bang), { 'source': cmd })
endfunction

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, s:build_fzf_options(s:fzf_files_command, <bang>0), <bang>0)

command! -bang -nargs=? -complete=dir AFiles
      \ call fzf#vim#files(<q-args>, s:build_fzf_options(s:fzf_all_files_command, <bang>0), <bang>0)

function! g:FzfFilesSource()
  let l:base = fnamemodify(expand('%'), ':h:.:S')
  let l:proximity_sort_path = $HOME . '/.cargo/bin/proximity-sort'

  if base == '.'
    return 'rg --files'
  else
    return printf('rg --files | %s %s', l:proximity_sort_path, expand('%'))
  endif
endfunction

" ctrl p brings up the file finder
noremap <C-p> :call fzf#vim#files('', {
      \ 'source': g:FzfFilesSource(),
      \ 'options': '--tiebreak=index'})<CR>

" nvim-colorizer.lua
packadd nvim-colorizer.lua
lua require 'colorizer'.setup()

" Rainbow-Parentheses
au VimEnter * RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow_conf = {
\ 'guifgs': ['#858580', '#8FBCBB', '#D08770', '#A3BE8C', '#EBCB8B', '#B48EAD', '#80a880', '#887070'],
\ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\ 'guis': [''],
\ 'cterms': [''],
\ 'operators': '_,_',
\ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\ 'separately': {
\   '*': {},
\   'markdown': {
\     'parentheses_options': 'containedin=markdownCode contained', 
\   },
\   'lisp': {
\     'guifgs': ['#858580', '#8FBCBB', '#D08770', '#A3BE8C', '#EBCB8B', '#B48EAD', '#80a880', '#887070'],
\   },
\   'jsx': {
\     'guifgs': ['#858580', '#8FBCBB', '#D08770', '#A3BE8C', '#EBCB8B', '#B48EAD', '#80a880', '#887070'],
\   },
\   'haskell': {
\     'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
\   },
\   'vim': {
\     'parentheses_options': 'containedin=vimFuncBody', 
\   },
\   'perl': {
\     'syn_name_prefix': 'perlBlockFoldRainbow', 
\   },
\   'stylus': {
\     'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'], 
\   },
\   'css': 0, 
\ }
\}

" vim-sneak
let g:sneak#label = 1

" vim-autoformat
autocmd BufWrite * :Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

" auto-pairs
let g:AutoPairsMapCh = 0

" Arglists
function! s:ThankYouNext() abort
  update
  argdelete %
  bdelete
  if !empty(argv())
    argument
  endif
endfunction

command! ThankYouNext call <sid>ThankYouNext()

" vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>

" Remap explore
command! E Explore

" Setup and enclose all changes
if exists('g:vscode')
  source $HOME/.config/nvim/vscode.vim
  " Simulate same TAB behavior in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>
endif

