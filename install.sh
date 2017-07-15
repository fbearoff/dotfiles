#!/bin/bash

#install
sudo apt-get install vim-nox tmux htop tree zsh git

#sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/rupa/z.git ~/.oh-my-zsh/custom/plugins/z

#set aliases
{
    echo 'alias tmux="tmux -2"'
    echo 'alias cp="cp -iv"'
    echo 'alias mv="mv -iv"'
    echo 'alias ll="ls -alhtr"'
    echo 'alias weather="curl http://wttr.in/philadelphia\?u"'
    echo 'alias diff="colordiff"'
}  >> ~/.oh-my-zsh/custom/aliases.zsh
