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

" http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
" set working directory to git project root
" or directory of current file if not git project
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction

" Set working dir to git root
" autocmd BufEnter *
"  \ call SetProjectRoot()

" lcd ~/Code/parsegarden
noremap P :lcd ~/Code/parsegarden<CR>
noremap A :lcd ~/Code/stagecraft/WebApps/AudioMarket<CR>
noremap D :lcd ~/Code/gitground/freedraw<CR>

" Set working directory to buffer
" autocmd BufEnter * silent! lcd %:p:h

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
  " set working directory to nearest git directory
  let g:ctrlp_working_path_mode = ''
endif

" ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind F to reformat
nnoremap F :syntax sync fromstart<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" pathogen
execute pathogen#infect()
