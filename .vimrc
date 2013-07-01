set nocompatible

" try to load pathogen, fail silently
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
silent! execute pathogen#infect()

" allow backspacing over anything in insert mode
set backspace=indent,eol,start

" read/write a .viminfo file -- limit to only 50
set viminfo='20,\"50

" backup stuff and command history
set backupcopy=auto,breakhardlink
set writebackup
set history=50

" hide abandoned buffers
set hidden

" Don't update the display while executing macros
set lazyredraw

" filetype stuff
filetype on
filetype plugin on
filetype indent on
set fileencodings=utf-8,ucs-bom,default,latin1

" enable modeline parsing
set modeline

set visualbell

" for terminals with dark backgrounds
set background=dark

" show line numbers - make use of the extra screen real-estate with
" textwidth set to 72.  Up to 4 digits are okay for line numbers
set number
set numberwidth=4

syntax enable

" Show trailing space characters
set list listchars=trail:·

" -----------------------------------------------------------------------------
"
" Formatting
"  
"  -----------------------------------------------------------------------------

" always enable autoindenting
set autoindent

" tabs in file are 4 space characters
set tabstop=4

" each indent is 4 spaces
set shiftwidth=4

set expandtab
set smarttab

" round indent to multiple of shiftwidth
set shiftround

" -----------------------------------------------------------------------------
"
" Searching
"
" -----------------------------------------------------------------------------
" incremental search
set incsearch

" ignore case when searching
set ignorecase

" highlight the search
set hlsearch

" show matching bracket
set showmatch

" -----------------------------------------------------------------------------
"
" Mappings
"
" -----------------------------------------------------------------------------
" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

let mapleader = ","

" -----------------------------------------------------------------------------
"
" Plugin-specific settings
"
" -----------------------------------------------------------------------------

let g:nerdtree_tabs_open_on_console_startup = 1

" vim: set ft=vim
