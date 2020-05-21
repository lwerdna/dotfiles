echo "my bashrc executing..."
export PATH=
export PATH=$PATH:/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/bin

# misc
export DOTFILES=${HOME}/repos/lwerdna/dotfiles
export GHIDRAHOME=${HOME}/Downloads/ghidra_9.0.4

# ALIB various points
export PATH_AUTILS=${HOME}/repos/lwerdna/autils
export PATH_AUTILS_C=${PATH_AUTILS}/c
export PATH_AUTILS_PY=${PATH_AUTILS}/py
export PATH_AUTILS_PY3=${PATH_AUTILS}/py3

# binary ninja
export BINJA=$HOME/repos/vector35/binaryninja
export BINJA_APP_BUILT=$BINJA/ui/binaryninja.app
export BINJA_APP_INSTALLED=/Applications/Binary\ Ninja.app
export BINJA_APP=$BINJA_APP_INSTALLED

export BINJA_PY=$BINJA_APP/Contents/Resources/python
export BINJA_PY3=$BINJA_APP/Contents/Resources/python3
export BINJA_PLUGS=$HOME/Library/Application\ Support/Binary\ Ninja/plugins
export BINJA_PLUGINS=$HOME/Library/Application\ Support/Binary\ Ninja/plugins

# shellcode compiler
#export SCC=${HOME}/repos/vector35/binaryninja/scc/scc
#export PATH=${PATH}:${HOME}/repos/vector35/binaryninja/scc/

# local private (non github) stuff
source ~/.bashrc_private

###############################################################################
# python
###############################################################################

eval "$(pyenv init -)"

function python_import_binja3 {
	export PYTHONPATH=${PYTHONPATH}:${BINJA_PY}
	export PYTHONPATH=${PYTHONPATH}:${BINJA_PY3}
}

function python_import_kaitai {
	export PYTHONPATH=${PYTHONPATH}:${HOME}/repos/lwerdna/kaitai_struct_formats/build
}

export PYTHONPATH=
python_import_binja3

###############################################################################
# per-platform settings
###############################################################################

platform=`uname`
# defaults
export EDITOR='vim'

# platform-specifics
if [[ $platform == 'Darwin' ]]; then
	echo setting Darwin-specific stuff...

	# command-line utils
	alias ls='ls -G -t -r'
	#alias ls='ls -G'

	# apps
	alias macdown='open -a MacDown'
	alias firefox='open -a firefox'
	alias typora='open -a typora'
	alias diffmerge='open -a diffmerge'
	alias geany='open -a geany'
	alias drawbot='open -a drawbot'
	alias vlc='open -a vlc'

	# for midnight commander
	export VIEWER='open'

	# java
	export JAVA_HOME=${HOME}/Downloads/jdk-11.0.1.jdk/Contents/Home
	export CLASSPATH=".:/usr/local/lib/antlr-4.5.1-complete.jar:${HOME}/Downloads/gwt-2.8.0/gwt-user.jar"
	#export CLASSPATH=".:/usr/local/lib/antlr-4.5.1-complete.jar:$CLASSPATH"
	alias antlr4='java -jar /usr/local/lib/antlr-4.5.1-complete.jar'
	alias grun='java org.antlr.v4.gui.TestRig'

	# android
	export ANDROID_SDK=${HOME}/Library/Android/sdk
	export NDK_R10C=/usr/local/Cellar/android-ndk-r10c/r10c
	export NDK_R10E=${HOME}/android-ndk-r10e
	export NDK_R14B=${HOME}/android-ndk-r14b
	export NDK_R15C=${HOME}/android-ndk-r15c
	export NDK_R17C=${HOME}/android-ndk-r17c
	export NDK=$NDK_R15C

	# qt
	export PATH=${PATH}:${HOME}/Qt5.14.0/5.14.0/clang_64/bin

	# LLVM
	export PATH=$PATH:${HOME}/Downloads/llvm-8.0.0-x86_64-apple-darwin/bin
	export LLVM_INSTALL_DIR=${HOME}/Downloads/llvm-8.0.0-x86_64-apple-darwin

	# LLDB server
	export PATH=$PATH:/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources
	# SML NJ
	export PATH=$PATH:/usr/local/smlnj/bin

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
export PATH=${PATH}:${ANDROID_SDK}/platform-tools-ADB39
export PATH=${PATH}:${ANDROID_SDK}/build-tools/28.0.1

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
	local text=${@:2}
	if [ "$text" == "gvim" ]; then
		gvim $fpath
	elif [ "$text" == "vim" ]; then
		vim + $fpath
	elif [ "$text" == "typora" ]; then
		open -a typora $fpath	
	elif [ "$text" == "date" ]; then
		echo '' >> $fpath
		echo '# '`date +"%Y-%m-%d %T %A"` >> $fpath
	elif [ "$text" == "" ]; then
		less +G $fpath
	else
		#echo '' >> $fpath
		echo $text >> $fpath
	fi
}

notes() {
	local fpath=$HOME/fdumps/journals/notes.md
	jotter $fpath $@
}

lists() {
	local fpath=$HOME/fdumps/journals/lists.md
	if [ "$2" == "" ]; then
		jotter $fpath gvim
	else
		jotter $fpath $@
	fi
}

snipper() {
	local fpath=$1
	if [ "$2" == "gvim" ]; then
		gvim $fpath
	else
		less $fpath
	fi
}

snipc() {
	snipper $HOME/fdumps/workspace/snippets.c $1
}
snippy() {
	wiki PythonCookbook.md
}
snipbash() {
	snipper $HOME/fdumps/workspace/snippets.sh $1
}

snipmake() {
	local fpath=$HOME/fdumps/workspace/Make.md
	if [ "$1" == "vim" ]; then
		gvim -c "set filetype=make" $fpath
	else
		less $fpath
	fi
}

testpy() {
	if test -f "./test.py"; then
		echo "already exists"
	else
		echo -e "#!/usr/bin/env python\n" > ./test.py
		echo -e "print(\"Hello, world!\")\n" >> ./test.py
		chmod +x ./test.py
	fi
	gvim + test.py
}

testc() {
	if test -f "./test.c"; then
		echo "already exists"
	else
		echo -e "#include <stdio.h>\n" > ./test.c
		echo -e "int main(int argc, char **argv)" >> ./test.c
		echo -e "{" >> ./test.c
		echo -e "\tprintf(\"Hello, world!\");\n" >> ./test.c
		echo -e "}" >> ./test.c
	fi
	gvim +6 test.c
}

# quick editor stuff
alias todo='gvim $HOME/fdumps/workspace/todo'
alias quickc='gvim /tmp/quick.c'
alias write='touch /tmp/index.md; typora /tmp/index.md'
alias website='open $HOME/fdumps/website/index.html'
#alias binja='~/repos/vector35/binaryninja/ui/binaryninja.app/Contents/MacOS/binaryninja'
alias binja='/Applications/Binary\ Ninja.app/Contents/MacOS/binaryninja'
alias ghidra='$GHIDRAHOME/ghidraRun'
alias ghidrapi='open $GHIDRAHOME/docs/api/index.html'
alias ghidraapi='open $GHIDRAHOME/docs/api/index.html'
alias ghidradoc='open $GHIDRAHOME/docs/'

# Enable syntax-highlighting in less.
# brew install source-highlight
# First, add these two lines to ~/.bashrc
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
alias less='less -m -n -g -i -J --underline-special --SILENT'
alias more='less'

alias nes='gvim /Users/andrewl/repos/vector35/binaryninja/api/python/examples/nes.py'
