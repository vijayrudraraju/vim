filetype plugin indent on
filetype indent plugin on

" line numbers
set nonumber

" status line file path bar
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' '.l:branchname.' ':''
endfunction

function! CurrentGitStatus()
  "let gitoutput = split(system('git status --porcelain -b '.shellescape(expand('%')).' 2>/dev/null'),'\n')
  let gitoutput = split(system('git status '.shellescape(expand('%')).' 2>/dev/null'),'\n')
  if len(gitoutput) > 0
    "return strpart(get(gitoutput,0,''),3) . '/' . strpart(get(gitoutput,1,'  '),0,2)
    return get(gitoutput,0,'')
  else
    return ''
  endif
endfunction

function! Working()
  let splits = split(getcwd(), '/')
  return get(splits,len(splits)-1,'')
endfunction

function! TruncatedName()
  let splits = split(simplify(expand('%')), '/')
  if len(splits) > 5
    return join(splits[1:], '/')
  else
    return simplify(expand('%'))
  endif
endfunction

set cursorline
set cursorcolumn

set laststatus=2
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{CurrentGitStatus()}
set statusline+=%#LineNr#
"set statusline+=\ %F
"set statusline+=\ %{simplify(expand('%'))}
set statusline+=\ %{TruncatedName()}
"set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ %{Working()}
set statusline+=\ 
"set statusline+=\ %l\ %c

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

" incremental search
set incsearch

" solarized syntax coloring
syntax enable
" set background=dark
colorscheme blackboard

set wildmenu wildmode=longest:full,full

" http://inlehmansterms.net/2014/09/04/sane-vim-working-directories/
" set working directory to git project root
" or directory of current file if not git project
" function! SetProjectRoot()
  " default to the current file's directory
  " lcd %:p:h
  " let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  " let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  " if empty(is_not_git_dir)
    " lcd `=git_dir`
  " endif
" endfunction

" Set working dir to git root
" autocmd BufEnter *
"  \ call SetProjectRoot()

" noremap P :lcd ~/Code/parsegarden<CR>
" noremap A :lcd ~/Code/stagecraft/WebApps/AudioMarket<CR>
" noremap D :lcd ~/Code/gitground/freedraw<CR>

" Set working directory to buffer
" autocmd BufEnter * silent! lcd %:p:h

" noexpandtab for makefiles
autocmd FileType make setlocal noexpandtab

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case

  " Use ag CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore-case --hidden -g ~/Code/web-client-devel'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " set working directory to nearest git directory
  " let g:ctrlp_working_path_mode = 'ra'
  "
  " show hidden files
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_dotfiles = 1

  " ignore during ctrl-p
  " let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
  let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

  let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
      \ 'AcceptSelection("t")': ['<cr>'],
      \ }
  let g:ctrlp_cmd = 'CtrlP'
endif

" ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind F to reformat
nnoremap F :syntax sync fromstart<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

let g:ctrlp_match_window = 'min:4,max:20'

" persistent file undo
set undodir=~/.vim/undodir
set undofile
set undolevels=2000
set undoreload=20000

" bind leader to ,
let mapleader = ","

" case insensitive forward slash search
set ic

" quickfix window, open in new tab, use existing tab if available
:set switchbuf+=usetab,newtab

" run shell command output to new buffer
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  :tabnew
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" pathogen
execute pathogen#infect()

" normal backspace
set backspace=indent,eol,start

" quit quickfix window when closing tab automatically
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" easier tab opening
nnoremap † :tabnew<CR>
nnoremap ≈ :q<CR>

"autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" Netrw browser
let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
