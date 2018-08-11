echo "my bashrc executing..."

# misc
export DOTFILES=${HOME}/repos/lwerdna/dotfiles

# ALIB various points
export PATH_AUTILS=${HOME}/repos/lwerdna/autils
export PATH_AUTILS_C=${PATH_AUTILS}/c
export PATH_AUTILS_PY=${PATH_AUTILS}/py
export PATH_AUTILS_PY3=${PATH_AUTILS}/py3

# go stuff
export GOPATH=${HOME}/go
export PATH=${PATH}:${HOME}/go/bin

# shellcode compiler
export SCC=${HOME}/repos/v35/scc/scc

###############################################################################
# python
###############################################################################
function choose_python2 {
	export PYTHONPATH=/usr/local/lib/python2.7/site-packages
	export PYTHONPATH=${PYTHONPATH}:/Library/Python/2.7/site-packages
	export PYTHONPATH=${PYTHONPATH}:${HOME}/repos/vector35/binaryninja/ui/binaryninja.app/Contents/Resources/python/
	export PYTHONPATH=${PYTHONPATH}:${PATH_AUTILS_PY}
}

function choose_python3 {
	export PYTHONPATH=/usr/local/lib/python3.7/site-packages
	export PYTHONPATH=${PYTHONPATH}:/Library/Python/3.7/site-packages
	export PYTHONPATH=${PYTHONPATH}:${PATH_AUTILS_PY3}
}

###############################################################################
# per-platform settings
###############################################################################

platform=`uname`
# defaults
export EDITOR='vim'
choose_python2

# platform-specifics
if [[ $platform == 'Darwin' ]]; then
	echo setting Darwin-specific stuff...

	# command-line utils
	alias ls='ls -G -t -r'

	# apps
	alias macdown='open -a MacDown'
	alias typora='open -a typora'

	# for midnight commander
	export VIEWER='open'

	# java
	export CLASSPATH=".:/usr/local/lib/antlr-4.5.1-complete.jar:${HOME}/Downloads/gwt-2.8.0/gwt-user.jar"
	#export CLASSPATH=".:/usr/local/lib/antlr-4.5.1-complete.jar:$CLASSPATH"
	alias antlr4='java -jar /usr/local/lib/antlr-4.5.1-complete.jar'
	alias grun='java org.antlr.v4.gui.TestRig'

	# android
	export ANDROID_SDK=${HOME}/Library/Android/sdk
	export NDK_R10C=/usr/local/Cellar/android-ndk-r10c/r10c
	export NDK_R10E=${HOME}/android-ndk-r10e
	export NDK_R15C=${HOME}/android-ndk-r15c
	export NDK=$NDK_R15C
	alias gdbndk=$NDK/prebuilt/darwin-x86_64/bin/gdb

elif [[ $platform == 'FreeBSD' ]]; then
	echo setting FreeBSD-specific stuff...
elif [[ $platform == 'Linux' ]]; then
	echo setting linux-specific stuff...

	alias ls='ls --color=auto'

	# for midnight commander
	export VIEWER='exo-open'

	# android
	export ANDROID_SDK=${HOME}/android-sdk
	export NDK_R10C=${HOME}/android-ndk-r10c/r10c
	export NDK_R10E=${HOME}/android-ndk-r10e
	export NDK=$NDK_R10E
fi

# platform-generals that depended on the platform-specifics
export PATH=${PATH}:${ANDROID_SDK}/tools
export PATH=${PATH}:${ANDROID_SDK}/tools/bin
export PATH=${PATH}:${ANDROID_SDK}/platform-tools

# qt
export PATH=${PATH}:${HOME}/Qt5.6.0/5.6/clang_64/bin

###############################################################################
# cross compiler stuff
###############################################################################

