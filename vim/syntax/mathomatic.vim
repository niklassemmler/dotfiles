" Vim syntax file
" Language: 	Mathomatic
" Remark:		http://www.mathomatic.org/
" Version: 		1
" Last Change:	2018 May 22
" Maintainer: 	Niklas Semmler
"------------------------------------------------------------------

if exists("b:current_syntax")
  finish
endif

" keywords are case-sensitive
syn case match

syn match mathomaticIdentifier /\c\#[0-9_-]\>/

" statement keywords
syn keyword mathomaticStatement approximate calculate clear code compare copy derivative display divide echo edit exit eliminate 
syn keyword mathomaticStatement extrema factor for fraction help imaginary integrate laplace limit list
syn keyword mathomaticStatement nintegrate optimize pause plot product push quit read real repeat replace roots
syn keyword mathomaticStatement save set simplify solve sum tally taylor unfactor variables version

" comments
syn region mathomaticComment start=";" end="$" 

syn match mathomaticNumber /\d\+/
syn match mathomaticOp /[*^/+-]/
syn match mathomaticParen /[()]/

"-------------------------------------
" and now for the highlighting

" things with one-to-one mapping
hi def link mathomaticIdentifier Identifier
hi def link mathomaticComment Comment
" hi def link mathomaticNumber Constant
hi def link mathomaticOp Keyword
hi def link mathomaticParen Function
hi def link mathomaticType Type

" arbitrary mappings
hi def link mathomaticStatement Type

let b:current_syntax = "mathomatic"

