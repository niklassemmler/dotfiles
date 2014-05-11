" personal information
let g:email="metaswirl@gmail.com"
let g:username="metawirl"

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
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
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
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
" vim surround??
"Bundle tpope/vim-surround


filetype plugin indent on     " required!
syntax on

" leader
let mapleader=","

"============> Plugin customizations
" > NerdTree
nmap <leader>t :NERDTreeToggle<CR>
" > TagBar
nmap <leader>f :TagbarToggle<CR>

" > NerdTree
nmap <leader>t :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"
" > TagBar
nmap <leader>f :TagbarToggle<CR>
let g:tagbar_left = 1
" > Ulti Snippets
let g:UltiSnipsJumpForwardTrigger="<tab>"
"   g:UltiSnipsJumpBackwardTrigger="<alt-tab>"

" > nose & makegreen
autocmd BufNewFile,BufRead *.py map <buffer> <S-T> :MakeGreen %<CR>

" > solarized
" FIXME: fix colors in terminator/tmux to be same as in xterm

" > jedi-vim
" <K> --> show doc string
" <leader>g --> show first definition
" <leader>d --> show original definition
" <leader>r --> rename all occurrences of var
" <leader>n --> show all uses of var

" > powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" > ConqueTerm
let g:ConqueTerm_StartMessages = 0
"===================================

" Tabs
map <C-e>l :tabn<CR>
map <C-e>h :tabp<CR>
map <C-e>s :tab split<CR>:MBEOpen<CR>
map <C-e>n :tabnew<CR>:MBEOpen<CR>
map <C-e>c :tabclose<CR>

" Save <Control>-S.
map <C-s> :w<CR>

" Change config,
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>es :split $MYVIMRC<cr>

" Improved copy & paste
set pastetoggle=<leader>p

" Reach insert mode easier.
inoremap jk <esc>

" Delete trailing whitespaces
nnoremap <leader>s :%s/\s\+$//<cr>''

" Retain visual selection on tabbing.
vnoremap < <gv
vnoremap > >gv

" Basic editor commands.
set number
" set nowrap
set wrap
set textwidth=79
set linebreak
nmap j gj
nmap k gk
nmap vj vgj
nmap vk vgk
set bs=2 " defines backspace
" set fo-=t
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

" Save with <Control>-S.
nmap <C-S> :w<CR>
imap <C-S> <Esc>:w<CR>a

" Search.
" TODO: show number of matches
set incsearch
set ignorecase
set smartcase
set hlsearch
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
noremap K <C-w>k
noremap J <C-w>j

" Troubleshooting.
" prohibit accidentially closing split
noremap <C-w><C-c> <Nop>

"============> Colors
" Colorscheme solarized
set background=dark
colorscheme solarized
set colorcolumn=80
highlight ColorColumn ctermbg=9

" Mark cursor in insert mode and showcmd for more transparency.
set showcmd
set nocursorline
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline
highlight CursorLineNr ctermbg=9

" Show white spaces TODO
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"===================================
