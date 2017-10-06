The current way I'm using these is to symlink from my home directory into the repos directory. For example, from this dotfiles directory:
```
ln -s $DOTFILES/bashrc ~/.bashrc
```

For gdb, I point the link at whatever architecture I am working on:
```
ln -s $DOTFILES/gdbinit_mem .gdbinit_mem
ln -s $DOTFILES/gdbinit_x64 .gdbinit
ln -s $DOTFILES/gdbinit_arm .gdbinit
ln -s $DOTFILES/gdbinit_aarch64 .gdbinit
```

For vim, you might have to create the ~/.vim directory:
```
ln -s $DOTFILES/vimrc ~/.vimrc
ln -s $DOTFILES/quickgnuplot.vim ~/.vim/quickgnuplot.vim
ln -s $DOTFILES/quickpy.vim ~/.vim/quickpy.vim
ln -s $DOTFILES/quickc.vim ~/.vim/quickc.vim
```

### .gdbinit for aarch64 (gdbinit_arch64)
![screenshot](misc/screenshot_gdbinit_aarch64.png?raw=true "screenshot")
