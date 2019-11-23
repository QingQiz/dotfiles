" Vim syntax file
" Language:	GNU Assembler
" Maintainer:	QingQiz < sofeeys@outlook.com >
" Last Change:	2019 Nov 21


" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

set iskeyword=@,48-57,_,192-255,46,37
let s:cpo_save = &cpo
set cpo&vim

syn case match

syntax keyword asmSpecial TODO XXX FIXME NOTE contained

syn case ignore

syn region asmComment		start="/\*" end="\*/" contains=asmSpecial
syn region asmComment		start="//" end="$" keepend contains=asmSpecial
syn match asmComment		/[#;!|].*/ contains=asmSpecial

syn region asmString		start="\"" end="\""
syn region asmString		start="\'" end="\'"

syn match decNumber		"[0-9][0-9_]\{0,}d\{0,1}"
syn match decNumber		"0d[0-9_]\+"
syn match octNumber		"[0-7_]\+[oq]"
syn match octNumber		"0[oq][0-7_]\+"
syn match hexNumber		"0[xh][0-9a-fA-F_]\+"
syn match hexNumber		"[0-9][0-9a-fA-F_]*h"
syn match hexNumber		"$[0-9][0-9a-fA-F_]\{0,}"
syn match binNumber		"[01][01_]\{0,}[by]"
syn match binNumber		"0[by][01_]\+"

syn match asmVar		"[a-z_][a-z0-9_]*"
syn match asmLabel		"^\s*[a-z_.][a-z0-9_]*\ze:"
syn match asmLabel		"\.[a-z0-9_]*"

syn keyword asmType long ascii asciz byte double float hword octa quad short single space string word

syn keyword asmDirective .align .ascii .bcd .bss .byte .2byte .4byte .8byte .comm .data .double .even 
syn keyword asmDirective .ext .file .float .globl .group .hidden .ident .lcomm .local .long .popsection
syn keyword asmDirective .previous .pushsection .quad .rel .section .set .size .skip .sleb128 string
syn keyword asmDirective .symbolic .tbss .tcomm .tdata .text .type .uleb128 .value .weak .zero

syn keyword asmType long ascii asciz byte double float hword int octa quad short single space string word dword

syn keyword asmInst aaa aad aam aas adc adcx add addpd addps addsd addss addsubpd
syn keyword asmInst addsubps adox aesdec aesdeclast aesenc aesenclast aesimc aeskeygenassist
syn keyword asmInst and andn andnpd andnps andpd andps arpl bextr blendpd blendps blendvpd
syn keyword asmInst blendvps blsi blsmsk blsr bndcl bndcn bndcu bndldx bndmk bndmov bndstx
syn keyword asmInst bound bsf bsr bswap bt btc btr bts bzhi call cbw cdq cdqe clac clc cld
syn keyword asmInst cldemote clflush clflushopt cli clts clwb cmc cmovCC cmp cmppd cmpps cmps
syn keyword asmInst cmpsb cmpsd cmpsd cmpsq cmpss cmpsw cmpxchg cmpxchg16b cmpxchg8b comisd
syn keyword asmInst comiss cpuid cqo crc32 cvtdq2pd cvtdq2ps cvtpd2dq cvtpd2pi cvtpd2ps cvtpi2pd
syn keyword asmInst cvtpi2ps cvtps2dq cvtps2pd cvtps2pi cvtsd2si cvtsd2ss cvtsi2sd cvtsi2ss
syn keyword asmInst cvtss2sd cvtss2si cvttpd2dq cvttpd2pi cvttps2dq cvttps2pi cvttsd2si cvttss2si
syn keyword asmInst cwd cwde daa das dec div divpd divps divsd divss dppd dpps emms enter
syn keyword asmInst extractps f2xm1 fabs fadd faddp fbld fbstp fchs fclex fcmovCC fcom fcomi
syn keyword asmInst fcomip fcomp fcompp fcos fdecstp fdiv fdivp fdivr fdivrp ffree fiadd ficom
syn keyword asmInst ficomp fidiv fidivr fild fimul fincstp finit fist fistp fisttp fisub fisubr
syn keyword asmInst fld fld1 fldcw fldenv fldl2e fldl2t fldlg2 fldln2 fldpi fldz fmul fmulp
syn keyword asmInst fnclex fninit fnop fnsave fnstcw fnstenv fnstsw fpatan fprem fprem1 fptan
syn keyword asmInst frndint frstor fsave fscale fsin fsincos fsqrt fst fstcw fstenv fstp fstsw
syn keyword asmInst fsub fsubp fsubr fsubrp ftst fucom fucomi fucomip fucomp fucompp fwait fxam
syn keyword asmInst fxch fxrstor fxsave fxtract fyl2x fyl2xp1 gf2p8affineinvqb gf2p8affineqb
syn keyword asmInst gf2p8mulb haddpd haddps hlt hsubpd hsubps idiv imul in inc ins insb insd
syn keyword asmInst insertps insw int n int1 int3 into invd invlpg invpcid iret iretd 
syn keyword asmInst kaddb kaddd kaddq kaddw kandb kandd kandnb kandnd kandnq kandnw kandq kandw
syn keyword asmInst kmovb kmovd kmovq kmovw knotb knotd knotq knotw korb kord korq kortestb
syn keyword asmInst kortestd kortestq kortestw korw kshiftlb kshiftld kshiftlq kshiftlw kshiftrb
syn keyword asmInst kshiftrd kshiftrq kshiftrw ktestb ktestd ktestq ktestw kunpckbw kunpckdq
syn keyword asmInst kunpckwd kxnorb kxnord kxnorq kxnorw kxorb kxord kxorq kxorw lahf lar lddqu
syn keyword asmInst ldmxcsr lds lea leave les lfence lfs lgdt lgs lidt lldt lmsw lock lods lodsb
syn keyword asmInst lodsd lodsq lodsw loop loopCC lsl lss ltr lzcnt maskmovdqu maskmovq maxpd
syn keyword asmInst maxps maxsd maxss mfence minpd minps minsd minss monitor mov mov mov movapd
syn keyword asmInst movaps movbe movd movddup movdir64b movdiri movdq2q movdqa movdqu movhlps
syn keyword asmInst movhpd movhps movlhps movlpd movlps movmskpd movmskps movntdq movntdqa movnti
syn keyword asmInst movntpd movntps movntq movq movq movq2dq movs movsb movsd movsd movshdup
syn keyword asmInst movsldup movsq movss movsw movsx movsxd movupd movups movzx mpsadbw mul mulpd
syn keyword asmInst mulps mulsd mulss mulx mwait neg nop not or orpd orps out outs outsb outsd
syn keyword asmInst outsw pabsb pabsd pabsq pabsw packssdw packsswb packusdw packuswb paddb
syn keyword asmInst paddd paddq paddsb paddsw paddusb paddusw paddw palignr pand pandn pause pavgb
syn keyword asmInst pavgw pblendvb pblendw pclmulqdq pcmpeqb pcmpeqd pcmpeqq pcmpeqw pcmpestri
syn keyword asmInst pcmpestrm pcmpgtb pcmpgtd pcmpgtq pcmpgtw pcmpistri pcmpistrm pdep pext pextrb
syn keyword asmInst pextrd pextrq pextrw phaddd phaddsw phaddw phminposuw phsubd phsubsw phsubw
syn keyword asmInst pinsrb pinsrd pinsrq pinsrw pmaddubsw pmaddwd pmaxsb pmaxsd pmaxsq pmaxsw
syn keyword asmInst pmaxub pmaxud pmaxuq pmaxuw pminsb pminsd pminsq pminsw pminub pminud pminuq
syn keyword asmInst pminuw pmovmskb pmovsx pmovzx pmuldq pmulhrsw pmulhuw pmulhw pmulld pmullq
syn keyword asmInst pmullw pmuludq pop popa popad popcnt popf popfd popfq por prefetchw prefetchH
syn keyword asmInst psadbw pshufb pshufd pshufhw pshuflw pshufw psignb psignd psignw pslld pslldq
syn keyword asmInst psllq psllw psrad psraq psraw psrld psrldq psrlq psrlw psubb psubd psubq
syn keyword asmInst psubsb psubsw psubusb psubusw psubw ptest ptwrite punpckhbw punpckhdq
syn keyword asmInst punpckhqdq punpckhwd punpcklbw punpckldq punpcklqdq punpcklwd push pusha pushad
syn keyword asmInst pushf pushfd pushfq pxor rcl rcpps rcpss rcr rdfsbase rdgsbase rdmsr rdpid
syn keyword asmInst rdpkru rdpmc rdrand rdseed rdtsc rdtscp rep repe repne repnz repz ret rol ror
syn keyword asmInst rorx roundpd roundps roundsd roundss rsm rsqrtps rsqrtss sahf sal sar sarx sbb
syn keyword asmInst scas scasb scasd scasw setCC sfence sgdt sha1msg1 sha1msg2 sha1nexte sha1rnds4
syn keyword asmInst sha256msg1 sha256msg2 sha256rnds2 shl shld shlx shr shrd shrx shufpd shufps
syn keyword asmInst sidt sldt smsw sqrtpd sqrtps sqrtsd sqrtss stac stc std sti stmxcsr stos stosb
syn keyword asmInst stosd stosq stosw str sub subpd subps subsd subss swapgs syscall sysenter
syn keyword asmInst sysexit sysret test tpause tzcnt ucomisd ucomiss ud umonitor umwait unpckhpd
syn keyword asmInst unpckhps unpcklpd unpcklps valignd valignq vblendmpd vblendmps vbroadcast
syn keyword asmInst vcompresspd vcompressps vcvtpd2qq vcvtpd2udq vcvtpd2uqq vcvtph2ps vcvtps2ph
syn keyword asmInst vcvtps2qq vcvtps2udq vcvtps2uqq vcvtqq2pd vcvtqq2ps vcvtsd2usi vcvtss2usi
syn keyword asmInst vcvttpd2qq vcvttpd2udq vcvttpd2uqq vcvttps2qq vcvttps2udq vcvttps2uqq
syn keyword asmInst vcvttsd2usi vcvttss2usi vcvtudq2pd vcvtudq2ps vcvtuqq2pd vcvtuqq2ps vcvtusi2sd
syn keyword asmInst vcvtusi2ss vdbpsadbw verr verw vexpandpd vexpandps vextractf128 vextractf32X4
syn keyword asmInst vextractf32X8 vextractf64X2 vextractf64X4 vextracti128 vextracti32X4
syn keyword asmInst vextracti32X8 vextracti64X2 vextracti64X4 vfixupimmpd vfixupimmps vfixupimmsd
syn keyword asmInst vfixupimmss vfmadd132pd vfmadd132ps vfmadd132sd vfmadd132ss vfmadd213pd
syn keyword asmInst vfmadd213ps vfmadd213sd vfmadd213ss vfmadd231pd vfmadd231ps vfmadd231sd
syn keyword asmInst vfmadd231ss vfmaddsub132pd vfmaddsub132ps vfmaddsub213pd vfmaddsub213ps
syn keyword asmInst vfmaddsub231pd vfmaddsub231ps vfmsub132pd vfmsub132ps vfmsub132sd vfmsub132ss
syn keyword asmInst vfmsub213pd vfmsub213ps vfmsub213sd vfmsub213ss vfmsub231pd vfmsub231ps vfmsub231sd
syn keyword asmInst vfmsub231ss vfmsubadd132pd vfmsubadd132ps vfmsubadd213pd vfmsubadd213ps
syn keyword asmInst vfmsubadd231pd vfmsubadd231ps vfnmadd132pd vfnmadd132ps vfnmadd132sd vfnmadd132ss
syn keyword asmInst vfnmadd213pd vfnmadd213ps vfnmadd213sd vfnmadd213ss vfnmadd231pd vfnmadd231ps
syn keyword asmInst vfnmadd231sd vfnmadd231ss vfnmsub132pd vfnmsub132ps vfnmsub132sd vfnmsub132ss
syn keyword asmInst vfnmsub213pd vfnmsub213ps vfnmsub213sd vfnmsub213ss vfnmsub231pd vfnmsub231ps
syn keyword asmInst vfnmsub231sd vfnmsub231ss vfpclasspd vfpclassps vfpclasssd vfpclassss vgatherdpd
syn keyword asmInst vgatherdpd vgatherdps vgatherdps vgatherqpd vgatherqpd vgatherqps vgatherqps
syn keyword asmInst vgetexppd vgetexpps vgetexpsd vgetexpss vgetmantpd vgetmantps vgetmantsd vgetmantss
syn keyword asmInst vinsertf128 vinsertf32X4 vinsertf32X8 vinsertf64X2 vinsertf64X4 vinserti128
syn keyword asmInst vinserti32X4 vinserti32X8 vinserti64X2 vinserti64X4 vmaskmov vmovdqa32 vmovdqa64
syn keyword asmInst vmovdqu16 vmovdqu32 vmovdqu64 vmovdqu8 vpblendd vpblendmb vpblendmd vpblendmq
syn keyword asmInst vpblendmw vpbroadcast vpbroadcastb vpbroadcastd vpbroadcastm vpbroadcastq
syn keyword asmInst vpbroadcastw vpcmpb vpcmpd vpcmpq vpcmpub vpcmpud vpcmpuq vpcmpuw vpcmpw
syn keyword asmInst vpcompressd vpcompressq vpconflictd vpconflictq vperm2f128 vperm2i128 vpermb
syn keyword asmInst vpermd vpermi2b vpermi2d vpermi2pd vpermi2ps vpermi2q vpermi2w vpermilpd vpermilps
syn keyword asmInst vpermpd vpermps vpermq vpermt2b vpermt2d vpermt2pd vpermt2ps vpermt2q vpermt2w
syn keyword asmInst vpermw vpexpandd vpexpandq vpgatherdd vpgatherdd vpgatherdq vpgatherdq vpgatherqd
syn keyword asmInst vpgatherqd vpgatherqq vpgatherqq vplzcntd vplzcntq vpmadd52huq vpmadd52luq
syn keyword asmInst vpmaskmov vpmovb2m vpmovd2m vpmovdb vpmovdw vpmovm2b vpmovm2d vpmovm2q vpmovm2w
syn keyword asmInst vpmovq2m vpmovqb vpmovqd vpmovqw vpmovsdb vpmovsdw vpmovsqb vpmovsqd vpmovsqw
syn keyword asmInst vpmovswb vpmovusdb vpmovusdw vpmovusqb vpmovusqd vpmovusqw vpmovuswb vpmovw2m
syn keyword asmInst vpmovwb vpmultishiftqb vprold vprolq vprolvd vprolvq vprord vprorq vprorvd
syn keyword asmInst vprorvq vpscatterdd vpscatterdq vpscatterqd vpscatterqq vpsllvd vpsllvq vpsllvw
syn keyword asmInst vpsravd vpsravq vpsravw vpsrlvd vpsrlvq vpsrlvw vpternlogd vpternlogq vptestmb
syn keyword asmInst vptestmd vptestmq vptestmw vptestnmb vptestnmd vptestnmq vptestnmw vrangepd
syn keyword asmInst vrangeps vrangesd vrangess vrcp14pd vrcp14ps vrcp14sd vrcp14ss vreducepd vreduceps
syn keyword asmInst vreducesd vreducess vrndscalepd vrndscaleps vrndscalesd vrndscaless vrsqrt14pd
syn keyword asmInst vrsqrt14ps vrsqrt14sd vrsqrt14ss vscalefpd vscalefps vscalefsd vscalefss
syn keyword asmInst vscatterdpd vscatterdps vscatterqpd vscatterqps vshuff32X4 vshuff64X2 vshufi32X4
syn keyword asmInst vshufi64X2 vtestpd vtestps vzeroall vzeroupper wait wbinvd wrfsbase wrgsbase
syn keyword asmInst wrmsr wrpkru xabort xacquire xadd xbegin xchg xend xgetbv xlat xlatb xor xorpd
syn keyword asmInst xorps xrelease xrstor xrstors xsave xsavec xsaveopt xsaves xsetbv xtest encls
syn keyword asmInst encls enclu enclv getsec invept invvpid vmcall vmclear vmfunc vmlaunch vmptrld
syn keyword asmInst vmptrst vmread vmresume vmresume vmwrite vmxoff vmxon prefetchwt1 v4fmaddps
syn keyword asmInst v4fmaddss v4fnmaddps v4fnmaddss vexp2pd vexp2ps vgatherpf0dpd vgatherpf0dps
syn keyword asmInst vgatherpf0qpd vgatherpf0qps vgatherpf1dpd vgatherpf1dps vgatherpf1qpd vgatherpf1qps
syn keyword asmInst vp4dpwssd vp4dpwssds vrcp28pd vrcp28ps vrcp28sd vrcp28ss vrsqrt28pd vrsqrt28ps
syn keyword asmInst vrsqrt28sd vrsqrt28ss vscatterpf0dpd vscatterpf0dps vscatterpf0qpd vscatterpf0qps
syn keyword asmInst vscatterpf1dpd vscatterpf1dps vscatterpf1qpd vscatterpf1qps
syn keyword asmInst jz jmp jcc jz j jne jc jnz ja jb je jae

syn keyword asmInclude .include %include
syn keyword asmCond .ifdef %ifdef .ifndef %ifndef .if %if .else %else .endif %endif
syn keyword asmMacro .macro %macro .endmacro %endmacro

syn keyword asmReg rax eax ax ah al rcx ecx cx ch cl rdx edx dx dh dl rbx ebx bx bh bl
syn keyword asmReg rsp esp sp spl rbp ebp bp bpl rsi esi si sil rdi edi di dil
syn keyword asmReg ss cs ds es fs gs eip cr0 cr1 cr2 cr3 cr
syn keyword asmReg eflags cf pf af zf sf tf if df of iopl nt rf vm ac vif vip id

syn keyword asmKeyword extern section bits org global align dw db dd equ times descriptor pushq

hi def link asmString	string
hi def link asmInclude	Include
hi def link asmCond	PreCondit
hi def link asmMacro	Macro
hi def link asmComment	Comment
hi def link asmSpecial	TODO
hi def link hexNumber	Number
hi def link decNumber	Number
hi def link octNumber	Number
hi def link binNumber	Number
hi def link asmType	Statement
hi def link asmInst	function
hi def link asmLabel	Label
hi def link asmVar	SpecialVar
hi def link asmDirective	Statement
hi def link asmReg	Identifier
hi def link asmKeyword	Identifier

let b:current_syntax = "asm"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
