all:
	echo 'try targets: install_bash install_gdb install_gdb_x64 install_gdb_arm install_gdb_aarch64 install_vim'

.PHONY: install_bash install_gdb install_gdb_x64 install_gdb_arm install_gdb_aarch64 install_vim 

install_misc:
	if [ ! -d "${HOME}/bin" ]; then mkdir ${HOME}/bin; fi
	ln -s -f `pwd`/semantichistory.py ${HOME}/bin
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

install_gdb_gef:
	ln -s -f `pwd`/gdbinit-gef.py ~/.gdbinit-gef.py
	echo 'Now edit ~/.gdbinit with "source ~/.gdbinit-gef.py"'

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
	ln -s -f `pwd`/vim/ftplugin/python.vim ~/.vim/ftplugin/python.vim
	ln -s -f `pwd`/vim/ftdetect/poke.vim ~/.vim/ftdetect/poke.vim
	ln -s -f `pwd`/vim/syntax/poke.vim ~/.vim/syntax/poke.vim
	ln -s -f `pwd`/vim/ftdetect/coq.vim ~/.vim/ftdetect/coq.vim
	ln -s -f `pwd`/vim/syntax/coq.vim ~/.vim/syntax/coq.vim
	ln -s -f `pwd`/vim/ftdetect/tatsu.vim ~/.vim/ftdetect/tatsu.vim
	ln -s -f `pwd`/vim/syntax/tatsu.vim ~/.vim/syntax/tatsu.vim
	ln -s -f `pwd`/vim/ftdetect/pie.vim ~/.vim/ftdetect/pie.vim
	ln -s -f `pwd`/vim/ftplugin/pie.vim ~/.vim/ftplugin/pie.vim
	ln -s -f `pwd`/vim/syntax/pie.vim ~/.vim/syntax/pie.vim
	ln -s -f `pwd`/vim/ftdetect/prolog.vim ~/.vim/ftdetect/prolog.vim
	ln -s -f `pwd`/vim/ftdetect/llvm.vim ~/.vim/ftdetect/llvm.vim
	ln -s -f `pwd`/vim/syntax/llvm.vim ~/.vim/syntax/llvm.vim
	ln -s -f `pwd`/vim/ftdetect/smt2.vim ~/.vim/ftdetect/smt2.vim
	ln -s -f `pwd`/vim/ftplugin/smt2.vim ~/.vim/ftplugin/smt2.vim
	ln -s -f `pwd`/vim/syntax/smt2.vim ~/.vim/syntax/smt2.vim
