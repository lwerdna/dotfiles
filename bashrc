echo "my bashrc executing..."

# ALIB various points
export PATH_ALIB=${HOME}/repos/lwerdna/alib
export PATH_ALIB_C=${PATH_ALIB}/c
export PATH_ALIB_PY=${PATH_ALIB}/py
export PATH_ALIB_PY3=${PATH_ALIB}/py3
# ALIB specific point
export PYTHONPATH=${PYTHONPATH}:${PATH_ALIB_PY3}

# shellcode compiler
export SCC=${HOME}/repos/v35/scc/scc

# per-platform settings
platform=`uname`
# defaults
export EDITOR='vim'
# platform-specifics
if [[ $platform == 'Darwin' ]]; then
    echo setting Darwin-specific stuff...

    # command-line utils
    alias ls='ls -G'

    export EDITOR='subl -w'

    # languages 
    export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:${PYTHONPATH}
    export CLASSPATH=".:/usr/local/lib/antlr-4.5.1-complete.jar:$CLASSPATH"
    alias antlr4='java -jar /usr/local/lib/antlr-4.5.1-complete.jar'
    alias grun='java org.antlr.v4.gui.TestRig'

    # android
    export ANDROID_HOME=${HOME}/android-sdk-macosx
    alias adb=/usr/local/Cellar/android-platform-tools/22.0.0/bin/adb
    export NDK_R10C=/usr/local/Cellar/android-ndk-r10c/r10c

    # llvm
    export LLVM_PATH=/usr/local/Cellar/llvm/3.6.1
    export LLVM_PATH_BIN=${LLVM_PATH}/bin

elif [[ $platform == 'FreeBSD' ]]; then
    echo setting FreeBSD-specific stuff...
elif [[ $platform == 'Linux' ]]; then
    echo setting linux-specific stuff...

    alias ls='ls --color=auto'

    # android
    export ANDROID_HOME=${HOME}/android-sdk-linux
    export NDK_R10C=${HOME}/android-ndk-r10c/r10c
    export NDK_R10E=${HOME}/android-ndk-r10e
fi

# platform-generals that depended on the platform-specifics
export PATH=${PATH}:${ANDROID_HOME}/tools

# select the NDK from the various
export NDK=$NDK_R10E

# select cross compiler (setting CCOMPILER) - now you can use ${CCOMPILER}gcc, etc.
function ndk_arm_eabi {
	# select sysroot (where to find /usr/include, /usr/lib, etc.)
	export NDK_SYSROOT=$NDK/platforms/android-19/arch-arm
	export NDK_TOOLCHAIN_PATH=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
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
	export CCOMPILER=~/arm-eabi-4.7/bin/arm-eabi-
}


