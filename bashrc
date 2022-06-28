echo "my bashrc executing..."

# case insensitive glob, ls
shopt -s nocaseglob

export PATH=
export PATH=$PATH:/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/repos/lwerdna/workbench

# misc
export DOTFILES=${HOME}/repos/lwerdna/dotfiles
export GHIDRAHOME=${HOME}/Downloads/ghidra_9.0.4
export HOMEBREW_NO_AUTO_UPDATE=1

# ALIB various points
export PATH_AUTILS=${HOME}/repos/lwerdna/autils
export PATH_AUTILS_C=${PATH_AUTILS}/c
export PATH_AUTILS_PY=${PATH_AUTILS}/py
export PATH_AUTILS_PY3=${PATH_AUTILS}/py3

# local private (non github) stuff
source ~/.bashrc_private

###############################################################################
# binaryninja
###############################################################################

export BN_SOURCE=$HOME/repos/vector35/binaryninja
export BN_BNTLS=$BN_SOURCE/typelib

# relies on BN_INSTALL_DIR being set
function bn_common {
	export PYTHONPATH=${PYTHONPATH}:${BN_INSTALL_DIR}/Contents/Resources/python

	# for, eg: Makefiles to specify an include path into API
	export BN_API_PATH=$BN_SOURCE/api

	# for, eg: Makefiles that compile plugins specify an install target
	export BN_PLUGINS="$HOME/Library/Application Support/Binary Ninja/plugins"

	# for, eg: Makefiles for plugins to link against the API lib
	export BN_LIBBINARYNINJACORE=$BN_INSTALL_DIR/Contents/MacOS/libbinaryninjacore.dylib

	alias binja="$BN_INSTALL_DIR/Contents/MacOS/binaryninja"
	alias binja_lldb="lldb $BN_INSTALL_DIR/Contents/MacOS/binaryninja"
}

function bn_select_debug {
	echo Binary Ninja: selecting the source compiled [DEBUG]
	export BN_BUILT_DIR=$BN_SOURCE/build_debug
	export BN_INSTALL_DIR=$BN_BUILT_DIR/out/binaryninja.app
	bn_common
	export BN_LIBBINARYNINJAAPI=$BN_BUILT_DIR/api/out/libbinaryninjaapi.a
}

function bn_select_release {
	echo Binary Ninja: selecting the source compiled [RELEASE]
	export BN_BUILT_DIR=$BN_SOURCE/build_release
	export BN_INSTALL_DIR=$BN_BUILT_DIR/out/binaryninja.app
	bn_common
	export BN_LIBBINARYNINJAAPI=$BN_BUILT_DIR/api/out/libbinaryninjaapi.a
}

function bn_select_installed_dev {
	echo Binary Ninja: selecting system-installed DEV
	export BN_INSTALL_DIR="/Applications/Binary Ninja DEV.app"
	bn_common
}

function bn_select_installed_23 {
	echo Binary Ninja: selecting system-installed 2.3
	export BN_INSTALL_DIR="/Applications/Binary Ninja 2.3 2660.app"
	bn_common
}

function bn_select_installed_stable {
	echo Binary Ninja: selecting system-installed STABLE
	export BN_INSTALL_DIR="/Applications/Binary Ninja STABLE.app"
	bn_common
}

function bn_select_build {
	echo Binary Ninja: selecting build environment
	unset PYTHONPATH
	bn_select_release
	export BN_DISABLE_USER_SETTINGS=1
	export BN_DISABLE_USER_PLUGINS=1
	export BN_DISABLE_REPOSITORY_PLUGINS=1
	export LIBCLANG_PATH=/Users/andrewl/libclang/14.0.0/lib
	comment.py $BN_SOURCE/api/rust/examples/basic_script/CMakeLists.txt '#'
}

function bn_unselect_build {
	echo Binary Ninja: unselecting build environment
	export PYTHONPATH
	bn_select_release
	unset BN_DISABLE_USER_SETTINGS
	unset BN_DISABLE_USER_PLUGINS
	unset BN_DISABLE_REPOSITORY_PLUGINS
	uncomment.py $BN_SOURCE/api/rust/examples/basic_script/CMakeLists.txt '#'
}

# release is the built debug one
bn_select_release

echo "Binary Ninja: bn_select_debug bn_select_release bn_select_installed_dev"

# shellcode compiler
#export SCC=${HOME}/repos/vector35/binaryninja/scc/scc
#export PATH=${PATH}:${HOME}/repos/vector35/binaryninja/scc/

###############################################################################
# python
###############################################################################

eval "$(pyenv init --path)"
pyenv shell 3.7.4 2.7.16

# some packages install executable scripts, like pyelftools puts readelf.py here
export PATH=$PATH:$HOME/.pyenv/versions/3.7.4/bin

function python_import_sidekick {
	export PYTHONPATH=${PYTHONPATH}:$HOME/repos/vector35/TypeLibraryBinaries/bnml/packages
}

function python_import_kaitai {
	export PYTHONPATH=${PYTHONPATH}:${HOME}/repos/lwerdna/kaitai_struct_formats/build
}

###############################################################################
# rust
###############################################################################

