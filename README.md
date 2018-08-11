The current way I'm using these is to symlink from my home directory into the repos directory. For example, from this dotfiles directory:

```
ln -s `pwd`/bashrc ~/.bashrc
```

For gdb, I point the link at whatever architecture I am working on:
```
ln -s `pwd`/gdbinit_mem .gdbinit_mem
ln -s `pwd`/gdbinit_x64 .gdbinit
ln -s `pwd`/gdbinit_arm .gdbinit
ln -s `pwd`/gdbinit_aarch64 .gdbinit
```

For vim, you might have to create the ~/.vim directory:
```
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/quickgnuplot.vim ~/.vim/quickgnuplot.vim
ln -s `pwd`/quickpy.vim ~/.vim/quickpy.vim
ln -s `pwd`/quickpng.vim ~/.vim/quickpng.vim
ln -s `pwd`/quickc.vim ~/.vim/quickc.vim
```

### .gdbinit for aarch64 (gdbinit_arch64)
![screenshot](misc/screenshot_gdbinit_aarch64.png?raw=true "screenshot")
