" for linux-like systems, this is ~/.vimrc
" for windows systems, this is c:\Users\foo\_vimrc
"
" you can:
" * copy this file to those locations
" * link those locations to this file
" * insert a source statement, eg on windows I have:
"   c:\Users\foo\_vimrc contain source c:\Users\foo\repos\dotfiles\vimrc

syntax on
set nonumber


" search stuff
set ignorecase
set hlsearch

"------------------------------------------------------------------------------
" spacing and stuff
"------------------------------------------------------------------------------

" default to tabs, or `export USESPACES=1` in environment to use spaces

function! UseTabs()
	set noexpandtab
	set copyindent
	set preserveindent
	set softtabstop=0
	set shiftwidth=4
	set tabstop=4
endfunction

function! UseSpaces()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
endfunction

let usespaces=$USESPACES

if usespaces == '1'
call UseSpaces()
else
call UseTabs()
endif

set autoindent

"------------------------------------------------------------------------------
" misc
"------------------------------------------------------------------------------

set wrap
set backspace+=start,eol,indent
set noswapfile
set visualbell

" other progs
set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags

" appearance
set statusline=%f
set statusline+=\ 
set statusline+=[TYPE=%Y]
set statusline+=\   
set statusline+=[POS=%04l,%04v]	" current line, virtual col number
set statusline+=[%p%%]
set statusline+=\ 
set statusline+=[LEN=%L]		" total lines
set laststatus=2 
set fillchars+=vert:\ 
" TIP `set guifont=*` to bring up selector, then `set guifont` to see what you selected

"------------------------------------------------------------------------------
" OS specific stuff
"------------------------------------------------------------------------------

if has("win32")
	"--------
	" windows
	"--------
	:set guioptions-=m  "remove menu bar
	:set guioptions-=T  "remove toolbar
	":set guioptions-=r  "remove right-hand scroll bar
	":set guioptions-=L  "remove left-hand scroll bar
else
if has("unix")
	"-------------
	" linux or mac
	"-------------
	let s:uname = system("uname")
if s:uname == "Darwin\n"
	"--------
	" mac
	"--------
	set noantialias
	"set guifont=Lucida\ Console:h12
	"set guifont=Monaco:h12
	"set guifont=Inconsolata:h14
	set guifont=Terminus\ (TTF):h16
	" disable? bracketed paste mode
	set t_BE=
	" arrow keys to not insert 0A,0B,0C,0D
	set nocompatible
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
set background=light
if has("gui_running")
	" colorscheme solarized
	colorscheme desert
else
	" colorscheme solarized
	colorscheme desert
endif

" file types
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
au BufRead,BufNewFile *.spi set filetype=spice
au BufRead,BufNewFile *.cir set filetype=spice
au BufRead,BufNewFile *.gplt set filetype=gnuplot
au BufRead,BufNewFile *.ksy set filetype=yaml
au BufRead,BufNewFile *.json set foldmethod=syntax
au! Syntax spice source ~/.vim/syntax/spice.vim

" regions of highlighting
" default: /usr/share/vim/vim74/syntax/
" custom:  ~/.vim/syntax/*.vim
:syntax include @CPP syntax/cpp.vim
:syntax region cppSnip matchgroup=Snip start="@begin=cpp@" end="@end=cpp@" contains=@CPP
:syntax include @PY syntax/python.vim
:syntax region pySnip matchgroup=Snip start="@begin=py@" end="@end=py@" contains=@PY
:hi link Snip SpecialComment

" default folding
set nofoldenable

"------------------------------------------------------------------------------
" custom mappings
"------------------------------------------------------------------------------

" fast edit .vimrc
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>:echo "editing" $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>:echo "sourcing" $MYVIMRC<cr>

:nnoremap <leader>bnew "hithere=strftime("%s")<CR>PA

" move thru visual splits
:nnoremap <c-h> <c-w>h
:nnoremap <c-j> <c-w>j
:nnoremap <c-l> <c-w>l
:nnoremap <c-k> <c-w>k

" faster escape to normal
:inoremap jk <esc>

" hand slappers
:inoremap <esc> <nop>

" uppercase current word
:nnoremap <c-u> viwU

" quick editors
source ~/.vim/quickgnuplot.vim
autocmd BufRead quick.gplt call QuickGnuplotSetup()
source ~/.vim/quickpy.vim
autocmd BufRead /tmp/quick.py call QuickPySetup()
source ~/.vim/quickc.vim
autocmd BufRead /tmp/quick.c call QuickCSetup()
source ~/.vim/quickpng.vim
" autocmd BufRead /tmp/quick.png call QuickPngSetup()

" misc
let g:vim_json_syntax_conceal = 0

"
function! VimBroadcastEdit()
	if empty(glob("/tmp/vimwrote"))
		echo "no IPC file /tmp/vimwrote"
		return
	endif

	let l:fpath = expand('%:p')
	if empty(l:fpath)
		echo "no current file path"
		return
	endif

	" echo "broadcasting!"
	let l:cmd = "echo ".l:fpath." >> /tmp/vimwrote"
	" echo "executing: ".l:cmd
	call system(l:cmd)
endfunction

":inoremap <leader>r <esc>:call VimBroadcastEdit()<cr>
":map <leader>r :call VimBroadcastEdit()<cr>

" ALE linter settings
"let b:ale_warn_about_trailing_whitespace = 1

" leader-r to write and run current program
" nnoremap <leader>r :w<enter>:!%:p<enter>

nnoremap <leader>r :w<enter>:make<enter>

