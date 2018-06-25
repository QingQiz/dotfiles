" Vim color file - molokai_modified
" Generated by http://bytefluent.com/vivify 2018-05-24
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "molokai_modified"

"hi TabLineSel -- no settings --
"hi CTagsMember -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi Normal -- no settings --
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
"hi EnumerationName -- no settings --
"hi SpellCap -- no settings --
"hi SpellLocal -- no settings --
"hi DefinedName -- no settings --
"hi LocalVariable -- no settings --
"hi SpellBad -- no settings --
"hi TabLine -- no settings --
"hi clear -- no settings --

"TODO 235 -> NONE
hi IncSearch guifg=#C4BE89 guibg=#000000 guisp=#000000 gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi WildMenu guifg=#66D9EF guibg=#000000 guisp=#000000 gui=NONE ctermfg=81 ctermbg=NONE cterm=NONE
hi SignColumn guifg=#A6E22E guibg=#232526 guisp=#232526 gui=NONE ctermfg=112 ctermbg=235 cterm=NONE
hi SpecialComment guifg=#465457 guibg=NONE guisp=NONE gui=bold ctermfg=240 ctermbg=NONE cterm=bold
" hi Typedef guifg=#66D9EF guibg=NONE guisp=NONE gui=NONE ctermfg=33 ctermbg=NONE cterm=NONE
hi Title guifg=#ef5939 guibg=NONE guisp=NONE gui=NONE ctermfg=209 ctermbg=NONE cterm=NONE
hi Folded guifg=#465457 guibg=#000000 guisp=#000000 gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi StatusLineNC guifg=#808080 guibg=#080808 guisp=#080808 gui=NONE ctermfg=8 ctermbg=232 cterm=NONE
hi NonText guifg=#121212 guibg=#121212 guisp=#121212 gui=NONE ctermfg=233 ctermbg=233 cterm=NONE
hi DiffText guifg=NONE guibg=#303030 guisp=#303030 gui=bold,italic ctermfg=NONE ctermbg=236 cterm=bold
hi ErrorMsg guifg=#F92672 guibg=#232526 guisp=#232526 gui=bold ctermfg=197 ctermbg=235 cterm=bold
hi Ignore guifg=#808080 guibg=#272822 guisp=#272822 gui=NONE ctermfg=8 ctermbg=235 cterm=NONE
hi Debug guifg=#BCA3A3 guibg=NONE guisp=NONE gui=bold ctermfg=138 ctermbg=NONE cterm=bold
hi PMenuSbar guifg=NONE guibg=#080808 guisp=#080808 gui=NONE ctermfg=NONE ctermbg=232 cterm=NONE
hi Identifier guifg=#FD971F guibg=NONE guisp=NONE gui=NONE ctermfg=208 ctermbg=NONE cterm=NONE
hi SpecialChar guifg=#F92672 guibg=NONE guisp=NONE gui=bold ctermfg=197 ctermbg=NONE cterm=bold
hi Conditional guifg=#F92672 guibg=NONE guisp=NONE gui=bold ctermfg=197 ctermbg=NONE cterm=bold
" hi StorageClass guifg=#FD971F guibg=NONE guisp=NONE gui=italic ctermfg=208 ctermbg=NONE cterm=NONE
hi StatusLine guifg=#455354 guibg=#F8F8F2 guisp=#F8F8F2 gui=NONE ctermfg=240 ctermbg=230 cterm=NONE
hi Label guifg=#E6DB74 guibg=NONE guisp=NONE gui=NONE ctermfg=185 ctermbg=NONE cterm=NONE
hi PMenuSel guifg=NONE guibg=#808080 guisp=#808080 gui=NONE ctermfg=NONE ctermbg=8 cterm=NONE
hi Search guifg=#FFFFFF guibg=#455354 guisp=#455354 gui=NONE ctermfg=15 ctermbg=240 cterm=NONE
hi Delimiter guifg=#8F8F8F guibg=NONE guisp=NONE gui=NONE ctermfg=245 ctermbg=NONE cterm=NONE
hi Statement guifg=#0087ff guibg=NONE guisp=NONE gui=bold ctermfg=33 ctermbg=NONE cterm=bold
hi Character guifg=#E6DB74 guibg=NONE guisp=NONE gui=NONE ctermfg=185 ctermbg=NONE cterm=NONE
hi Float guifg=#AE81FF guibg=NONE guisp=NONE gui=NONE ctermfg=141 ctermbg=NONE cterm=NONE
hi Operator guifg=#F92672 guibg=NONE guisp=NONE gui=NONE ctermfg=197 ctermbg=NONE cterm=NONE
hi Question guifg=#66D9EF guibg=NONE guisp=NONE gui=NONE ctermfg=81 ctermbg=NONE cterm=NONE
hi WarningMsg guifg=#FFFFFF guibg=#333333 guisp=#333333 gui=bold ctermfg=15 ctermbg=236 cterm=bold
hi VisualNOS guifg=NONE guibg=#403D3D guisp=#403D3D gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi DiffDelete guifg=#960050 guibg=#1E0010 guisp=#1E0010 gui=NONE ctermfg=89 ctermbg=53 cterm=NONE
hi ModeMsg guifg=#E6DB74 guibg=NONE guisp=NONE gui=NONE ctermfg=185 ctermbg=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#3E3D32 guisp=#3E3D32 gui=NONE ctermfg=NONE ctermbg=237 cterm=NONE
hi Define guifg=#66D9EF guibg=NONE guisp=NONE gui=NONE ctermfg=81 ctermbg=NONE cterm=NONE
hi Function guifg=#0087ff guibg=NONE guisp=NONE gui=bold ctermfg=33 ctermbg=NONE cterm=bold
hi FoldColumn guifg=#465457 guibg=#000000 guisp=#000000 gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi PreProc guifg=#d75fff guibg=NONE guisp=NONE gui=bold ctermfg=171 ctermbg=NONE cterm=bold
hi Visual guifg=NONE guibg=#403D3D guisp=#403D3D gui=NONE ctermfg=NONE ctermbg=238 cterm=NONE
hi MoreMsg guifg=#E6DB74 guibg=NONE guisp=NONE gui=NONE ctermfg=185 ctermbg=NONE cterm=NONE
hi VertSplit guifg=#808080 guibg=#080808 guisp=#080808 gui=bold ctermfg=8 ctermbg=232 cterm=bold
hi Exception guifg=#A6E22E guibg=NONE guisp=NONE gui=bold ctermfg=112 ctermbg=NONE cterm=bold
hi Keyword guifg=#F92672 guibg=NONE guisp=NONE gui=bold ctermfg=197 ctermbg=NONE cterm=bold
hi DiffChange guifg=NONE guibg=#1c1c1c guisp=#1c1c1c gui=NONE ctermfg=NONE ctermbg=234 cterm=NONE
hi Cursor guifg=#000000 guibg=#F8F8F0 guisp=#F8F8F0 gui=NONE ctermfg=NONE ctermbg=230 cterm=NONE
hi Error guifg=#960050 guibg=#1E0010 guisp=#1E0010 gui=NONE ctermfg=89 ctermbg=53 cterm=NONE
hi PMenu guifg=#5fffd7 guibg=#000000 guisp=#000000 gui=bold ctermfg=86 ctermbg=NONE cterm=bold
hi SpecialKey guifg=#66D9EF guibg=NONE guisp=NONE gui=italic ctermfg=81 ctermbg=NONE cterm=NONE
hi Constant guifg=#AE81FF guibg=NONE guisp=NONE gui=bold ctermfg=141 ctermbg=NONE cterm=bold
hi Tag guifg=#F92672 guibg=NONE guisp=NONE gui=italic ctermfg=197 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=#66D9EF guibg=NONE guisp=NONE gui=NONE ctermfg=81 ctermbg=NONE cterm=NONE
hi MatchParen guifg=#000000 guibg=#FD971F guisp=#FD971F gui=bold ctermfg=NONE ctermbg=208 cterm=bold
hi Repeat guifg=#F92672 guibg=NONE guisp=NONE gui=bold ctermfg=197 ctermbg=NONE cterm=bold
hi Directory guifg=#A6E22E guibg=NONE guisp=NONE gui=bold ctermfg=112 ctermbg=NONE cterm=bold
hi Underlined guifg=#808080 guibg=NONE guisp=NONE gui=underline ctermfg=8 ctermbg=NONE cterm=underline
hi DiffAdd guifg=NONE guibg=#13354A guisp=#13354A gui=NONE ctermfg=NONE ctermbg=23 cterm=NONE
hi cursorim guifg=#192224 guibg=#536991 guisp=#536991 gui=NONE ctermfg=235 ctermbg=60 cterm=NONE

