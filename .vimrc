""""""""""""""""""""""""""""""""
" Bálint Gonda's .vimrc config "
""""""""""""""""""""""""""""""""

""" Set Encoding
""""""""""""""""
set encoding=utf-8
set fileencoding=utf-8

""" GVIM Settings
"""""""""""""""""
set backspace=indent,eol,start
set guioptions=-m   " Hide menu bar

""" Plug Config
"""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

""" Vim-Polyglot Plugin Config
""""""""""""""""""""""""""""""
let g:polyglot_disabled = ['markdown']

call plug#begin('../vimfiles/plugged')

Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'sbdchd/neoformat'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'joereynolds/vim-minisnip'

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

""" REMAPPING <ESC> to jk
"""""""""""""""""""""""""

" Press jk to return to normal mode when in insert mode
inoremap jk <ESC>
inoremap <ESC> <NOP>

" Press jk to return to normal mode when in visual mode
vnoremap jk <ESC>
vnoremap <ESC> <NOP>

" Press jk when in command mode, to go back to normal mode
cnoremap jk <ESC>

""" Auto Closing the Vanilla Way
""""""""""""""""""""""""""""""""
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

""" VIM Basic Config
""""""""""""""""""""

" Show linenumbers
set number
set ruler

" Set clipboard to system default
set clipboard=unnamed

" No error bell
set noerrorbells
set belloff=all

" Set Proper Tabs
set tabstop=4

" Theme and styling
set laststatus=2

" Remapping <leader> to space
let mapleader="\<Space>"

" Colorscheme
colorscheme onedark

" Enabling syntax
syntax on

" Reload files changed outside vim
set autoread

" No swap files generated
set noswapfile

" Incremental results on search
set incsearch

" Better indent
set expandtab
set smartindent

" Highlight Current line number
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

" Other...
set nowrap
set scrolloff=8
set background=dark

set colorcolumn=80
set signcolumn=yes
highlight ColorColumn ctermbg=red guibg=red

""" Window Navigation with arrow keys
"""""""""""""""""""""""""""""""""""""
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>

""" NERDTree Plugin Config
""""""""""""""""""""""""""
autocmd VimEnter * NERDTree | wincmd p
nnoremap <leader>é :NERDTreeFocus<CR>
nnoremap <C-é> :NerdTree<CR>
nnoremap <leader>f :NERDTreeFind<CR>

""" Markdown Config
""""""""""""""""""""""

" Use gruvbox when editing .md files
autocmd BufEnter,BufNewFile *.md colorscheme gruvbox
autocmd BufEnter,BufNewFile *.md let g:lightline.colorscheme="powerline"
autocmd BufEnter,BufNewFile *.md highlight ColorColumn ctermbg=NONE guibg=NONE
autocmd BufEnter,BufNewFile *.md set wrap
autocmd BufEnter,BufNewFile *.md set linebreak
autocmd BufLeave *md colorscheme onedark
autocmd BufLeave *md let g:lightline.colorscheme="powerline"

" Enable spell check
" autocmd BufEnter,BufNewFile *.md set spell

""" LIGHTLINE Plugin Config
"""""""""""""""""""""""""""
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': []
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

""" Git Gutter Plugin Config
""""""""""""""""""""""""""""
let g:gitgutter_enabled=1
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
autocmd BufWritePost * GitGutter    " Update diff on every save

""" Easymotion Plugin Config
""""""""""""""""""""""""""""
map <leader><leader>w <Plug>(easymotion-bd-w)

""" Prettier (Neoformat) Plugin Config
""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre *.js Neoformat prettier     " Format on save

""" Lightline-Bufferline Plugin Config
""""""""""""""""""""""""""""""""""""""
set showtabline=2
let g:lightline#bufferline#show_number=2
let g:lightline#bufferline#min_buffer_count=2
let g:lightline#bufferline#unnamed='[No Name]'

""" Buffer Navigation
"""""""""""""""""""""
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

nmap <Leader><Leader>1 <Plug>lightline#bufferline#delete(1)
nmap <Leader><Leader>2 <Plug>lightline#bufferline#delete(2)
nmap <Leader><Leader>3 <Plug>lightline#bufferline#delete(3)
nmap <Leader><Leader>4 <Plug>lightline#bufferline#delete(4)
nmap <Leader><Leader>5 <Plug>lightline#bufferline#delete(5)
nmap <Leader><Leader>6 <Plug>lightline#bufferline#delete(6)
nmap <Leader><Leader>7 <Plug>lightline#bufferline#delete(7)
nmap <Leader><Leader>8 <Plug>lightline#bufferline#delete(8)
nmap <Leader><Leader>9 <Plug>lightline#bufferline#delete(9)
nmap <Leader><Leader>0 <Plug>lightline#bufferline#delete(10)

