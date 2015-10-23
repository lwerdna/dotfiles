syntax on

" vundle plugin manager, plugins
" to install, add plugin here, then :PluginInstall from vim 
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
"call vundle#end()
"filetype plugin indent on

" search stuff
set ignorecase
set hlsearch

" spacing and stuff
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set expandtab

" misc
set nowrap
set backspace+=start,eol,indent
set noswapfile

" other progs
set tags=./tags;./../tags;./../../tags;./../../../tags;./../../../../tags;./../../../../../tags

" appearance
set statusline=[TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 
set noantialias
set guifont="DejaVu Sans Mono 10"

" file types
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" default folding
set nofoldenable
