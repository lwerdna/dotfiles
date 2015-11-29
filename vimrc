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
set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags

" appearance
set statusline=[TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 
set noantialias
" TIP `set guifont=*` to bring up selector, then `set guifont` to see what you selected

if has("win32")
"--------
" windows
"--------
else
if has("unix")
" linux or mac
let s:uname = system("uname")
if s:uname == "Darwin\n"
"--------
" mac
"--------
set guifont=Lucida\ Console:h14
else
"--------
" linux
"--------
set guifont=DejaVu\ Sans\ Mono\ 12
" note: comma automatically added
set tags+=/usr/src/linux-headers-3.16.0-30-generic/tags
endif
endif
endif

" TIP `:colorscheme <tab>` to cycle thru defaults`
colorscheme desert

" file types
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" default folding
set nofoldenable
