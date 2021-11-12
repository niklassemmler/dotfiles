set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4
set autowrite
setlocal foldmethod=syntax

" Based on vim-go
nmap <F1> :GoDef<CR>
nmap <F2> :GoDoc<CR>
nmap <F5> :GoBuild<CR>
nmap <F6> :GoTest<CR>
nmap <F7> :!dlv debug .<CR>

