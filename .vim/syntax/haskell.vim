
" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" (Qualified) identifiers (no default highlighting)
syn match ConId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[A-Z][a-zA-Z0-9_']*\>" contains=@NoSpell
syn match VarId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[a-z][a-zA-Z0-9_']*\>" contains=@NoSpell

" Infix operators--most punctuation characters and any (qualified) identifier
" enclosed in `backquotes`. An operator starting with : is a constructor,
" others are variables (e.g. functions).
syn match hsVarSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~.][-!#$%&\*\+/<=>\?@\\^|~:.]*"
syn match hsConSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*"
syn match hsVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
syn match hsConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"

" Reserved symbols--cannot be overloaded.
syn match hsDelimiter  "(\|)\|\[\|\]\|,\|;\|_\|{\|}"

" Strings and constants
syn match   hsSpecialChar	contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match   hsSpecialChar	contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match   hsSpecialCharError	contained "\\&\|'''\+"
syn region  hsString		start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=hsSpecialChar,@NoSpell
syn match   hsCharacter		"[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=hsSpecialChar,hsSpecialCharError
syn match   hsCharacter		"^'\([^\\]\|\\[^']\+\|\\'\)'" contains=hsSpecialChar,hsSpecialCharError
syn match   hsNumber		"\v<[0-9]%(_*[0-9])*>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*>|<0[oO]_*%(_*[0-7])*>|<0[bB]_*[01]%(_*[01])*>"
syn match   hsFloat		"\v<[0-9]%(_*[0-9])*\.[0-9]%(_*[0-9])*%(_*[eE][-+]?[0-9]%(_*[0-9])*)?>|<[0-9]%(_*[0-9])*_*[eE][-+]?[0-9]%(_*[0-9])*>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*\.[0-9a-fA-F]%(_*[0-9a-fA-F])*%(_*[pP][-+]?[0-9]%(_*[0-9])*)?>|<0[xX]_*[0-9a-fA-F]%(_*[0-9a-fA-F])*_*[pP][-+]?[0-9]%(_*[0-9])*>"

" Comments
syn keyword hsSpecial TODO XXX FIXME NOTE contained
syn match   hsLineComment      "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$" contains=hsSpecial
syn region  hsBlockComment     start="{-"  end="-}" contains=@NoSpell,hsSpecial

syn keyword hsPragmaKeyword LANGUAGE OPTIONS_GHC contained nextgroup=hsLanguageExt skipwhite
syn match   hsLanguageExt      "[a-zA-Z0-9_-]\+\s\@=" contained
syn region  hsPragma	       start="{-#" end="#-}" contains=hsPragmaKeyword,hsLanguageExt

syn match   hsSpecialComment   "^\v#!/.*"

" Keyword definitions. These must be patterns instead of keywords
" because otherwise they would match as keywords at the start of a
" "literate" comment (see lhs.vim).
syn match hsModule		"\<module\>"
syn match hsImport		"\<\(import\)\>.*"he=s+6 contains=hsImportMod,hsLineComment,hsBlockComment,@NoSpell
syn match hsImportMod		contained "\<\(as\|qualified\|hiding\)\>" contains=@NoSpell
syn match hsInfix		"\<\(infix\|infixl\|infixr\)\>"
syn match hsStructure		"\<\(class\|data\|deriving\|instance\|default\|where\)\>"
syn match hsTypedef		"\<\(type\|newtype\)\>"
syn match hsStatement		"\<\(do\|case\|of\|let\|in\)\>"
syn match hsConditional		"\<\(if\|then\|else\)\>"

syn match hsForeignImport	"\<\(foreign\)\>\s\+\<\(import\|export\)\>"
syn match hsCCall		"\(\(import\|export\)\s\+\)\@<=\<ccall\>"

syn match hsBoolean "\<\(True\|False\)\>"

" Types from the standard prelude libraries.
syn match hsDataConstruct "[A-Z][a-zA-Z0-9'_]*\([a-zA-Z0-9'_]*\.\)\@!"
syn match hsType "\(::.\{-}\)\@<=[A-Z][a-zA-Z0-9'_]*"
syn match hsType "\(deriving.\{-}\)\@<=[A-Z][a-zA-Z0-9'_]*"
syn match hsType "\(\<type\>.*\)\@<=[A-Z][a-zA-Z0-9'_]*"
syn match hsType "\(\(data\|newtype\|type\)\s*\)\@<=[A-Z][a-zA-Z0-9'_]*"
syn match hsType "\(\(data\|newtype\|type\).*=\s*\([^|]\+\(\s\|(\|\[\|,\)\+\)\+\)\@<=[A-Z][a-zA-Z0-9'_]*"
syn match hsType "\(|\s*\([^|>`=]\+\(\s\|(\|\[\|,\)\+\)\+\)\@<=[A-Z][a-zA-Z0-9'_]*"
syn match hsType "\(\(instance\|class\).*\)\@<=[A-Z][a-zA-Z0-9'_]*"
syn match hsExitCode "\<\(ExitSuccess\)\>"
syn match hsOrdering "\<\(GT\|LT\|EQ\)\>"

" Debugging functions from the standard prelude.
syn match hsDebug "\<\(undefined\|error\|trace\)\>"


" C Preprocessor directives. Shamelessly ripped from c.vim and trimmed
" First, see whether to flag directive-like lines or not
" if (!exists("hs_allow_hash_operator"))
    " syn match	cError		display "^\s*\(%:\|#\).*$"
" endif
" Accept %: for # (C99)
syn region	cPreCondit	start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" end="//"me=s-1 contains=cComment,cCppString,cCommentError
syn match	cPreCondit	display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
syn region	cCppOut		start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=cCppOut2
syn region	cCppOut2	contained start="0" end="^\s*\(%:\|#\)\s*\(endif\>\|else\>\|elif\>\)" contains=cCppSkip
syn region	cCppSkip	contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cCppSkip
syn region	cIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	cIncluded	display contained "<[^>]*>"
syn match	cInclude	display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=cIncluded
syn cluster	cPreProcGroup	contains=cPreCondit,cIncluded,cInclude,cDefine,cCppOut,cCppOut2,cCppSkip,cCommentStartError
syn region	cDefine		matchgroup=cPreCondit start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$"
syn region	cPreProc	matchgroup=cPreCondit start="^\s*\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend
syn region	cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=cCommentStartError,cSpaceError contained
syntax match	cCommentError	display "\*/" contained
syntax match	cCommentStartError display "/\*"me=e-1 contained
syn region	cCppString	start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial contained

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link hsForeignImport		  hsImport
hi def link hsCCall			  hsModule
hi def link hsModule			  hsStructure
hi def link hsImport			  Include
hi def link hsImportMod			  hsImport
hi def link hsInfix			  PreProc
hi def link hsStructure			  Structure
hi def link hsStatement			  Statement
hi def link hsConditional		  Conditional
hi def link hsSpecialChar		  SpecialChar
hi def link hsTypedef			  Typedef
hi def link hsVarSym			  hsOperator
hi def link hsConSym			  hsOperator
hi def link hsOperator			  Operator
hi def link hsDelimiter			  Delimiter
hi def link hsSpecialCharError		  Error
hi def link hsString			  String
hi def link hsCharacter			  Character
hi def link hsNumber			  Number
hi def link hsFloat			  Float
hi def link hsConditional		  Conditional
hi def link hsLiterateComment		  hsComment
hi def link hsBlockComment		  hsComment
hi def link hsLineComment		  hsComment
hi def link hsComment			  Comment
hi def link hsPragma			  SpecialComment
hi def link hsSpecialComment		  SpecialComment
hi def link hsPragmaKeyword		  PragmaKeyword
hi def link hsLanguageExt		  LanguageExt
hi def link hsBoolean			  Boolean
hi def link hsType			  Type
hi def link hsDataConstruct		  hsEnumConst
hi def link hsOrdering			  hsEnumConst
hi def link hsEnumConst			  Constant
hi def link hsDebug			  Debug
hi def link hsSpecial			  TODO

hi def link cCppString		hsString
hi def link cCommentStart	hsComment
hi def link cCommentError	hsError
hi def link cCommentStartError	hsError
hi def link cInclude		Include
hi def link cPreProc		PreProc
hi def link cDefine		Macro
hi def link cIncluded		hsString
hi def link cError		Error
hi def link cPreCondit		PreCondit
hi def link cComment		Comment
hi def link cCppSkip		cCppOut
hi def link cCppOut2		cCppOut
hi def link cCppOut		Comment


let b:current_syntax = "haskell"

" Options for vi: ts=8 sw=2 sts=2 nowrap noexpandtab ft=vim
