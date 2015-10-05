" personal information
let g:email="niklas@inet.tu-berlin.de"
let g:username="Niklas Semmler"

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim/
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
call vundle#begin()

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
Bundle 'gmarik/Vundle.vim'
" snippets
Bundle 'SirVer/ultisnips'
"Bundle 'honza/vim-snippets'
" templates in vim (mostly for latex)
Bundle 'aperezdc/vim-template'
" list of open buffers
Bundle 'fholgado/minibufexpl.vim'
" the info bar
Bundle 'Lokaltog/powerline'
" git and vim
" TODO: read more into git
Bundle 'tpope/vim-fugitive'
" "Bundle 'klen/python-mode'  " a lot of stuff for python
" show red/green test bar
Bundle 'reinh/vim-makegreen'
Bundle 'lambdalisue/nose.vim'
" " directory structure
Bundle 'scrooloose/nerdtree'
" syntax checking
Bundle 'scrooloose/syntastic'
" python autocomplete
Bundle 'davidhalter/jedi-vim'
" erlang for vim
Bundle 'jimenezrick/vimerl'
" solarized colors
Bundle 'altercation/vim-colors-solarized'
" better finding with <C-P>
Bundle 'kien/ctrlp.vim'
" orienting with tags
Bundle 'majutsushi/tagbar'
" open pdf files in vim
Bundle 'rhysd/open-pdf.vim'
" vim surround del
" ' => ds', change ' to ( => cs'(, add ' => ys + text obj + '
Bundle 'tpope/vim-surround'
" Text Object for arguments (d/c/v + i/a + a)
Bundle 'vim-scripts/argtextobj.vim'
" Text Object for indentation (d/c/v + i/a + i)
Bundle 'michaeljsmith/vim-indent-object'
" Easy Motion
Bundle 'Lokaltog/vim-easymotion'
"" Eclim
Bundle 'derekwyatt/vim-scala'
Bundle 'initrc/eclim-vundle'
"" Bookmarks and(!) annotations
Bundle 'sukima/xmledit'
"Bundle 'MattesGroeger/vim-bookmarks'
"" Undo
Bundle 'sjl/gundo.vim'
" Ag / Searching / Grep substitute
Bundle 'rking/ag.vim'

call vundle#end()
filetype plugin indent on     " required!
syntax on

" leader
let mapleader=","

"============> Plugin customizations
" > Syntastic
let g:syntastic_python_pylint_args = "--extension-pkg-whitelist=numpy"
let g:syntastic_java_javac_autoload_maven_classpath = 0

" > NerdTree
nmap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeWinPos="left"

" > TagBar
nmap <leader>f :TagbarToggle<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
let g:tagbar_left = 0

"" go up the tree to find tags file
"set tags=tags;/
"" scala to tagbar
"" XXX: Replace by vim-scala?
"let g:tagbar_type_scala = {
"    \ 'ctagstype' : 'scala',
"    \ 'sro'       : '.',
"    \ 'kinds'     : [
"      \ 'p:packages',
"      \ 'T:types:1',
"      \ 't:traits',
"      \ 'o:objects',
"      \ 'O:case objects',
"      \ 'c:classes',
"      \ 'C:case classes',
"      \ 'm:methods',
"      \ 'V:values:1',
"      \ 'v:variables:1'
"    \ ]
"\ }
" > Ulti Snippets
let g:UltiSnipsJumpForwardTrigger="<tab>"
"   g:UltiSnipsJumpBackwardTrigger="<alt-tab>"

" > nose & makegreen
autocmd BufNewFile,BufRead *.py map <buffer> <S-T> :MakeGreen %<CR>

" > Ctrl-P
let g:ctrlp_working_path_mode = 0

" > solarized
" FIXME: fix colors in terminator/tmux to be same as in xterm

" > jedi-vim
" <K> --> show doc string
" <leader>g --> show first definition
" <leader>d --> show original definition
" <leader>r --> rename all occurrences of var
" <leader>n --> show all uses of var
let g:jedi#use_tabs_not_buffers = 0

" Syntastic
nmap <leader>e :call ErrorToggle()<CR>

let g:syntastic_loc_list_height=15
let g:error_list_is_closed = 1
function! ErrorToggle()
    if g:error_list_is_closed
        Errors
        let g:error_list_is_closed = 0
    else
        lclose
        let g:error_list_is_closed = 1
    endif
