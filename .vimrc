" basic set >>>>>>
syntax on
set nocompatible
set endofline binary nofixeol
filetype plugin indent on

set mouse=
set nu relativenumber
set cul
set ts=4 sw=4
set tabstop=4 softtabstop=4

set expandtab
set autoindent
set encoding=utf-8

set fillchars=fold:-,vert:\ 

" set ignorecase
" set smartcase
set hlsearch
set foldmethod=marker foldmarker=>>>>>>,<<<<<<
set gcr=a:block-blinkon0

set rtp+=~/.vim/vimfiles/*
set rtp+=~/.vim/vimfiles/indentLine/after
" <<<<<<

" set map >>>>>>
let mapleader = " "
nn <c-h>                  <c-w>h
nn <c-j>                  <c-w>j
nn <c-k>                  <c-w>k
nn <c-l>                  <c-w>l
nn <silent><leader>bn     :bn<CR>
nn <silent>]b             :bn<CR>
nn <silent><leader>bp     :bp<CR>
nn <silent>[b             :bp<CR>
nn <silent><leader>bd     :bd<CR>

nn <silent><leader>Q      :q!<CR>
nn <silent><leader>q      :q<CR>
nn Q                      :q<CR>

nn <silent><F3>           :NERDTreeToggle<CR>
nn <silent><F2>           :TagbarToggle<CR>

nn <silent>[<SPACE>       :<C-u>put! =repeat(nr2char(10), v:count1)<CR>
nn <silent>]<SPACE>       :<C-u>put =repeat(nr2char(10), v:count1)<CR>
nn <silent>[e             :<C-u>execute 'move -1-'. v:count1<CR>
nn <silent>]e             :<C-u>execute 'move +'. v:count1<CR>
nn <silent><leader>cl     :call Comments()<CR>
nn <silent><F12>          :call AddHead()<CR>
nn <silent><F5>           :w<CR>:call SmartComplier()<CR>
nn <silent><F6>           :call RunResult()<CR>

ino jK                    <ESC>
ino jk                    <ESC>
nn <silent>gy             ggVG"+y''zz
vn \y                     "+y
nn \p                     "+p"
nn \n                     :noh<CR>
nn H                      ^
nn L                      $
ino <c-l>                 <right>
ino <c-k>                 <up>
ino <c-@>                 <nop>
" <<<<<<

" set highlight >>>>>>
colorscheme angel
hi LineNr       ctermfg=black    ctermbg=NONE    cterm=BOLD
hi NonText      ctermfg=234      ctermbg=NONE
hi Search       ctermbg=NONE     ctermfg=red
hi MatchParen   ctermbg=NONE     ctermfg=red     guibg=NONE     guifg=red
hi YcmErrorSign ctermbg=NONE     ctermfg=red     guibg=NONE     guifg=red
hi BadWhiteSpace ctermbg=6

" <<<<<<

" set ui >>>>>>
if has("gui_running")
  set guioptions-=m
  set guioptions-=T
  set guioptions-=L
  set guioptions-=r
  set guioptions-=b
  set showtabline=0
endif
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
" <<<<<<

" set commans >>>>>>
" autocmd BufWritePost .vimrc source %
command! Vimrc :e $HOME/.vimrc
command! W :w !sudo tee %
command! AddHead :call AddHead()
command! Comments :call Comments()
command! Compile :call SmartComplier()
command! ColorCoded :!cp ~/.config/color_coded/.color_coded .
command! Reload :source ~/.vimrc
" <<<<<<

" set functions >>>>>>
" Comments >>>>>>
func! Comments()
  let line = getline('.')
  if &ft == "cpp" || &ft == "cs"
    if line =~'.*\/\*.*$'
      s!/\*\(\_.\{-}\)\*/!\1!
    elseif line =~'^\s*\/\/.*$'
      s!^\(\s*\)//\s*!\1!
    else
      s!^\s*!&// !
    endif
  elseif &ft == "java"
    if line =~'^\s*\/\/.*$'
      s!^\(\s*\)//\s*!\1!
    else
      s!^\s*!&// !
    endif
  elseif &ft == "vim"
    if line =~'^\s*\".*'
      s/^\(\s*\)"\s*/\1/
    else
      s/^\s*/&" /
    endif
  elseif &ft == "lisp"
    if line =~'^\s*;;.*'
      s/^\(\s*\);;\s*/\1/
    else
      s/^\s*/&;; /
    endif
  elseif &ft == 'dosini'
    if line =~'^\s*;.*'
      s/^\(\s*\);\s*/\1/
    else
      s/^\s*/&; /
    en
  else
    if line =~'^\s*#.*'
      s/^\(\s*\)#\s*/\1/
    else
      s/^\s*/&# /
    endif
  endif
  noh
endf
" <<<<<<

" Tittle >>>>>>
fun! AddHead()
  call append(0, "======================================================================")
  " call append(2, "Last modified: ".strftime("%Y-%m-%d %H-%M"))
  " call append(3, "file name: ".expand("%:t"))
  call append(1, "Dsp: ")
  call append(2, "URL: ")
  call append(3, "Author: Sofee ( _s@mail.nwpu.edu.cn )")
  call append(4, "======================================================================")
  1,5 call Comments()
