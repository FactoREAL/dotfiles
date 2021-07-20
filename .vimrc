" need install in your system globally:
" - fzf
" - ripgrep
" - bat
" - Fira Mono Nerd Font  

set re=0 " new regular expression engine
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
set background=dark
set hidden
set updatetime=200
set ttimeoutlen=100 " remove delay on ctrl+[
set mmp=50000 " resolve memory troubles
set autoread
set signcolumn=yes
set clipboard+=unnamedplus
set redrawtime=10000
set shell=/bin/bash

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/gruvbox-material'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" в версии 0.0.80 {commit: 443b5e3} исчезает подчеркивание ошибок/ворнингов
" https://github.com/neoclide/coc.nvim/issues/3200
Plug 'neoclide/coc.nvim', {'branch': 'release', 'commit': '9d3c40bcb2304cda1697a0d898ce4d8b00e6e170'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-json', 'coc-css', 'coc-cssmodules', 'coc-highlight',
 \'coc-spell-checker', 'coc-cspell-dicts', 'coc-git', 'coc-pairs', 'coc-snippets', 'coc-yaml']
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'prettier/vim-prettier'
Plug 'voldikss/vim-floaterm'
call plug#end()

" -- Theme --
set t_Co=256
set termguicolors
highlight ColorColumn ctermbg=0 guibg=grey
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material


" -- Folding --
set foldenable
set foldmethod=syntax
set foldlevelstart=2
set foldtext=FoldText()
  set foldtext=FoldText()
  function! FoldText()
    let l:lpadding = &fdc
    redir => l:signs
      execute 'silent sign place buffer='.bufnr('%')
    redir End
    let l:lpadding += l:signs =~ 'id=' ? 2 : 0
    if exists("+relativenumber")
      if (&number)
        let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
      elseif (&relativenumber)
        let l:lpadding += max([&numberwidth, strlen(v:foldstart - line('w0')), strlen(line('w$') - v:foldstart), strlen(v:foldstart)]) + 1
      endif
    else
      if (&number)
        let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
      endif
    endif

    let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
    let l:end = substitute(substitute(getline(v:foldend), '\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')

    let l:info = ' (' . (v:foldend - v:foldstart) . ')'
    let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
    let l:width = winwidth(0) - l:lpadding - l:infolen

    let l:separator = ' … '
    let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
    let l:start = strpart(l:start , 0, l:width - strlen(substitute(l:end, '.', 'x', 'g')) - l:separatorlen)
    let l:text = l:start . ' … ' . l:end
    return l:text . repeat(' ', l:width - strlen(substitute(l:text, ".", "x", "g"))) . l:info
  endfunction

" -- Cursor styles --
let &t_SI="\<Esc>[5 q"
let &t_SR="\<Esc>[3 q"
let &t_EI="\<Esc>[0 q"

" fix strange symbols
let &t_TI = ""
let &t_TE = ""

" -- Common key mapping -- 
let mapleader = " "
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
autocmd CursorHold,CursorHoldI * silent checktime
autocmd BufEnter * :syntax sync fromstart " ,InsertLeave
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nmap <silent><C-h> :bp<CR>
nmap <silent><C-l> :bn<CR>
nmap <silent><C-q> :bd<CR>
nmap <C-_> <plug>NERDCommenterToggle<CR>
vmap <C-_> <plug>NERDCommenterToggle<CR>
" Use <c-space> to trigger completion or actions
if has('nvim')
  inoremap <silent><expr> <C-space> coc#refresh()
  nmap <C-space> :CocAction<CR>
else
  inoremap <silent><expr> <C-@> coc#refresh()
  nmap <C-@> :CocList --normal actions<CR>
endif

" -- Airline --
let g:airline_theme = 'gruvbox_material'"
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_skip_empty_sections = 1

" -- NERDTree --
nnoremap <expr> <leader>e g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : 
  \ bufexists(expand('%')) ? "\:NERDTreeFind <bar> :vertical resize 45<CR>" : 
  \ "\:NERDTree <bar> :vertical resize 45<CR>"
let NERDTreeDirArrowExpandable = ""
let NERDTreeDirArrowCollapsible = ""
let g:DevIconsEnableFoldersOpenClose = 1

let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1
let g:NERDTreeSyntaxEnabledExtensions = ['php', 'md', 'json', 'js', 'jsx', 'ts', 'tsx', 'css', 'scss', 'less', 'html']
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" -- Devicons --
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*\.d\.ts$'] = 'ﯤ'

" -- CoC --
nmap <silent><C-k> <Plug>(coc-diagnostic-prev)
nmap <silent><C-j> <Plug>(coc-diagnostic-next)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <cr> to confirm completion
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" -- FzF --
map <C-p> :Files<CR>
map <C-f> :RG<CR>
let $FZF_DEFAULT_COMMAND = 'rg --files --smart-case --hidden -g "!{.git,node_modules,vendor,tests}/*"'
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.95, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'bord': 'sharp' } }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" Ripgrep :Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ 'rg --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:158,158,158" --smart-case '
  \ .shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced :RG
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:158,158,158" --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" CTRL-A CTRL-Q to select all and build quickfix list
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list') }

" --cSpell --
nmap <leader>s :CocCommand cSpell.toggleEnableSpellChecker<cr>
let g:airline_detect_spell=1

" -- Git --
nmap <leader>gi <Plug>(coc-git-chunkinfo)
nmap <leader>gz :CocCommand git.chunkUndo<cr>
nmap <leader>gc <Plug>(coc-git-commit)
nmap <leader>gh :<C-u>CocList --normal bcommits<CR>
nmap <leader>gb :<C-u>CocList --normal branches<CR>
nmap <leader>gl :<C-u>CocList --normal commits --date=format:'%F_%R'<CR>
nmap <leader>gs :<C-u>CocList --normal gstatus<CR>
nmap <leader>ga :G blame --date=format:'%Y-%m-%d %H:%M'<CR>
nmap ) <Plug>(coc-git-prevchunk)
nmap ( <Plug>(coc-git-nextchunk)
nnoremap <leader>ch :diffget //2<CR>
nnoremap <leader>cl :diffget //3<CR>

" -- Prettier --
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync

" -- Floaterm --
let g:floaterm_position = 'bottom'
let g:floaterm_autoclose = 1
let g:floaterm_rootmarkers = ['.git', 'node-modules']
nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

" -- Closetag --
let g:closetag_filetypes = 'html,xhtml,phtml,jsx'
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
