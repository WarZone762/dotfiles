source $VIM/_vimrc

set number
set relativenumber

call plug#begin('~/vimfiles/vim-plug')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'

PlugInstall --sync | q
call plug#end()
