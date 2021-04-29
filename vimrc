" Basic settings
syntax on
filetype indent plugin on

set hlsearch
set incsearch
set laststatus=2
set ignorecase
set smartcase
set smartindent
set shiftwidth=4
set nowrap
set number relativenumber
set ruler
set clipboard=unnamedplus
let mapleader="\<Space>"
set wildmode=longest,full
set wildmenu  " Enhance command-line completion 
set ttyfast  " Optimize for fast terminal connections 
set shortmess=atI  " Don’t show the intro message when starting Vim 
set noerrorbells  " Disable error bells 
set hidden  " To switch between unsaved buffers
set updatetime=300

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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'gruvbox' 
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': './install --bin'  }
Plug 'junegunn/fzf.vim'
" https://github.com/junegunn/fzf.vim/issues/714
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'ekalinin/Dockerfile.vim'
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars = 180
Plug 'cespare/vim-toml'
Plug 'liuchengxu/vim-which-key'
exe 'source' '~/.vim/which-key.vimrc'
Plug 'junegunn/goyo.vim'
let g:goyo_width = 120
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'voldikss/vim-floaterm'
let g:floaterm_position = 'bottomright'
let g:floaterm_height = 35
Plug 'mhinz/vim-startify'
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc' ]
Plug 'michaeljsmith/vim-indent-object'
Plug 'bkad/CamelCaseMotion'
map <silent> <leader>w <Plug>CamelCaseMotion_w
Plug 'bfredl/nvim-ipy'
Plug 'rakr/vim-one'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
let g:go_def_mapping_enabled = 0
Plug 'glench/vim-jinja2-syntax'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

" Extension point
if filereadable(expand('~/.vim/extra.vimrc'))
    exe 'source' '~/.vim/extra.vimrc'
endif

call plug#end()

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary gui=underline ctermfg=yellow cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary gui=underline ctermfg=lightyellow cterm=underline
augroup END
colo gruvbox
set background=dark
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" Mappings
imap jk <Esc>
nnoremap <C-p> <C-i>
nnoremap <CR> :noh<CR>:<Backspace><CR>  " This unsets the "last search pattern" register by hitting return
" nnoremap <Leader>x :bd<CR>  " Close buffer
nnoremap <Leader><Leader>f :Rg<CR>
" nnoremap <Leader>p :Files<CR>
nnoremap <expr> <Leader>o fugitive#head() != '' ? ':GFiles<CR>' : ':Files<CR>'
" nnoremap <Leader>b :Buffers<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>
map <Leader>h :wincmd h<CR>

" Auto source vimrc on save
autocmd! bufwritepost ~/.vimrc source $MYVIMRC
