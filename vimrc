if &compatible
  set nocompatible
endif

function! InstallPackager() abort
  "if has('nvim')
    "silent !git clone https://github.com/kristijanhusak/vim-packager
      "\ ~/.config/nvim/pack/packager/opt/vim-packager
  "else
    silent !git clone https://github.com/kristijanhusak/vim-packager ~/.vim/pack/packager/opt/vim-packager
  "endif
endfunction

" Load packager only when needed 
function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  call packager#add('kristijanhusak/vim-packager', { 'type': 'opt' })
  call packager#add('sheerun/vim-polyglot')

  " Tools
  call packager#add('junegunn/fzf', { 'do': './install --all && ln -s $(pwd) ~/.fzf'})
  call packager#add('junegunn/fzf.vim')
  call packager#add('christoomey/vim-tmux-navigator')

  "Loaded only for specific filetypes on demand. Requires autocommands below.
  call packager#add('fatih/vim-go', { 'do': ':GoInstallBinaries', 'type': 'opt' })
  call packager#add('neoclide/coc.nvim', { 'do': function('InstallCoc') })
  call packager#add('rakr/vim-one')
endfunction

function! InstallCoc(plugin) abort
  exe '!cd '.a:plugin.dir.' && yarn install'
  call coc#add_extension('coc-eslint', 'coc-tsserver', 'coc-pyls')
endfunction 
command! PackagerInstall call PackagerInit() | call packager#install()
command! -bang PackagerUpdate call PackagerInit() | call packager#update({ 'force_hooks': '<bang>' })
command! PackagerClean call PackagerInit() | call packager#clean()
command! PackagerStatus call PackagerInit() | call packager#status()

"Load plugins only for specific filetype
"Note that this should not be done for plugins that handle their loading using ftplugin file. 
"More info in :help pack-add
augroup packager_filetype
  autocmd!
  " autocmd FileType javascript packadd vim-js-file-import
  autocmd FileType go packadd vim-go
augroup END

""" General
"
set mouse=a " Enable mouse support
" Whitespace
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_
set smartindent
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list " Show “invisible” characters
set ffs=unix,dos,mac           " Default file types


""" Initial Config

syntax on
set t_Co=256
set cursorline
colorscheme one

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc
