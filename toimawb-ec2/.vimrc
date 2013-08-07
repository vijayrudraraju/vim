set nocompatible                    " be iMproved
" filetype off                        " required!

filetype plugin indent on           " necessary for Vundle
" omnicomplete
set omnifunc=syntaxcomplete#Complete

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" git wrapper
Bundle 'tpope/vim-fugitive'         
Bundle 'airblade/vim-gitgutter'
" move around
Bundle 'Lokaltog/vim-easymotion'    
" fast html
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
" html
Bundle 'othree/html5.vim'
" autocomplete
Bundle 'marijnh/tern_for_vim'

" vim-gitgutter
highlight clear SignColumn

" line numbers
set number

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" set autoindent
set autoindent

" reveal matching brace
set showmatch
set matchtime=3

" indent stuff
" set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" copy/paste to system
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-v> :call setreg("\"", system("pbpaste"))<CR>

set ruler

set incsearch

syntax on

set wildmenu wildmode=longest:full,full

autocmd BufEnter * silent! lcd %:p:h

" noexpandtab for makefiles
autocmd FileType make setlocal noexpandtab
