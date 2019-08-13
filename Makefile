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
	ln -s -f `pwd`/vimrc ~/.vimrc
	ln -s -f `pwd`/quickgnuplot.vim ~/.vim/quickgnuplot.vim
	ln -s -f `pwd`/quickpy.vim ~/.vim/quickpy.vim
	ln -s -f `pwd`/quickpng.vim ~/.vim/quickpng.vim
	ln -s -f `pwd`/quickc.vim ~/.vim/quickc.vim
	ln -s -f `pwd`/python.vim ~/.vim/ftplugin/python.vim
