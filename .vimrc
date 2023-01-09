syntax on
color slate
set background=dark

set mouse=a
set autoindent
set number
set relativenumber
set nowrap
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab smarttab
set smartindent
set ignorecase
set smartcase
set encoding=UTF-8
set noswapfile
set nobackup
set nowritebackup
set colorcolumn=140
set incsearch
set nohlsearch
set hidden
set signcolumn=yes
set clipboard+=unnamedplus

" -- Theme --
set t_Co=256
set termguicolors
highlight ColorColumn ctermbg=236 guibg=grey

" -- Common key mapping -- 
let mapleader = " "
"autocmd CursorHold,CursorHoldI * silent checktime
"autocmd BufEnter * :syntax sync fromstart " ,InsertLeave
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nmap <silent><C-h> :bp<CR>
nmap <silent><C-l> :bn<CR>
nmap <silent><C-q> :bd<CR>
