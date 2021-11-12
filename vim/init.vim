" Manual
" <F1-F4> Documentation/Follow tags
" - <F4> Errors
" <F4-F8> Execution
" - <F4> Build
" - <F5> Test
" - <F6> Debug 
" <F9-F12> General
" - <F9> Directory
" - <F10> Undo
" - <F12> Git

" personal information
let g:email="niklas.semmler@mailbox.org"
let g:username="Niklas Semmler"

" NOTE: For new machine
" 1. download Vundle
" cd vim/bundle/; git clone https://github.com/VundleVim/Vundle.vim; cd ../../
" 2. install plugins
" VundleInstall

set nocompatible               " be iMproved

call plug#begin('~/.vim/bundle')


" let Vundle manage Vundle
" required!
"
" Brief help
" :PlugList          - list configured bundles
" :PlugInstall(!)    - install(update) bundles
" :PlugSearch(!) foo - search(or refresh cache first) for foo
" :PlugClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plug command are not allowed..
" basic for managing bundles

""" Completion
" snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" templates in vim (mostly for latex)
Plug 'aperezdc/vim-template'
" more autocomplete
" NOTE: YouCompleteMe takes forever to update/install
"Plug "Valloric/YouCompleteMe"
" NOTE: deoplete is the neovim alternative for YouCompleteMe
" Plug "Shougo/deoplete.nvim"
" Combine Tab
Plug 'ervandew/supertab'
"""

""" Visuals
" colorscheme badwolf
Plug 'sjl/badwolf'
" solarized colors
Plug 'altercation/vim-colors-solarized'
" colorscheme stellarized
Plug 'nightsense/stellarized'
" vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"""

""" Misc
" git and vim
" NOTE: So far I always preferred using the command line
"Plug 'tpope/vim-fugitive'
" produces a diff option for swp files
Plug 'chrisbra/Recover.vim'
" wakatime - measures time in editor
" Plug 'wakatime/vim-wakatime'
" unix interaction
Plug 'tpope/vim-eunuch'
"""

""" Programming (mostly python)
" NOTE: selectively activate when you start to use python again
Plug 'lambdalisue/nose.vim'
" syntax checking 
" NOTE: Really bad for python :(
" NOTE: and cannot handle large java programs. Probably need to add jars to
" classpath. But do I really want to that manually?
" Plug 'scrooloose/syntastic'
" python checker
" Plug 'nvie/vim-flake8'
" a lot of stuff for python
"Plug 'klen/python-mode'
" identpython
" Plug 'vim-scripts/indentpython'
" python autocomplete / Not needed due to youcompleteme?
"Plug 'davidhalter/jedi-vim'
" orienting with tags
" Plug 'majutsushi/tagbar'
" golang
Plug 'fatih/vim-go'
"""

""" Markdown
" markdown plugin to also get math support in markdown
Plug 'plasticboy/vim-markdown'
" align markdown tables with ":Align |" when visually marked
Plug 'vim-scripts/Align'
"""

""" LaTeX
" Plug 'lervag/vimtex'
"""

""" Git
" > git commands
" - Git show files
" - Git move target_path
" - Git blame | <CR> to return
Plug 'tpope/vim-fugitive'
"""

""" Smart editing
" vim surround del
" ' => ds', change ' to ( => cs'(, add ' => ys + text obj + '
Plug 'tpope/vim-surround'
" Text Object for arguments (d/c/v + i/a + a)
Plug 'vim-scripts/argtextobj.vim'
" Text Object for indentation (d/c/v + i/a + i)
Plug 'michaeljsmith/vim-indent-object'
" closing brackets
Plug 'Raimondi/delimitMate'
"""

