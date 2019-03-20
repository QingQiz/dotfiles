" Todo List syntax file
" Language:     todo
" Maintainer:   QingQiz

if exists("b:current_syntax")
  finish
endif

if !exists('main_syntax')
  let main_syntax = 'todo'
endif

runtime! syntax/markdown.vim
unlet! b:current_syntax
