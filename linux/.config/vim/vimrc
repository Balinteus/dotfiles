" Bálint Gonda's vim configuration

""" Encoding settings
set encoding=utf-8
set fileencoding=utf-8

""" GVIM and OS specific settings
set backspace=indent,eol,start

if has("win32")
  " Maximize on start
  au GUIEnter * simalt ~x
  " Hide menu bar
  set guioptions=-m

  let g:minisnip_dir = expand('$VIM/vimfiles/minisnip')
  let plugged_dir = '$VIM/vimfiles/plugged'
else
  let g:minisnip_dir = '~/.vim/minisnip'
  let plugged_dir = '~/.vim/plugged'
endif

""" Plugins
set nocompatible
filetype off

let g:polyglot_disabled = ['markdown']

call plug#begin(plugged_dir)

Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sheerun/vim-polyglot'
Plug 'joereynolds/vim-minisnip'

call plug#end()
filetype plugin indent on

""" The most important remaps
let mapleader="\<Space>"
inoremap jk <ESC>
cnoremap jk <ESC>

""" General vim settings
set number
set ruler
set clipboard=unnamedplus
set noerrorbells
set belloff=all
set tabstop=4
set laststatus=2
set autoread
set noswapfile
set incsearch
set expandtab
set smartindent
set nowrap
set scrolloff=8
set signcolumn=yes
set shortmess-=S

""" Theme settings
colorscheme onedark
syntax on
set background=dark

" Highlight the 80th column
set colorcolumn=80
highlight ColorColumn ctermbg=red guibg=red

" Highlight current line number
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

""" Auto closing the vanilla way
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ` ``<left>
inoremap < <><left>

""" Window navigation remaps
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>

""" NERDTree config
autocmd VimEnter * NERDTree | wincmd p
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
nnoremap <leader>é :NERDTreeFocus<CR>
nnoremap <leader><leader>é :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
let g:netrw_banner=0

""" Markdown config (for note-taking)
autocmd BufEnter,BufNewFile *.md colorscheme gruvbox
autocmd BufEnter,BufNewFile *.md let g:lightline.colorscheme="powerline"
autocmd BufEnter,BufNewFile *.md highlight ColorColumn ctermbg=NONE guibg=NONE
autocmd BufEnter,BufNewFile *.md set wrap
autocmd BufEnter,BufNewFile *.md set linebreak
autocmd BufLeave *md colorscheme onedark
autocmd BufLeave *md let g:lightline.colorscheme="powerline"
" Enable spell check
"autocmd BufEnter,BufNewFile *.md set spell

""" Lightline config
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

""" Git Gutter config
let g:gitgutter_enabled=1
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
" Update diff on every save
autocmd BufWritePost * GitGutter

""" EasyMotion config
map <leader><leader>w <Plug>(easymotion-bd-w)

""" Lightline-Bufferline config
set showtabline=2
let g:lightline#bufferline#show_number=2
let g:lightline#bufferline#min_buffer_count=2
let g:lightline#bufferline#unnamed='[No Name]'

""" Buffer navigation
for i in range(1, 9)
  " Buffer switching
  execute 'nmap <Leader>'.i.' <Plug>lightline#bufferline#go('.i.')'
  " Buffer closing
  execute 'nmap <Leader><Leader>'.i.' <Plug>lightline#bufferline#delete('.i.')'
endfor
