" my .tex files are ALWAYS LaTeX
let g:tex_flavor = "latex"

" spell checking
set spell spelllang=en_us

" LaTeX (rubber) macro

" TODO:
" set two variables, one for the complete file name and one for the file name
" without extension
" if a main.tex file exists in the same directory: point the variable to this
" else: use the file that is open

nnoremap <leader>b :w<CR>:!rubber --pdf --inplace --warn all %<CR>
" XXX: Hack for the current project.
"nnoremap <leader>b :w<CR>:!rubber --pdf --inplace --warn all main.tex<CR>

" View PDF macro; '%:r' is current file's root (base) name.
nnoremap <leader>v :!zathura %:r.pdf 2> /dev/null &<CR><CR>
" XXX: Hack for the current project.
" nnoremap <leader>v :!zathura main.pdf 2> /dev/null &<CR><CR>

let g:username = "Niklas Semmler"
let g:email = "semmler@kth.se"
