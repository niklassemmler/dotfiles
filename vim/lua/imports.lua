call plug#begin('~/.config/nvim/plugged')

""" Completion
" snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" autocomplete
" Didn't get it to work
" Plug 'ycm-core/YouCompleteMe'
" python autocomplete
Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'
"""

""" Visuals
" colorscheme badwolf
Plug 'sjl/badwolf'
" solarized colors
Plug 'altercation/vim-colors-solarized'
" colorscheme material
Plug 'hzchirs/vim-material'
" vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Dev Icons
Plug 'ryanoasis/vim-devicons'
"""

""" Startpage
Plug 'mhinz/vim-startify'
"""

""" Syntax Highlighting
Plug 'jparise/vim-graphql'
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
" run tests from python
Plug 'vim-test/vim-test'
" syntax checking 
Plug 'vim-syntastic/syntastic'
" orienting with tags
Plug 'preservim/tagbar'
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

"Comments
Plug 'numToStr/Comment.nvim'

"Git diffs
Plug 'lewis6991/gitsigns.nvim'

"File navigation
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

call plug#end()