#export PATH=${PATH}:${HOME}/.cargo/bin
source $HOME/.cargo/env

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
	alias coqide='/Applications/CoqIDE_8.13.1.app/Contents/MacOS/coqide'
	alias vscode='open -a Visual\ Studio\ Code'
	alias arduino='open -a Arduino'
	# for midnight commander
	export VIEWER='open'

	# java
	export JAVA_HOME=${HOME}/Downloads/jdk-11.0.1.jdk/Contents/Home
	export CLASSPATH=".:/usr/local/lib/antlr-4.5.1-complete.jar:${HOME}/Downloads/gwt-2.8.0/gwt-user.jar"
	#export CLASSPATH=".:/usr/local/lib/antlr-4.5.1-complete.jar:$CLASSPATH"
	alias antlr4='java -jar /usr/local/lib/antlr-4.9.2-complete.jar'
	alias grun='java org.antlr.v4.gui.TestRig'

	# android
	export ANDROID_SDK=${HOME}/Library/Android/sdk
	export NDK_R10C=/usr/local/Cellar/android-ndk-r10c/r10c
	export NDK_R10E=${HOME}/android-ndk-r10e
	export NDK_R14B=${HOME}/android-ndk-r14b
	export NDK_R15C=${HOME}/android-ndk-r15c
	export NDK_R17C=${HOME}/android-ndk-r17c
	export NDK_R21D=${HOME}/android-ndk-r21d-built
	export NDK=$NDK_R21D

	# qt
	#export PATH=${PATH}:${HOME}/Qt/5.15.0/clang_64/bin
	#export PATH=${PATH}:${HOME}/Qt/6.0.2/clang_64/bin
	#export PATH=${PATH}:${HOME}/Qt/6.1.1/clang_64/bin

	export PATH=${PATH}:${HOME}/Qt/6.3.0/clang_64/bin

	# LLVM
	export PATH=$PATH:${HOME}/libclang/14.0.0/bin
	export LLVM_INSTALL_DIR=${HOME}/libclang
	export LIBCLANG_PATH=${HOME}/libclang/14.0.0

	# LLDB server
	export PATH=$PATH:/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources
	# SML NJ
	#export PATH=$PATH:/usr/local/smlnj/bin

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
#export PATH=${PATH}:${ANDROID_SDK}/tools
#export PATH=${PATH}:${ANDROID_SDK}/tools/bin
#export PATH=${PATH}:${ANDROID_SDK}/platform-tools-ADB39
#export PATH=${PATH}:${ANDROID_SDK}/build-tools/28.0.1

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
export PATH_KB=$HOME/fdumps/wiki

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

website() {
	local fpath=$HOME/fdumps/website/index.md
	gvim $fpath
}

yesterday() {
	local date=`date -v-1d +"%Y-%m-%d"`
	local fpath="$HOME/fdumps/journals/$date.md"
	open -a macvim $fpath
}

today() {
	local fpath=$HOME/fdumps/journals
	local date=`date +"%Y-%m-%d"`
	local source="$fpath/daily_template.md"
	local destination="$fpath/$date.md"
	if [ ! -f $destination ]; then
		echo "creating $destination";
		cp $source $destination;
	fi
	echo "opening $destination";
	open -a macvim $destination;
}

function create_dir_verbose()
{
	if [ ! -d $1 ]; then
		echo "creating $1";
		mkdir $1;
	fi
}

function cdlog()
{
	local date PARTS YEAR MONTH DAY

	# default to today, if date not given
	if [ ! "$1" == "" ]; then
		date=$1
	else
		date=`date +"%Y-%m-%d"`
	fi

	# sanitize input
	if [[ ! "$date" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
		echo "malformed date: $1"
		return -1
	fi

	# apparently $(...) gets the output of a command
	PARTS=$(echo $date | tr "-" " ")

	# (...) makes it into an array, splitting on internal field separator (IFS)
	# which defaults to space
	PARTS=($PARTS)

	# write
	YEAR=${PARTS[0]}
	MONTH=${PARTS[1]}
	DAY=${PARTS[2]}

	create_dir_verbose "$HOME/fdumps/heap/$YEAR"
	create_dir_verbose "$HOME/fdumps/heap/$YEAR/$MONTH"
	create_dir_verbose "$HOME/fdumps/heap/$YEAR/$MONTH/$DAY"

	pushd "$HOME/fdumps/heap/$YEAR/$MONTH/$DAY"
}

gopy() {
	local fname

	if [ "$1" == "" ]; then
		fname="./go.py"
	else
		fname=$1
	fi
	#echo "using fname $fname"

	if test -f "$fname"; then
		echo "already exists"
	else
		cp $HOME/fdumps/workspace/gopy-template.py $fname
		chmod +x $fname
	fi
	gvim + $fname
}

goc() {
	local fname

	if [ "$1" == "" ]; then
		fname="./go.c"
	else
		fname=$1
	fi
	#echo "using fname $fname"

	if test -f "$fname"; then
		echo "already exists"
	else
		echo -e "#include <stdio.h>\n" > $fname
		echo -e "int main(int argc, char **argv)" >> $fname
		echo -e "{" >> $fname
		echo -e "\tprintf(\"Hello, world!\");\n" >> $fname
		echo -e "}" >> $fname
	fi
	gvim +6 $fname
}

# quick editor stuff
alias todo='gvim $HOME/fdumps/workspace/todo'
alias write='touch /tmp/index.md; typora /tmp/index.md'
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

alias nes='gvim $HOME/repos/vector35/binaryninja/api/python/examples/nes.py'
alias arm64='pushd $HOME/repos/vector35/binaryninja/public/arch/arm64'

alias graph='dot -Tpng /tmp/tmp.dot -o /tmp/tmp.png && open /tmp/tmp.png'
alias graphsvg='dot -Tsvg /tmp/tmp.dot -o /tmp/tmp.svg && firefox /tmp/tmp.svg'

alias server='python -m http.server'

source ~/.bash_profile
. "$HOME/.cargo/env"
