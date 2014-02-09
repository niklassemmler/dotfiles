set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
call vundle#rc()

" let Vundle manage Vundle
" required! 
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" basic for managing bundles
Bundle 'gmarik/vundle'
" snippets
Bundle 'snipMate'
" list of open buffers
Bundle 'fholgado/minibufexpl.vim'
" the info bar
Bundle 'Lokaltog/powerline'
" git and python
Bundle 'tpope/vim-fugitive'  
"Bundle 'klen/python-mode'  " a lot of stuff for python
" show red/green test bar
Bundle 'reinh/vim-makegreen'
" compile with nose needed for makegreen
Bundle 'olethanh/Vim-nosecompiler'
" directory structure 
Bundle 'scrooloose/nerdtree'
" syntax checking
Bundle 'scrooloose/syntastic'
" python autocomplete
Bundle 'davidhalter/jedi-vim'
" erlang for vim
Bundle 'jimenezrick/vimerl'

filetype plugin indent on     " required!
syntax on

" customization place here
" source on write
autocmd! bufwritepost .vimrc source %

" remove highlight of last search TODO
" noremap <C-n> :nohl<CR>

" leader
let mapleader=","

" improved copy & paste
set pastetoggle=<F2>
"set clipboard=unnamed " somehow messes up 'yy'

" switch buffer with Ctrl-e + h/j
map <C-e>l :bn!<CR>
map <C-e>h :bp!<CR>

" save
map <C-s> :w<CR>

" change config
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" get used to learning vim the hard way
" map <Left> <NOP>
" map <Right> <NOP>
" map <Down> <NOP>
" map <Up> <NOP>
" imap <Left> <NOP>
" imap <Right> <NOP>
" imap <Down> <NOP>
" imap <Up> <NOP>
" inoremap jk <esc>

" easier tabbing of content
vnoremap < <gv 
vnoremap > >gv 

" Show white spaces TODO
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" variables for snippets
let g:snips_author = 'Niklas Semmler'
let g:snips_student_id = '346378'

" more Editor like
set number
set nowrap
set bs=2 " defines backspace
set fo-=t "no auto wrapping
set colorcolumn=80
highlight ColorColumn ctermbg=233

" tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" history & undo
set history=700
set undolevels=700

" mkdir -p ~/.vim/ftplugin
" wget http://www.vim.org/scripts/download_script.php?src_id=5492 ~/.vim/ftplugin

" set splits to below and bottom
set splitbelow
set splitright

" activate cursor
set cursorline

" NerdTree
map <C-T> :NERDTreeToggle<CR>

" more python customization
autocmd BufNewFile,BufRead *.py compiler nose
autocmd BufNewFile,BufRead *.py map <buffer> <S-T> :MakeGreen %<CR>
"autocmd BufNewFile,BufRead *.py map <buffer> <C-T> :w<CR>:!/usr/bin/env nosetests % <CR>
autocmd BufNewFile,BufRead *.py set tw=79 " max line length following PEP

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Remember positions
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" recognize .yang files
au BufRead,BufNewFile *.yang set filetype=yang

" Replace var names
nmap <leader>w :%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>

" Let me save with Control S
nmap <C-S> :w<CR>
imap <C-S> <Esc>:w<CR>a
