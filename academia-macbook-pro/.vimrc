filetype plugin indent on
filetype indent plugin on

" line numbers
set number

" file path
set laststatus=2
set statusline+=%F

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
" nmap <C-v> :call setreg("\"", system("pbpaste"))<CR>p

set ruler

set incsearch

" syntax coloring
syntax on
colorscheme blackboard

set wildmenu wildmode=longest:full,full

autocmd BufEnter * silent! lcd %:p:h

" noexpandtab for makefiles
autocmd FileType make setlocal noexpandtab

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" pathogen
execute pathogen#infect()
