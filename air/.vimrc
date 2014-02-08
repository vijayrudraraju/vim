filetype indent on
filetype plugin on

" line numbers
set number

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

set nocompatible
set autoindent

" reveal matching brace
set showmatch
set matchtime=3

" indent stuff
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" copy/paste to system
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-v> :call setreg("\"", system("pbpaste"))<CR>p

set ruler

set incsearch

syntax on

set wildmenu wildmode=longest:full,full

autocmd BufEnter * silent! lcd %:p:h

" noexpandtab for makefiles
autocmd FileType make setlocal noexpandtab
