" basic set >>>>>>
syntax on
set nobackup
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

set fillchars=vert:\ ,fold:-

" set ignorecase
" set smartcase
" set hlsearch
set wildmenu
set foldmethod=marker foldmarker=>>>>>>,<<<<<<
set gcr=a:block-blinkon0

set path+=**
set rtp+=/home/angel/.vim/vimfiles/*
set rtp+=/home/angel/.vim/vimfiles/indentLine/after
" <<<<<<

" map >>>>>>
let mapleader = " "
nn <c-h>                <c-w>h
nn <c-j>                <c-w>j
nn <c-k>                <c-w>k
nn <c-l>                <c-w>l
nn <silent>]b           :bn<CR>
nn <silent>[b           :bp<CR>

nn Q                    :q<CR>

nn <silent><F3>         :NERDTreeToggle<CR>
nn <silent><F2>         :TagbarToggle<CR>

nn <silent>[<SPACE>     :call append(line('.') - 1, "")<CR>k
nn <silent>]<SPACE>     :call append(line('.'), "")<CR>j
nn <silent>[e           :move -1-1<CR>
nn <silent>]e           :move +1<CR>
nn <leader>Q            :q!

nn <silent><leader>cl   :call Comments()<CR>
nn <silent><F5>         :w<CR>:call SmartComplier()<CR>
nn <silent><F6>         :call RunResult()<CR>
nn <expr>A              GoIndent()

ino jK                  <ESC>
ino jk                  <ESC>
nn <silent>gy           ggVG"+y''zz
vn \y                   "+y
nn \p                   "+p
nn \n                   :noh<CR>
nn H                    ^
vn H                    ^
nn L                    $
vn L                    $
imap <c-l>              <right>
imap <c-f>              <right>
imap <c-b>              <left>
imap <c-k>              <up>
nn <up>                 <nop>
nn <down>               <nop>
ino <c-@>               <nop>
" <<<<<<

" highlight >>>>>>
" colorscheme atomic
colorscheme angel

hi LineNr        ctermfg=black ctermbg=NONE cterm=Bold
hi CursorLineNr  ctermfg=229   ctermbg=239  cterm=Bold
hi Normal        ctermfg=231   ctermbg=NONE cterm=NONE
hi NonText       ctermfg=234   ctermbg=NONE
hi Search        ctermfg=red   ctermbg=NONE
hi MatchParen    ctermfg=red   ctermbg=NONE guibg=NONE guifg=red
hi YcmErrorSign  ctermfg=red   ctermbg=NONE guibg=NONE guifg=red
hi PMenu         ctermfg=111
hi vimOption     ctermfg=141   ctermbg=NONE cterm=bold

" syntax
hi BadWhiteSpace ctermbg=6
" hi String        ctermfg=41    ctermbg=none cterm=bold

" color coded
hi Member        ctermfg=44    ctermbg=NONE cterm=Italic,Bold
hi Variable      ctermfg=249   ctermbg=NONE
hi VarDecl       ctermfg=111
hi ParmDecl      ctermfg=111
" <<<<<<

" gui >>>>>>
if has("gui_running")
  set guioptions-=m
  set guioptions-=T
  set guioptions-=L
  set guioptions-=r
  set guioptions-=b
  set showtabline=0
endif
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12

hi LineNr        guifg=black   guibg=NONE    gui=Bold
hi CursorLineNr  guifg=#ffffaf guibg=#4e4e4e gui=NONE
hi Member        guifg=#00dfdf guibg=NONE    gui=Italic,Bold
hi Normal        guifg=#e4e4e4 guibg=NONE    gui=NONE
hi NonText       guifg=#1c1c1c guibg=NONE    gui=NONE
hi Search        guifg=red     guibg=NONE    gui=NONE
hi MatchParen    guifg=red     guibg=NONE    gui=NONE
hi YcmErrorSign  guifg=red     guibg=NONE    gui=NONE
" hi BadWhiteSpace guifg=NONE    guibg=6       gui=NONE
" <<<<<<

" commands >>>>>>
" autocmd BufWritePost .vimrc source %
command! Vimrc e $HOME/.vimrc
command! W w !sudo tee %
command! AddHead call AddHead()
command! Comments call Comments()
command! ColorCoded !cp ~/.config/color_coded/.color_coded .
command! Reload source ~/.vimrc
command! MakeTags !ctags -R .
" <<<<<<

" functions >>>>>>
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
  elseif &ft == "html"
    if line =~ '^\s*<!--\s*.*\s*-->$'
      s/\(\s*\)<!--\s*\(.*\)\s*-->/\1\2/
      s/\s*$//
    else
      s/\s*$//
      s/\(\s*\)\(.*\)\s*/\1<!-- \2 -->/
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

