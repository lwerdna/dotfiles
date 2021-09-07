" syntax/pie.vim
" https://learnvimscriptthehardway.stevelosh.com/chapters/45.html

" echom "pie syntax loaded"

" define chunk of syntax
syntax keyword pieKeywords
	\ define
	\ lambda
	\ pie
	\ claim

" relies on iskeyword including dash
" put :setlocal iskeyword+=- in ftplugin/pie.vim
syntax keyword pieFunctions
	\ cons
	\ car
	\ cdr
	\ add1
	\ which-Nat
	\ iter-Nat
	\ rec-Nat

syntax keyword pieChars
	\ (
	\ )

syntax keyword pieTypes ->
syntax keyword pieTypes Nat
syntax keyword pieTypes List
syntax keyword pieTypes Pair

syntax match pieNaturals display contained "\v\d*"
syntax match pieComments "\v;.*$"
syntax match pieComments "\v#|.\{-}|#"

syntax match pieAtoms "'\w\+"

" link chunks to highlight group
" see :help group-name for all possible groups
highlight link pieComments Comment
highlight link pieKeywords Keyword
highlight link pieFunctions Function
highlight link pieChars Delimiter
highlight link pieNaturals Number
highlight link pieTypes Type
highlight link pieAtoms String
