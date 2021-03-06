"Python3 support
let g:python2_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

if &compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir . "," . &runtimepath

let s:toml_file = fnamemodify(expand('<sfile>'), ':h') . '/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)

  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" thinca/vim-template
let g:template_basedir = '~/.config/nvim/'
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
silent! %s;<+DATE+>;\=strftime('%Y/%m/%d');g
silent! %s;<+YEAR+>;\=strftime('%Y');g
silent! %s/<+FILENAME+>/\=expand('%:t:r')/g
silent! %s/<+UPPERFILENAME+>/\=toupper(expand('%:t:r'))/g
endfunction
autocmd User plugin-template-loaded
  \   if search('<+CURSOR+>')
  \ |   silent! execute 'normal! "_da>'
  \ | endif

autocmd VimEnter * nested :call s:StartVim()
function! s:StartVim()
  if (@%=='' && s:GetBufByte()==0)
    execute ':NERDTree'
  endif
endfunction
function! s:GetBufByte()
  let byte=line2byte(line('$')+1)
  if byte==-1
    return 0
  else
    return byte-1
  endif
endfunction

"vim-submode
call submode#enter_with('bufmove', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('bufmove', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

"tex
let g:tex_conceal = ''

"syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_cpp_include_dirs=[]
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_compiler='clang++'
let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'

" move buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" clear search result by Esc
nnoremap <ESC><ESC> :nohlsearch<CR>

" command line mode completion
set wildmode=longest:full,full

" grep
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh

" color schema
colorscheme jellybeans
let g:jellybeans_use_lowcolor_black=0

" Use deoplete.
let g:deoplete#enable_at_startup=1

set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
set backupdir=~/Documents/Vim_backup
set directory=~/Documents/Vim_backup
set expandtab
set smarttab
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2

set cursorline
set number
set showmatch
set incsearch
set completeopt=menuone
set splitright
set splitbelow
set backspace=indent,eol,start
set ignorecase
set wildignorecase
set wildmode=list,full
set smartcase
set clipboard+=unnamedplus
set mouse=a

set foldmethod=indent
set foldlevel=1
"set foldclose=all

"for shell
set sh=/usr/local/bin/zsh
tnoremap <silent> <ESC> <C-\><C-n>
let g:neoterm_shell='/usr/local/bin/zsh'

"for ctags
map « :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map g<S-LeftMouse> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
