#!/bin/bash

#install
sudo apt-get install vim-nox tmux htop tree zsh git source-highlight ranger

#install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

#remove default .zshrc
rm ~/.zshrc

#link dotfiles
ln -s ~/dotfiles/ranger ~/.config/ranger/rc.conf
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf

#setup zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

#setup aliases
ln -s ~/dotfiles/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh

#setup ranger scope file
ranger --copy-config=scope

