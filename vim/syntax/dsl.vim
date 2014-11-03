" Vim syntax file
" Language:         DSL for specifying mappings between YANG files
" Maintainer:       Niklas Semmler
" Last Change:      April 29, 2014
if exists("b:current_syntax")
    finish
endif

" define words
syn keyword dslBlockStmt keys def set get create delete map
syn keyword dslFunction leaf parent add append sub path str int
syn keyword dslTodo TODO FIXME contained
"syn match dslType "[a-z)\]]\zs\.uint32\ze"
"syn match dslType "[a-z)\]]\zs\.ipv4_str\ze"
"syn match dslContextKey "\v\$pos"
"syn match dslContextKey "\v\$val"
syn match dslOperatorFormat "%[a-z]" contained
syn match dslOperator "/" transparent
syn match dslOperator "=" transparent
syn match dslNumber "\d\+"
syn match dslNumber "\d\+.\d."
syn match dslNumber "0x\x"
syn match dslComment "//[^$]*$" contains=dslTodo
syn region dslString start=+'+ end=+'+ contains=dslOperatorFormat
syn region dslComment start=+/\*+ end=+\*/+ contains=dslTodo

" Folding
syn region dslBlockCode start=+"+ end=+";+ keepend transparent fold

"-------------------------------------
" highlighting

hi def link dslBlockStmt Statement
hi def link dslContextKey Keyword
hi def link dslString String
hi def link dslNumber Number
hi def link dslFunction Function
hi def link dslType Type
hi def link dslOperatorFormat Operator
hi def link dslComment Comment
hi def link dslTodo Todo

let b:current_syntax = "yang_dsl"
