Installation:
```
    git clone git://github.com/ntmoe/dotvim.git ~/.vim
```
Create symlinks:
```
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
```

Switch to the `~/.vim` directory, and install Vim-Plug:
```
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Install packages in Vim with Vundle:
```
    $ vim
    :PlugInstall
```
