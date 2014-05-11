if exists("b:current_syntax")
    finish
endif

" define words
syn keyword dslBlockStmt assignments keys paths map
syn keyword dslBlockStmt get set create delete
syn keyword dslFunction key hl_key parent_of set_all
syn keyword dslTodo TODO FIXME contained
syn match dslType "[a-z)\]]\zs\.uint32\ze"
syn match dslType "[a-z)\]]\zs\.ipv4_str\ze"
syn match dslContextKey "\v\$pos"
syn match dslContextKey "\v\$val"
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
" FIXME: Don't fold all lines after region
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
