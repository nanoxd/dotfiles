"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! UpdateRemote(arg)
  UpdateRemotePlugins
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-plug && Plug Specific Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" Languages
Plug 'sheerun/vim-polyglot'

" Tools
Plug 'mhinz/vim-grepper'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/ctags.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Adds automatic closing of quotes
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'christoomey/vim-conflicted'
Plug 'skwp/greplace.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'danro/rename.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'terryma/vim-multiple-cursors'
Plug 'editorconfig/editorconfig-vim'

" Text Objects
Plug 'kana/vim-textobj-user'
Plug 'bootleq/vim-textobj-rubysymbol', { 'for': 'ruby' }
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'coderifous/textobj-word-column.vim'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
" Smarter matchit, extends `%`
" % / g% forward/backwards to next matching open/close word
" [% / ]% go to prev/next surrounding word
" z% go into nearest inner contained block
" a% & i% text objects
" ds% / cs% to delete/change surrounding
" Can also do parallel editing of matches on tags
Plug 'andymass/vim-matchup'
Plug 'rizzatti/funcoo.vim'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'

" Colors
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'rakr/vim-one' " One Dark/Light for Vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Completion
Plug 'ervandew/supertab'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }

Plug 'desmap/ale-sensible' | Plug 'w0rp/ale'
" Plug 'https://github.com/racer-rust/vim-racer'

call plug#end()

" Tagbar
nmap <F8> :TagbarToggle<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" ELm
let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType elixir setlocal omnifunc=elixircomplete#Complete
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Gitgutter
set updatetime=500 " Increase to call gitgutter more often
let g:gitgutter_map_keys = 0

" Fuzzy Finder {{{
" Fzf
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find 
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color=always --max-filesize=3M --threads 4 '.shellescape(<q-args>), 1,
      \ <bang>0)
  " Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

let g:fzf_follow_symlinks = get(g:, 'fzf_follow_symlinks', 0)

function! s:fzf_file_preview_options(bang) abort
  return fzf#vim#with_preview('right:60%:hidden', '?')
endfunction

let s:has_rg = executable('rg')

if s:has_rg
  let s:fzf_files_command     = 'rg --color=never --no-ignore-vcs --hidden --files --glob "!.git/*"'
  let s:fzf_all_files_command = 'rg --color=never --no-ignore --hidden --files'
else
  let s:fzf_files_command     = 'fd --color=never --no-ignore-vcs --hidden --type file'
  let s:fzf_all_files_command = 'fd --color=never --no-ignore --hidden --type file'
endif

function! s:build_fzf_options(command, bang) abort
    let cmd = g:fzf_follow_symlinks ? a:command . ' --follow' : a:command
    return extend(s:fzf_file_preview_options(a:bang), { 'source': cmd })
endfunction

  " Likewise, Files command with preview window
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, s:build_fzf_options(s:fzf_files_command, <bang>0), <bang>0)

command! -bang -nargs=? -complete=dir AFiles
      \ call fzf#vim#files(<q-args>, s:build_fzf_options(s:fzf_all_files_command, <bang>0), <bang>0)

nmap <C-p> :Files<CR>
nmap ; :Buffers<CR>
nmap <C-t> :Tags<CR>
nmap <C-m> :Marks<CR>
nmap <Leader>s :Find<CR>

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }
" }}}

" Rust {{{
let g:racer_cmd = "racer"
let g:racer_experimental_completer = 1
"}}}

" Splitjoin {{{
let g:splitjoin_trailing_comma = 1
let g:splitjoin_ruby_hanging_args = 0
" }}}