endf
" <<<<<<

" Compiler >>>>>>
fun! SmartComplier()
  if &ft == "cpp"
    if findfile('Makefile', '.') == 'Makefile'
      exec "!make"
    elseif findfile('Makefile') == '' && findfile('CMakeLists.txt', '.') == 'CMakeLists.txt'
      exec "!(cmake . && make)"
    else
      exec "!g++ -Wall -o now % -g -lm"
    en
  elseif &ft == "java"
    exec "!javac %"
  elseif &ft == "cs"
    exec "!mcs %"
  endif
endf

func! RunResult()
  if &ft == "cpp"
    exec "!./now"
  elseif &ft == "python"
    exec "!python3 %"
  elseif &ft == "java"
    exec "!java %<"
  elseif &ft == "cs"
    exec "!mono ./%<.exe"
  elseif &ft == "php"
    exec "!php %"
  elseif &ft == "html"
    exec "!chromium %"
  endif
endf
" <<<<<<

" Ultisnips >>>>>>
fun! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endf

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

let g:ulti_expand_res = 1
fun! Ulti_ExpandOrEnter()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res
    return ''
  else
    return "\<return>"
  endif
endf
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>
" <<<<<<

" standardization for C >>>>>>
" <<<<<<
" <<<<<<

" Autocmd >>>>>>
augroup filetype_frmats " >>>>>>
  au!
  au BufNewFile,BufRead *.{vim,vimrc}
      \ setlocal tabstop=2    |
      \ setlocal softtabstop=2|
      \ setlocal shiftwidth=2

  au BufNewFile,BufRead *.py
      \ setlocal autoindent   |
      \ setlocal nowrap       |
      \ setlocal sidescroll=5

  au BufNewFile,BufRead *.js,*.html,*.php
      \ setlocal tabstop=2    |
      \ setlocal softtabstop=2|
      \ setlocal shiftwidth=2

  au BufNewFile,BufRead *.html,*.php
      \ let b:AutoPairs = {"<": ">", '"': '"', "'": "'", '{': '}', '(': ')', '[': ']'}

  au BufNewFile,BufRead *.py,*.c,*.cc,*.cpp,*.h*.{vim,vimrc}
      \ match BadWhiteSpace /\v\s+$/

augroup END " <<<<<<
" <<<<<<

" Plugin >>>>>>
" plugin list >>>>>>
" PluginList = [ \
    \ ['Yggdroot/indentLine'],
    \ ['scrooloose/nerdtree'],
    \ ['vim-airline/vim-airline'],
    \ ['vim-airline/vim-airline-themes'],
    \ ['tpope/vim-surround'],
    \ ['Valloric/YouCompleteMe'],
    \ ['majutsushi/tagbar'],
    \ ['jiangmiao/auto-pairs'],
    \ ['kshenoy/vim-signature'],
    \ ['jeaye/color_coded'],
    \ ['guns/xterm-color-table.vim'],
    \ ['luochen1990/rainbow'],
    \ ['mbbill/undotree']
    \ ]
" <<<<<<

" undotree >>>>>>
if has("persistent_undo")
    set undodir=~/.cache/vim/undotree/
    set undofile
endif

nn <F7> :UndotreeToggle<CR>
" <<<<<<

" rainbow >>>>>>
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['69', '94', '36', '133'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\	}
	\}
" <<<<<<

" auto-pairs >>>>>>
let g:AutoPairsFlyMode=0
let g:AutoPairsMultilineClose=0
" <<<<<<

" NERDTree >>>>>>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" <<<<<<

" AirLine >>>>>>
let g:airline_theme = 'badcat'
" let g:airline_theme = 'distinguished'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" nmap <leader>- <Plug>AirlineSelectPrevTab
" nmap <leader>+ <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#buffer_idx_format = {
    \ '1': '¹',
    \ '2': '²',
    \ '3': '³',
    \ '4': '⁴',
    \ '5': '⁵',
    \ '6': '⁶',
    \ '7': '⁷',
    \ '8': '⁸',
    \ '9': '⁹'
    \ }
" <<<<<<

" TagBar >>>>>>
let g:tagbar_left=0
let g:tagbar_width=25
let g:tagbar_autoclose=1
" <<<<<<

" YouCompleteMe >>>>>>
let g:ycm_server_python_interpreter='/usr/bin/python3.6'
let g:ycm_global_ycm_extra_conf='~/.config/ycmd/ycmd_conf.py'
let g:ycm_min_num_indentifier_candidate_chars=2
let g:ycm_key_invoke_completion='<c-n>'
" let g:ycm_key_invoke_completion='<c-@>'
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_enable_diagnostic_highlighting=0
set completeopt=longest,menuone
" nn <F12> :YcmDiags<CR>

let g:ycm_semantic_triggers =  {
    \   'c' : ['->', '.', '-> '],
    \   'cpp,objcpp' : ['->', '.', '::', '-> '],
    \ }
nn <silent>gd :YcmCompleter GoTo<CR>
" <<<<<<
" <<<<<<