" go indent >>>>>>
fun! GoIndent()
  if getline('.') == ""
    return 'ddO'
  else
    return 'A'
  endif
endf
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

  au BufNewFile,BufRead *.html
      \ let b:AutoPairs = {"<": ">", '"': '"', "'": "'", '{': '}', '(': ')', '[': ']'}

  au BufNewFile,BufRead *.py,*.c,*.cc,*.cpp,*.h*,.{vim,vimrc}
      \ match BadWhiteSpace /\v\s+$/

augroup END " <<<<<<

" jump to the last known position >>>>>>
au BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'|
      \   exe "normal! g`\""                                              |
      \ endif
" <<<<<<
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
    \ ['mbbill/undotree'],
    \ ['easymotion/vim-easymotion'],
    \ ['junegunn/vim-easy-align'],
    \ ['mhinz/vim-startify']
    \ ]
" <<<<<<

" startify >>>>>>
let g:startify_bookmarks = [
      \ { 'v': '~/.vimrc' },
      \ { 'z': '~/.zshrc' },
      \ { 'i': '~/.config/i3/config' },
      \ { 'p': '~/.config/polybar/config' }
      \ ]
let g:startify_files_number = 5
let g:startify_custom_indices = ['a', 's', 'd']
" <<<<<<

" Indentline >>>>>>
let g:indentLine_fileType = [
      \ 'c', 'cpp', 'html', 'php', 'cs', 'shell',
      \ 'config', 'vim', 'python', 'java', 'zsh', 'sh',
      \ 'conf'
      \ ]
let g:indentLine_char = '┆'
" <<<<<<

" vim-easy-align >>>>>>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" <<<<<<

" vim-easymotion >>>>>>
let g:EasyMotion_do_mapping = 0
" `s{char}{label}`
nmap c <nop>
nmap c <Plug>(easymotion-overwin-f)
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap c <Plug>(easymotion-overwin-f2)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
" <<<<<<

" AutoPairs & rainbow >>>>>>
let g:AutoPairsFlyMode=0
let g:AutoPairsMultilineClose=0

let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['69', '36', '75', '133', '94'],
	\	'operators': '_,\|+\|-\|\*\|\/\(\s\)\@=\|=\|==\|<\|>\|!\|%\|\^\|&\||\|>>\|<<\|\.\|->_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\	  'lisp': {
	\	    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\	}
	\}
" <<<<<<

" NERDTree & tagbar & undotree >>>>>>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:tagbar_left=0
let g:tagbar_width=25
let g:tagbar_autoclose=1

if has("persistent_undo")
    set undodir=~/.cache/vim/undotree/
    set undofile
endif

nn <F7> :UndotreeToggle<CR>
" <<<<<<

" AirLine >>>>>>
let g:airline_theme = 'badcat'
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
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'VL',
    \ '' : 'VB',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '|'
let g:airline_right_alt_sep = '|'
" <<<<<<

" YouCompleteMe >>>>>>
let g:ycm_server_python_interpreter='/usr/bin/python3.6'
let g:ycm_global_ycm_extra_conf='/home/angel/.config/ycmd/ycmd_conf.py'
let g:ycm_min_num_indentifier_candidate_chars=2
let g:ycm_key_invoke_completion='<c-d>'
" let g:ycm_key_invoke_completion='<c-@>'
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_enable_diagnostic_highlighting=0
let g:ycm_enable_diagnostic_signs = 0
set completeopt=longest,menuone
" nn <F12> :YcmDiags<CR>

let g:ycm_semantic_triggers =  {
    \   'c' : ['->', '.', '-> '],
    \   'cpp,objcpp' : ['->', '.', '::', '-> '],
    \ }
nn <silent>gd :YcmCompleter GoTo<CR>
" <<<<<<
" <<<<<<
