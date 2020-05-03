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
set smartindent
set nowrap
set number relativenumber
set ruler
set clipboard=unnamedplus
let mapleader="\<Space>"
set wildmenu  " Enhance command-line completion 
set ttyfast  " Optimize for fast terminal connections 
set shortmess=atI  " Don’t show the intro message when starting Vim 
set noerrorbells  " Disable error bells 
nnoremap <CR> :noh<CR><CR>  " This unsets the "last search pattern" register by hitting return
nnoremap <C-n> :bn<CR>  " C-n for go to next buffer 

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Plugins [https://github.com/junegunn/vim-plug]
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
let g:gruvbox_bold = 0
Plug 'vim-python/python-syntax', { 'for': 'python' }
let g:python_highlight_all = 1
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'gruvbox' 
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': './install --bin'  }
Plug 'junegunn/fzf.vim'
Plug 'davidhalter/jedi-vim'
autocmd FileType python setlocal completeopt-=preview " Disable doc preview on jedi autocomplete
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'ervandew/supertab'
Plug 'ekalinin/Dockerfile.vim'
call plug#end()

colo gruvbox

nnoremap <Leader>f :Ag<CR>
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>b :Buffers<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>
map <Leader>h :wincmd h<CR>
map <Leader>x :bd<CR>
