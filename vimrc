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

let mapleader="\<Space>"

" Enhance command-line completion
set wildmenu
" Optimize for fast terminal connections
set ttyfast
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>
"<C-n> for go to next buffer
nnoremap <C-n> :bn<CR>

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

command! RefreshConfig source $MYVIMRC <bar> redraw | echohl StatusLineTerm | echom "vimrc reloaded" | echohl None

colo default

" Plugins [https://github.com/junegunn/vim-plug]
call plug#begin('~/.vim/plugged')

Plug 'vim-python/python-syntax', { 'for': 'python' }
let g:python_highlight_all = 1
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'sol' 
Plug 'jiangmiao/auto-pairs'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'junegunn/fzf', { 'do': './install --bin'  }
Plug 'junegunn/fzf.vim'

call plug#end()