""" Navigation
" Easy Motion
Plug 'Lokaltog/vim-easymotion'
" directory structure
Plug 'preservim/nerdtree'
" find files/tags/buffers with <C-P>
Plug 'ctrlpvim/ctrlp.vim'
" Ag / Searching / Grep substitute
Plug 'rking/ag.vim'
" list of open buffers
Plug 'ap/vim-buftabline'
" center text window
Plug 'junegunn/goyo.vim'
" sublime like multiple cursors (activate with <c-n> in visual mode)
Plug 'terryma/vim-multiple-cursors'

" undo tree
Plug 'mbbill/undotree'

call plug#end()

" leader
let mapleader=","

"============> Plugin customizations
" > Syntastic
" Default options from help syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=7
let g:error_list_is_closed = 1
" End
"let g:syntastic_python_pylint_args = "--extension-pkg-whitelist=numpy"
let g:syntastic_java_javac_autoload_maven_classpath = 0
let g:syntastic_c_checkers = ["gcc"]
let g:syntastic_python_checker = "flake8"
" key for ErrorToggle
nmap <leader>e :call ErrorToggle()<CR>

function! ErrorToggle()
    if g:error_list_is_closed
        Errors
        let g:error_list_is_closed = 0
    else
        lclose
        let g:error_list_is_closed = 1
    endif
endfunction

" > vim-markdown
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" > NerdTree
nmap <F9> :NERDTreeToggle<CR>
let g:NERDTreeWinPos="left"

" > TagBar
nmap <leader>f :TagbarToggle<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
let g:tagbar_left = 0

"" go up the tree to find tags file
set tags=./tags;/,tags;/
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

" > YCM and Supertab
" key bindings to make it compatible with Ultisnips
" Note: I am using C-N now for quickfix. 
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" > UltiSnippets better key bindings for UltiSnipsExpandTrigger
" key bindings to make it compatible with YCM/Supertab
" NOTE: Ultisnips AutoTrigger created some performance problems for me
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

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

" > nose & makegreen
autocmd BufNewFile,BufRead *.py map <buffer> <S-T> :MakeGreen %<CR>


" > powerline
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" > vim-buftabline
let g:buftabline_show = 1
let g:buftabline_numbers = 1
hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
hi TabLine ctermfg=Blue ctermbg=Yellow
hi TabLineSel ctermfg=Red ctermbg=Yellow

" > undo tree
nnoremap <F10> :UndotreeToggle<CR>

" > Git
nnoremap <F12> :Git<CR>

" > switch between errors
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
"===================================


" For the tex plugin
let g:tex_indent_brace = 1
let g:tex_indent_and = 1
let g:tex_indent_items = 1

" Tabs
map <C-e>l :tabn<CR>
map <C-e>h :tabp<CR>
map <C-e>s :tab split<CR>:MBEOpen<CR>
map <C-e>n :tabnew<CR>:MBEOpen<CR>
map <C-e>c :tabclose<CR>

" Search for selected term
vnorem // y/<c-r>"<cr>

" Change config,
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>es :split $MYVIMRC<cr>
nnoremap <leader>et :tabnew $MYVIMRC<cr>
nnoremap <leader>ez :vsp ~/.zshrc_local<CR>

" Set spell checker
nnoremap <leader>le :set spell spelllang=en_us<CR>
nnoremap <leader>ld :set spell spelllang=de_de<CR>
nnoremap <leader>lg :set spell spelllang=de_de<CR>
nnoremap <leader>lo :set nospell<CR>

" Use semicolon and colon
nnoremap ; :

" Improved copy & paste
set pastetoggle=<leader>p

" Reach insert mode easier.
inoremap jk <esc>

" Delete trailing whitespaces
nnoremap <leader><space> :%s/\s\+$//<cr>''

" add line after or before
nmap <C-O> o<Esc>j
nmap <C-S-O> O<Esc>k

" Retain visual selection on tabbing.
vnoremap < <gv
vnoremap > >gv

" Tab in command mode
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_

" logfile for debugging purposes
" set verbosefile=log.txt

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Don't start ex mode
nnoremap Q <nop>
" prohibit accidentially closing split
noremap <C-w><C-c> <Nop>

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
"no auto wrapping

" Tabulators
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
au BufNewFile,BufRead *.py
    \ set tabstop=4	|
    \ set softtabstop=4	|
    \ set shiftwidth=4	|
    \ set textwidth=79	|
    \ set shiftround	|
    \ set expandtab	|
    \ set autoindent	|
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2	|
    \ set softtabstop=2	|
    \ set shiftwidth=2

" History & undo.
set history=700
set undolevels=700
" Undo for hidden buffers
set hidden

" Set splits to below and bottom.
set splitbelow
set splitright

" Ignore some files
set wildignore=*.swp,*.bak,*.pyc,*.class,*.aux,*.pdf,*.bbl,*.blg,*.log

" Sudo write
cmap w!! w !sudo tee % >/dev/null

" fast vertical buffer split
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

" Force yourself to use vim for good
inoremap <C-c> <Nop>
" noremap K <C-w>k
" noremap J <C-w>j

" listchars change
"
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:_"
set list


" show command and autocomplete for command line
set wildmenu
set showcmd


"============> Colors
" colorscheme molokai
" set background=light
colorscheme slate
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

" search with Ag / like grep
nnoremap <leader>a :Ag 

" buffers access over leader
nnoremap <leader>bd :bd
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>

"" Don't redraw while executing macros (good performance config)
"set lazyredraw

"--- Copy to system register
nmap <leader>c "*y

"--- Paste from system register
nmap <leader>v "*p

"--- windows specific
" copy (write) highlighted text to .vimbuffer
" I need a better shortcut!
vmap <C-t> Jgvyu:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe<CR><CR>
vmap <C-y> y:new ~/.vimbuffer<CR>VGp:x<CR> \| :!cat ~/.vimbuffer \| clip.exe<CR><CR>



"--- new
" swap selections
vnoremap <leader>d "tdmt
vnoremap <leader>p "rd"tP't"rP

" copy to last accessed split
nnoremap <leader>w y<c-w>pp<c-w>p

" reformat paragraph
nnoremap <leader>f mr{mtgq}mg:set nohlsearch<CR>:'t,'gs/  */ /g<CR>'r:let @/ =""<CR>:set hlsearch<CR>
"nnoremap <leader>f mr{gq}'r

" make
nnoremap <leader>m w:!make &>/dev/null&<CR> 
" open new file in vertical split
nnoremap <leader>n :vsp ./<CR>

" open new file in horizontal split
nnoremap <leader>s :sp ./<CR>

"--- WordCount function
function! WordCount()
   let s:old_status = v:statusmsg
   let position = getpos(".")
   exe ":silent normal g\<c-g>"
   let stat = v:statusmsg
   let s:word_count = 0
   if stat != '--No lines in buffer--'
     let s:word_count = str2nr(split(v:statusmsg)[11])
     let v:statusmsg = s:old_status
   end
   call setpos('.', position)
   return s:word_count 
endfunction
nnoremap <leader>c :set statusline=wc:%{WordCount()}<CR>

"--- snakemake 
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake
