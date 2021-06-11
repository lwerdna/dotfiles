" Vim syntax file
" Language:	Poke
" Maintainer:	Ayose Cazorla <ayosec@gmail.com>
" Last Change:	2021 May 11

if exists("b:current_syntax")
  finish
endif

" Reserved words {{{1

syn keyword pokeKeyword as big break catch continue else for
syn keyword pokeKeyword if in isa lambda little pinned raise
syn keyword pokeKeyword return struct try type union unit
syn keyword pokeKeyword until var where while

syn keyword pokeType Comparator Exception POSIX_Time32 POSIX_Time64
syn keyword pokeType bit byte char int int16 int32 int64 int8
syn keyword pokeType long nibble off64 offset short string
syn keyword pokeType uint uint16 uint32 uint64 uint8 ulong
syn keyword pokeType uoff64 ushort void

syn keyword pokeValue OFFSET SELF __FILE__ __LINE__

" Functions {{{1

syn keyword pokeKeyword fun method nextgroup=pokeFuncName skipwhite skipempty
syn match pokeFuncName display contained "\<\w\+\>"

syn keyword pokeBuiltin assert atoi catos close crc32 exit
syn keyword pokeBuiltin flush get_endian getenv get_ios get_time
syn keyword pokeBuiltin ioflags iosize keyword load ltrim open
syn keyword pokeBuiltin pokeIntrinsic print printf ptime qsort rand
syn keyword pokeBuiltin rtrim set_endian set_ios sizeof stoca strace
syn keyword pokeBuiltin strchr syn term_begin_class term_begin_hyperlink
syn keyword pokeBuiltin term_end_class term_end_hyperlink term_get_bgcolor
syn keyword pokeBuiltin term_get_color term_set_bgcolor term_set_color unmap

syn match pokeFuncName display /'\w\{2,}/


" Units {{{1

syn keyword pokeUnit b M B Kb KB Mb MB Gb GB Kib KiB Mib MiB Gib GiB

" Comments {{{1

syn region pokeComment start="\V/*" end="\V*/"
syn region pokeComment start="#!" end="!#"
syn region pokeComment start="//" end="$"

" Values {{{1

syn match pokeEscape display contained /\\\([nrt\\'"]\|\%(x\x\{2}\)\|\%(\o\{1,3}\)\)/

syn region pokeString start='"' end='"' contains=pokeEscape

syn match pokeCharacter /'\([^\\]\|\\\(.\|\%(x\x\{2}\)\|\%(\o\{1,3}\)\)\)'/ contains=pokeEscape

syn match pokeNumber display "\<[0-9][0-9_]*" nextgroup=pokeNumberType
syn match pokeNumber display "\<0x[a-fA-F0-9_]\+" nextgroup=pokeNumberType
syn match pokeNumber display "\<0o[0-7_]\+" nextgroup=pokeNumberType
syn match pokeNumber display "\<0b[01_]\+" nextgroup=pokeNumberType

syn match pokeNumberType contained /\<u\|U\|l\|L\|h\|H\|B\|n\|N\>/

" Constants

syn match pokeType "\<[A-Z]\w*\>"

syn match pokeConstant "\<[A-Z][A-Z0-9_]\+\>"

" Default highlighting {{{1

hi def link pokeCharacter   String
hi def link pokeComment     Comment
hi def link pokeConstant    Constant
hi def link pokeEscape      Special
hi def link pokeFuncName    Function
hi def link pokeBuiltin     Function
hi def link pokeKeyword     Keyword
hi def link pokeNumber      Number
hi def link pokeNumberType  Type
hi def link pokeString      String
hi def link pokeType        Type
hi def link pokeUnit        Tag
hi def link pokeValue       Constant

