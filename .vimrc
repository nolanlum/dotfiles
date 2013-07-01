version 6.0
if &cp | set nocp | endif
set backspace=indent,eol,start
set backupcopy=auto,breakhardlink
set fileencodings=utf-8,ucs-bom,default,latin1
set history=50
set modeline

set expandtab
set shiftwidth=4
set softtabstop=4

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
execute pathogen#infect()

syntax on
filetype indent plugin on
" vim: set ft=vim :
