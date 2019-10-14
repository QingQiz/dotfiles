" Vim syntax file
" Language:	GNU Assembler
" Maintainer:	QingQiz < sofeeys@outlook.com >
" Last Change:	2019 Oct 14


" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn keyword asmType long ascii asciz byte double float hword octa quad short single space string word

syn match asmType "\.long"
syn match asmType "\.ascii"
syn match asmType "\.asciz"
syn match asmType "\.byte"
syn match asmType "\.double"
syn match asmType "\.float"
syn match asmType "\.hword"
syn match asmType "\.int"
syn match asmType "\.octa"
syn match asmType "\.quad"
syn match asmType "\.short"
syn match asmType "\.single"
syn match asmType "\.space"
syn match asmType "\.string"
syn match asmType "\.word"

syn match asmLabel		"^\s*[a-z_][a-z0-9_]*:"
syn match asmVar		"[a-z_][a-z0-9_]*"
syn match asmInst	        "\<[a-zA-Z0-9]\{1,5}\>"

syn match decNumber		"[0-9][0-9_]\{0,}d\{0,1}"
syn match decNumber		"0d[0-9_]\+"

syn match octNumber		"[0-7_]\+[oq]"
syn match octNumber		"0[oq][0-7_]\+"

syn match hexNumber		"0[xh][0-9a-fA-F_]\+"
syn match hexNumber		"[0-9][0-9a-fA-F_]*h"
syn match hexNumber		"$[0-9][0-9a-fA-F_]\{0,}"

syn match binNumber		"[01][01_]\{0,}[by]"
syn match binNumber		"0[by][01_]\+"

syn keyword asmTodo		contained TODO


syn region asmComment		start="/\*" end="\*/" contains=asmTodo
syn region asmComment		start="//" end="$" keepend contains=asmTodo
syn match asmComment		"[#;!|].*" contains=asmTodo

syn match asmInclude		"[.%]include"
syn match asmCond		"[.%]if"
syn match asmCond		"[.%]else"
syn match asmCond		"[.%]endif"
syn match asmMacro		"[.%]macro"
syn match asmMacro		"[.%]endm"

syn match asmDirective		"\.[A-Za-z][0-9A-Za-z-_]*"

syn region	asmEscapeBrace	oneline   contained transparent start="[^\\]\(\\\\\)*\[\zs\^\=\]\=" skip="\\\\\|\\\]" end="]"me=e-1
syn match	asmPatSepErr	contained	"\\)"
syn match	asmPatSep	contained	"\\|"
syn region	asmPatSepZone	oneline   contained   matchgroup=asmPatSepZ start="\\%\=\ze(" skip="\\\\" end="\\)\|[^\\]['"]"	contains=@asmStringGroup
syn region	asmPatRegion	contained transparent matchgroup=asmPatSepR start="\\[z%]\=(" end="\\)"	contains=@asmSubstList oneline
syn match	asmNotPatSep	contained	"\\\\"
syn cluster	asmStringGroup	contains=asmEscapeBrace,asmPatSep,asmNotPatSep,asmPatSepErr,asmPatSepZone
syn region	asmString	oneline keepend	start=+[^a-zA-Z>!\\@]"+lc=1 skip=+\\\\\|\\"+ matchgroup=asmStringEnd end=+"+	contains=@asmStringGroup
syn region	asmString	oneline keepend	start=+[^a-zA-Z>!\\@]'+lc=1 end=+'+
syn region	asmString	oneline	start=+=!+lc=1	skip=+\\\\\|\\!+ end=+!+	contains=@asmStringGroup
syn region	asmString	oneline	start="=+"lc=1	skip="\\\\\|\\+" end="+"	contains=@asmStringGroup
syn region	asmString	oneline	start="\s/\s*\A"lc=1 skip="\\\\\|\\+" end="/"	contains=@asmStringGroup
syn match	asmString	contained	+"[^"]*\\$+	skipnl nextgroup=asmStringCont
syn match	asmStringCont	contained	+\(\\\\\|.\)\{-}[^\\]"+


syn case match

hi def link asmLabel	Statement
hi def link asmVar	Statement
hi def link asmComment	Comment
hi def link asmTodo	Todo
hi def link asmDirective	Statement

hi def link asmInclude	Include
hi def link asmCond	PreCondit
hi def link asmMacro	Macro

hi def link hexNumber	Number
hi def link decNumber	Number
hi def link octNumber	Number
hi def link binNumber	Number

hi def link asmInst	Identifier
hi def link asmType	Type
hi def link asmString	string


let b:current_syntax = "asm"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
