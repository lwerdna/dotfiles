#!/bin/bash

PATH_WIKI=${HOME}/fdumps/wiki
PATH_WIKI_ASSETS=${PATH_WIKI}/assets

wiki() {
	local cmd
	local fpath

	# assume argument is a command
	cmd=$1
	# empty? open home page
	if [ "$cmd" == "" ]; then
		TMP=`pwd`
		cd $PATH_WIKI
		typora Home.md
		cd $TMP
		return 0
	# change to wiki directory
	elif [ "$cmd" == "cd" ]; then
		cd $PATH_WIKI
		return 0
	# push wiki directory
	elif [ "$cmd" == "pushd" ]; then
		pushd $PATH_WIKI
		return 0
	# attach file
	elif [ "$cmd" == "attach" ]; then
		cp $2 $PATH_WIKI_ASSETS
		return 0
	# open assets folder
	elif [ "$cmd" == "files" ]; then
		open $PATH_WIKI_ASSETS
		return 0
	fi

	# non-existent filenames become new markdown files
	fpath=$PATH_WIKI/$1
	if ! [[ -f "$fpath" ]]; then
		if [[ ! $fpath = *.md ]]; then
			fpath="$fpath.md"
		fi
	fi

	# file exists
	if [ -f "$fpath" ]; then
		echo "opening $fpath"
		if [[ $fpath = *.md ]]; then
			typora $fpath
		else
			gvim $fpath
		fi
	# file doesnt exist, create!
	else
		echo "creating $fpath"
		touch $fpath
		echo $1 >> $fpath
		echo '' >> $fpath
		echo '<div style="position:absolute; background:lightgrey; width:100%">Posted' `gdate --iso-8601`'</div>' >> $fpath
		echo '' >> $fpath
		typora $fpath
	fi
}

# same as wiki, but appends a "posted at..." message with current date
wikilog() {
	local fpath

	# assume argument is a wiki file
	# add .md if not present
	fpath=$PATH_WIKI/$1
	if [[ ! $fpath = *.md ]]; then
		fpath="$fpath.md"
	fi

	if [ -f "$fpath" ]; then
		echo "opening $fpath"
	else
		echo "creating $fpath"
		touch $fpath
	fi

	echo '' >> $fpath
	echo '<div style="position:absolute; background:lightgrey; width:100%">Posted' `gdate --iso-8601`'</div>' >> $fpath
	echo '' >> $fpath

	typora $fpath
}

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
_GetWikiFiles()
{
	local cur # pointer to current completion word

	COMPREPLY=() # array of possible completions
	cur=${COMP_WORDS[COMP_CWORD]} # get current word being completed

	pushd $PATH_WIKI > /dev/null
	COMPREPLY=($(\ls -1 $cur* 2>/dev/null)) # \ls avoids alias, 2>/dev/null supresses "No such file.." msg
	popd > /dev/null

	return 0
}

# https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html
# -F says call function
# -o says that compsec generates fienames (used with -F)
complete -F _GetWikiFiles -o filenames wiki
complete -F _GetWikiFiles -o filenames wikilog


