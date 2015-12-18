
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-plug && Plug Specific Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Languages
Plug 'kchmck/vim-coffee-script'
Plug 'ekalinin/Dockerfile.vim'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'tpope/vim-haml'
Plug 'othree/html5.vim'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'docunext/closetag.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim' " JS Frameworks
Plug 'tpope/vim-markdown'
Plug 'jtratner/vim-flavored-markdown'
Plug 'b4winckler/vim-objc'
Plug 'rodjek/vim-puppet'
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
Plug 'aaronjensen/vim-sass-status'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-jdaddy'
Plug 'jby/tmux.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'Keithbsmiley/swift.vim', { 'for': 'swift' }
Plug 'cfdrake/vim-carthage'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'sunaku/vim-ruby-minitest'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'Keithbsmiley/rspec.vim'
Plug 'tpope/vim-bundler'

" Tools
Plug 'rking/ag.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/ctags.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-speeddating'
" Adds automatic closing of quotes
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'
Plug 'skwp/greplace.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'benmills/vimux'
Plug 'danro/rename.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'terryma/vim-multiple-cursors'

" Text Objects
Plug 'kana/vim-textobj-user'
Plug 'bootleq/vim-textobj-rubysymbol'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'coderifous/textobj-word-column.vim'

Plug 'godlygeek/tabular'
Plug 'tomtom/tcomment_vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tolecnal/vim-matchit'
Plug 'mattboehm/vim-unstack'
Plug 'rizzatti/funcoo.vim'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'AndrewRadev/splitjoin.vim'

" Colors
Plug 'skwp/vim-colors-solarized'
Plug 'bling/vim-airline'

" Linters
Plug 'marijnh/tern_for_vim'
Plug 'scrooloose/syntastic'

call plug#end()
filetype plugin indent on

" YouCompleteMe settings
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" CtrlP
let g:ctrlp_match_window = 'max:20'
" Adds ; as the Ctrl+P fuzzy search
nmap ; :CtrlPBuffer<CR>
" Show the damn dotfiles
let g:ctrlp_show_hidden = 1

nmap <F8> :TagbarToggle<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