endfunction

" > powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" > ConqueTerm
let g:ConqueTerm_StartMessages = 0

" > gUndo
nmap <leader>u :GundoToggle<CR>
"===================================

" For the tex plugin
let g:tex_indent_brace = 1
let g:tex_indent_and = 1 " why the f*** is this still avtive??
let g:tex_indent_items = 1

" Tabs
map <C-e>l :tabn<CR>
map <C-e>h :tabp<CR>
map <C-e>s :tab split<CR>:MBEOpen<CR>
map <C-e>n :tabnew<CR>:MBEOpen<CR>
map <C-e>c :tabclose<CR>

" Save <Control>-S.
map <C-s> :w<CR>

" Search for selected term
vnorem // y/<c-r>"<cr>

" Change config,
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>es :split $MYVIMRC<cr>
nnoremap <leader>ez :vsp ~/.zshrc_local<CR>

" Set spell checker
nnoremap <leader>le :set spell spelllang=en_US<CR>
nnoremap <leader>ld :set spell spelllang=de_de<CR>
nnoremap <leader>lg :set spell spelllang=de_de<CR>
nnoremap <leader>lo :set nospell<CR>

" Use semicolon and colon
nnoremap ; :

" yank till end of cursor
nnoremap Y y$

" Improved copy & paste
set pastetoggle=<leader>p

" Reach insert mode easier.
inoremap jk <esc>

" Delete trailing whitespaces
nnoremap <leader><space> :%s/\s\+$//<cr>''

" Retain visual selection on tabbing.
vnoremap < <gv
vnoremap > >gv

" Don't start ex mode
nnoremap Q <nop>

" Basic editor commands.
set number
" set nowrap
set wrap
set textwidth=80
set linebreak
nmap j gj
nmap k gk
nmap vj vgj
nmap vk vgk
set bs=2 " defines backspace
"no auto wrapping

" Tabulators
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" History & undo.
set history=700
set undolevels=700
" TODO: persistent undo

" Set splits to below and bottom.
set splitbelow
set splitright

" Ignore some files
set wildignore=*.swp,*.bak,*.pyc,*.class,*.aux,*.pdf,*.bbl,*.blg,*.log

" Sudo write
cmap w!! w !sudo tee % >/dev/null
cmap vsb vert sb 

" Remember cursor position.
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

" Replace var names.
nmap <leader>w :%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>

" Undo for hidden buffers
set hidden

" Search.
" TODO: show number of matches
set incsearch
set ignorecase
set smartcase
set hlsearch
set showmatch " highlight parenthesis
nmap <leader>q :nohlsearch<CR>

" Source on write.
autocmd! bufwritepost .vimrc source %

" TODO: highlight insert mode on the line
" TODO: remove tabbing on parentheses and colons
" TODO: show line on character position 80
" TODO: change ultisnips keys:
" TODO: mark wrapped lines

" mkdir -p ~/.vim/ftplugin
" wget http://www.vim.org/scripts/download_script.php?src_id=5492 ~/.vim/ftplugin

" Force urself to use vim for good
inoremap <C-c> <Nop>
" noremap K <C-w>k
" noremap J <C-w>j

" listchars change
"
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:_"
set list

" Troubleshooting.
" prohibit accidentially closing split
noremap <C-w><C-c> <Nop>

" show command and autocomplete for command line
set wildmenu
set showcmd


"============> Colors
" colorscheme molokai
" set background=light
colorscheme badwolf
" colorscheme solarized
" set background=dark

" highlight only c
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%80v', 100)
"highlight ColorColumn ctermbg=9

" Mark cursor in insert mode for more transparency.
set nocursorline
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline
highlight CursorLineNr ctermbg=9

" file encoding
set fileencoding=utf-8

" Show white spaces TODO
"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()
"===================================


" for wrapping files for diff
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

"=========> Experimental
" gv highlights last selected text
" gV now highlights last entered text
nnoremap gV `[v`]

" save session / Super-Save
nnoremap <leader>s :mksession<CR>

" search with Ag / like grep
nnoremap <leader>a :Ag 

" buffers access over leader
nnoremap <leader>bd :bd
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>

"" Don't redraw while executing macros (good performance config)
"set lazyredraw