hi PreCondit guifg=#A6E22E guibg=NONE guisp=NONE gui=bold ctermfg=112 ctermbg=NONE cterm=none
hi Todo     guifg=#d7af00   guibg=#272822   guisp=#272822   gui=bold        ctermfg=178     ctermbg=NONE    cterm=bold
hi Special  guifg=#008787   guibg=#1c1c1c   guisp=#1c1c1c   gui=bold        ctermfg=30      ctermbg=NONE    cterm=bold,italic 
hi Include  guifg=#FF5FFF   guibg=NONE      guisp=NONE      gui=NONE        ctermfg=205     ctermbg=NONE    cterm=NONE
hi Type     guifg=#0087ff   guibg=NONE      guisp=NONE      gui=bold        ctermfg=33      ctermbg=NONE    cterm=bold
hi Boolean  guifg=#AE81FF   guibg=NONE      guisp=NONE      gui=NONE        ctermfg=141     ctermbg=NONE    cterm=bold
hi Comment  guifg=#008787   guibg=NONE      guisp=NONE      gui=NONE        ctermfg=30      ctermbg=NONE    cterm=NONE
hi CursorLine guifg=NONE    guibg=#3E3D32   guisp=#3E3D32   gui=NONE        ctermfg=NONE    ctermbg=233     cterm=NONE
hi LineNr   guifg=NONE      guibg=#000000   guisp=#1c1c1c   gui=NONE        ctermfg=NONE    ctermbg=234     cterm=NONE
hi Number   guifg=#d75fff   guibg=NONE      guisp=NONE      gui=bold        ctermfg=171     ctermbg=NONE    cterm=NONE
hi String   guifg=#00af87   guibg=NONE      guisp=NONE      gui=bold        ctermfg=36      ctermbg=NONE    cterm=bold

hi link Union           Type
hi link Typedef         Function
hi link Macro           Include
hi link Structure       Type 
hi link StorageClass    Type
hi link CTagsClass      Type
