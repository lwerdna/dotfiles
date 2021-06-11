all:
	echo 'try targets: install_bash install_gdb install_gdb_x64 install_gdb_arm install_gdb_aarch64 install_vim'

.PHONY: install_bash install_gdb install_gdb_x64 install_gdb_arm install_gdb_aarch64 install_vim 

install_bash:
	ln -s -f `pwd`/bashrc ~/.bashrc

install_gdb:
	ln -s -f `pwd`/gdbinit_mem ~/.gdbinit_mem

install_gdb_x64:
	rm -f ~/.gdbinit
	ln -s -f `pwd`/gdbinit_x64 ~/.gdbinit

install_gdb_arm:
	ln -s -f `pwd`/gdbinit_arm ~/.gdbinit

install_gdb_aarch64:
	ln -s -f `pwd`/gdbinit_aarch64 ~/.gdbinit

install_vim:
	if [ ! -d "${HOME}/.vim" ]; then mkdir ${HOME}/.vim; fi
	if [ ! -d "${HOME}/.vim/ftdetect" ]; then mkdir ${HOME}/.vim/ftdetect; fi
	if [ ! -d "${HOME}/.vim/ftplugin" ]; then mkdir ${HOME}/.vim/ftplugin; fi
	if [ ! -d "${HOME}/.vim/syntax" ]; then mkdir ${HOME}/.vim/syntax; fi
	ln -s -f `pwd`/vim/vimrc ~/.vimrc
	ln -s -f `pwd`/vim/quickgnuplot.vim ~/.vim/quickgnuplot.vim
	ln -s -f `pwd`/vim/quickpy.vim ~/.vim/quickpy.vim
	ln -s -f `pwd`/vim/quickpng.vim ~/.vim/quickpng.vim
	ln -s -f `pwd`/vim/quickc.vim ~/.vim/quickc.vim
	ln -s -f `pwd`/vim/python.vim ~/.vim/ftplugin/python.vim
	ln -s -f `pwd`/vim/ftdetect/poke.vim ~/.vim/ftdetect/poke.vim
	ln -s -f `pwd`/vim/syntax/poke.vim ~/.vim/syntax/poke.vim
