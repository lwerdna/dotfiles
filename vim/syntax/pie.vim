" syntax/pie.vim
" https://learnvimscriptthehardway.stevelosh.com/chapters/45.html

" echom "pie syntax loaded"

" define chunk of syntax
syntax keyword pieKeywords
	\ define
	\ lambda
	\ Pi
	\ claim
	\ the

" relies on iskeyword including dash
" put :setlocal iskeyword+=- in ftplugin/pie.vim
syntax keyword pieBuiltinFunctions
	\ cons
	\ car
	\ cdr
	\ add1
	\ head
	\ tail
	\ which-Nat
	\ iter-Nat
	\ rec-Nat
	\ rec-List
	\ ind-Nat

syntax keyword pieChars
	\ (
	\ )

syntax keyword pieTypes ->
syntax keyword pieTypes Nat
syntax keyword pieTypes List
syntax keyword pieTypes Pair
syntax keyword pieTypes Atom
syntax keyword pieTypes Vec

syntax match pieNaturals display contained "\v\d*"
syntax match pieComments "\v;.*$"
syntax match pieComments "\v#|.\{-}|#"

syntax match pieAtoms "'\w\+"

" link chunks to highlight group
" see :help group-name for all possible groups
highlight link pieComments Comment
highlight link pieKeywords Keyword
highlight link pieBuiltinFunctions Function
highlight link pieChars Delimiter
highlight link pieNaturals Number
highlight link pieTypes Type
highlight link pieAtoms String
