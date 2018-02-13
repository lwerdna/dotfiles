#!/bin/bash

# notes:
# https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion.html#Programmable-Completion
# https://spin.atomicobject.com/2016/02/14/bash-programmable-completion/
# since `complete` is a built-in, you'd do `help complete` instead of `man complete`
# compspec - completion specification, specified per command
# make new compspecs with `complete <options> <cmd>`
# list current compspecs: `complete -p`
#
# can specify a command/program with `-C` that, given COMP_LINE and COMP_POINT
#   environment variables, outputs a list of completion options
# can specify a bash function with `-F`

# INPUTS:
# command line argument:
#   $1 is the name of the command whose arguments are being completed
#   $2 is the word being completed
#   $3 is the word preceeding the word being completed
# environment variables:
#   COMP_WORDS is array
#   COMP_CWORD is current cursor position in COMP_WORDS
#   COMP_LINE is current line being completed
#   COMP_POINT is current point completion is taking place within COMP_LINE
#   COMP_XXX is others
# OUTPUTS:
#   set COMP_REPLY to the possible words
PATH_WIKI=${HOME}/workspace/wiki
PATH_WIKI_ATTACHMENTS=${HOME}/workspace/wiki/attachments

wiki() {
	if [ "$1" == "" ]; then
		typora $PATH_WIKI/Wiki.md
	elif [ "$1" == "cd" ]; then
		cd $PATH_WIKI
	elif [ "$1" == "files" ]; then
		open $PATH_WIKI_ATTACHMENTS
	else
		typora $PATH_WIKI/$1.md
	fi
}

_GetWikiFiles()
{
	local cur # pointer to current completion word

	COMPREPLY=() # array of possible completions
	cur=${COMP_WORDS[COMP_CWORD]} # get current word being completed

	pushd $PATH_WIKI > /dev/null
	COMPREPLY=($(\ls -1 $cur*.md 2>/dev/null)) # \ls avoids alias, 2>/dev/null supresses "No such file.." msg
	popd > /dev/null

	return 0
}

# https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
# -F says call function
# -o says that compsec generates fienames (used with -F)
complete -F _GetWikiFiles -o filenames wiki

