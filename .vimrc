" .vimrc by Vaduz

" env
set nocompatible
set fileformat=unix

" locale
set encoding=utf-8
set termencoding=utf-8
set fileencoding=japan
set fileencodings=utf8,euc-jp,iso-2022,cp932

" search
set ignorecase
set smartcase
set wrapscan
set hlsearch
set path^=**

" display
set number
set nolist
set ruler
set showmode
set cmdheight=1
set showtabline=1
set background=dark
set novisualbell
set spellsuggest=10
colorscheme default

" plugin
filetype plugin on

" syntax
syntax on
set autoindent
set smartindent
set formatoptions-=r

" backup
set nobackup
set nowritebackup
set noautowrite

" completion
set wildmenu
set wildmode=list:longest
set history=100

" folding
" set foldmethod=syntax

" tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=2

" bind paste mode toggle
set pastetoggle=<F3>

" Syntax of these languages are fussy over tabs vs spaces
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Customisations based on house-style (arbitrary)
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

" Treat .rss files as XML
autocmd FileType BufNewFile,BufRead *.rss set filetype=xml
autocmd FileType BufNewFile,BufRead *.plb set filetype=sql
autocmd BufRead,BufNewFile *.thrift set filetype=thrift
autocmd Syntax thrift source ~/.vim/plugin/thrift.vim

nnoremap ,n :set number!<CR>
nnoremap ,ai :set autoindent!<CR>
nnoremap ,si :set smartindent!<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <F4> :set wrap!<CR>
nnoremap <F8> :NERDTreeToggle<CR>
nnoremap <F12> :quit<CR>
nnoremap <C-k> :tabedit 
nnoremap <Up> gk
nnoremap <Down> gj
