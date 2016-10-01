"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! UpdateRemote(arg)
  UpdateRemotePlugins
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-plug && Plug Specific Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Languages
Plug 'ekalinin/Dockerfile.vim'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'tpope/vim-haml', { 'for': 'haml' }
Plug 'othree/html5.vim'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'docunext/closetag.vim', { 'for': 'html' }
Plug 'jtratner/vim-flavored-markdown'
Plug 'b4winckler/vim-objc'
Plug 'aaronjensen/vim-sass-status'
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'jby/tmux.vim'
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'cfdrake/vim-carthage'
Plug 'vim-perl/vim-perl'
Plug 'rust-lang/rust.vim'
Plug 'hsanson/vim-android'
Plug 'udalov/kotlin-vim'

" Javascript
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'tpope/vim-jdaddy'
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'
Plug 'elmcast/elm-vim'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'Keithbsmiley/rspec.vim'
Plug 'tpope/vim-bundler'

" Tools
Plug 'mhinz/vim-grepper'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/ctags.vim'
" Plug 'ctrlpvim/ctrlp.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Adds automatic closing of quotes
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
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
Plug 'bootleq/vim-textobj-rubysymbol'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'coderifous/textobj-word-column.vim'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tolecnal/vim-matchit'
Plug 'rizzatti/funcoo.vim'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'

" Colors
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Completion
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'ludovicchabant/vim-gutentags' " Autogenerate ctags

call plug#end()

" CtrlP "
let g:ctrlp_match_window = 'max:20'
" Adds ; as the Ctrl+P fuzzy search
nmap ; :CtrlPBuffer<CR>
nmap <Leader>t :CtrlPTag<CR>
" Show the damn dotfiles
let g:ctrlp_show_hidden = 1

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
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
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
