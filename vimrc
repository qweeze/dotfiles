syntax on

filetype indent plugin on

imap jk <Esc>

set modeline
set background=dark

set hlsearch
set incsearch

set laststatus=2

set ignorecase
set smartcase

set number relativenumber
set ruler

set clipboard=unnamedplus

" Enhance command-line completion
set wildmenu
" Optimize for fast terminal connections
set ttyfast
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t show the intro message when starting Vim
set shortmess=atI
" Disable error bells
set noerrorbells

colo default

" Plugins [https://github.com/junegunn/vim-plug]
call plug#begin('~/.vim/plugged')

Plug 'vim-python/python-syntax', { 'for': 'python' }
let g:python_highlight_all = 1

" Plug 'preservim/nerdtree'
"
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'sol' 

Plug 'jiangmiao/auto-pairs'

Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()