# select cross compiler (setting CCOMPILER) - now you can use ${CCOMPILER}gcc, etc.
function ndk_arm_eabi {
	export NDK_SYSROOT=$NDK/platforms/android-23/arch-arm
	if [[ $platform == 'Darwin' ]]; then
		export NDK_TOOLCHAIN_PATH=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin
	elif [[ $platform == 'Linux' ]]; then
		export NDK_TOOLCHAIN_PATH=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
	fi
	export EABI_STRING=arm-linux-androideabi-
	export CCOMPILER=$NDK_TOOLCHAIN_PATH/$EABI_STRING
}

function ndk_aarch64_eabi {
	# select sysroot (where to find /usr/include, /usr/lib, etc.)
	export NDK_SYSROOT=$NDK/platforms/android-21/arch-arm64
	export NDK_TOOLCHAIN_PATH=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin
	export EABI_STRING=aarch64-linux-android-
	export CCOMPILER=$NDK_TOOLCHAIN_PATH/$EABI_STRING
}

function fft_eabi {
	export CCOMPILER=$HOME/arm-eabi-4.4.3/bin/arm-eabi-
}

function fs_eabi {
	export CCOMPILER=$HOME/arm-eabi-4.6/bin/arm-eabi-
}

function latest_eabi {
	export CCOMPILER=$HOME/arm-eabi-4.8/bin/arm-eabi-
	#export CCOMPILER=$HOME/gcc-arm-none-eabi-4_8-2014q3/bin/arm-none-eabi-
	#export CCOMPILER=$HOME/gcc-arm-none-eabi-6_2-2016q4/bin/arm-none-eabi-
	#export CCOMPILER=$HOME/gcc-arm-none-eabi-7-2017-q4-major/bin/arm-none-eabi-
}

function raspi_eabi {
	# how? git clone https://github.com/raspberrypi/tools
	export CCOMPILER=$HOME/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-
}

function powerpc_eabi {
	export CCOMPILER=$HOME/powerpc-eabi-4.3.3/bin/powerpc-eabi-
}

###############################################################################
# notes, snippets, wiki
###############################################################################
source ${DOTFILES}/wiki.sh

# first parameter ($1) is filename
# second parameter ($2) is command
jotter() {
	# $1 is positional parameter
	# $@ is array-like construct of all positional parameters
	# https://www.gnu.org/software/bash/manual/html_node/Shell-Variables.html
	local fpath=$1
	if [ "$2" == "gvim" ]; then
		gvim $fpath
	elif [ "$2" == "vim" ]; then
		vim + $fpath
	elif [ "$2" == "date" ]; then
		echo '' >> $fpath
		echo '# '`date +"%Y-%m-%d %T"` >> $fpath
	elif [ "$2" == "" ]; then
		less +G $fpath
	else
		echo '' >> $fpath
		echo $@ >> $fpath
	fi
}

notes() {
	local fpath=$HOME/fdumps/journals/notes.md
	jotter $fpath $1
}

lists() {
	local fpath=$HOME/fdumps/journals/lists.md
	if [ "$2" == "" ]; then
		jotter $fpath gvim
	else
		jotter $fpath $2
	fi
}

snipc() {
	local fpath=$HOME/fdumps/workspace/snippets.c
	if [ "$1" == "vim" ]; then
		gvim $fpath
	else
		less $fpath
	fi
}

snippy() {
	local fpath=$HOME/fdumps/workspace/snippets.py
	if [ "$1" == "vim" ]; then
		gvim $fpath
	else
		less $fpath
	fi
}

snipmake() {
	local fpath=$HOME/fdumps/workspace/Make.md
	if [ "$1" == "vim" ]; then
		gvim -c "set filetype=make" $fpath
	else
		less $fpath
	fi
}

snipbash() {
	local fpath=$HOME/fdumps/workspace/snippets.sh
	if [ "$1" == "vim" ]; then
		gvim $fpath
	else
		less $fpath
	fi
}

# quick editor stuff
alias todo='gvim $HOME/fdumps/workspace/todo'
alias quickc='gvim /tmp/quick.c'
alias quickpy='gvim /tmp/quick.py'
alias website='open $HOME/fdumps/website/index.html'

