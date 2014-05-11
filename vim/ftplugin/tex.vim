" my .tex files are ALWAYS LaTeX
let g:tex_flavor = "latex"

" spell checking
set spell spelllang=en_us

" LaTeX (rubber) macro
nnoremap <leader>b :w<CR>:!rubber --pdf --inplace --warn all %<CR>

" View PDF macro; '%:r' is current file's root (base) name.
nnoremap <leader>v :!zathura %:r.pdf &<CR><CR>

let g:username = "Niklas Semmler"
let g:email = "semmler@kth.se"
