#!/bin/bash

ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/

#set aliases
{
    echo 'alias tmux="tmux -2"'
    echo 'alias cp="cp -iv"'
    echo 'alias mv="mv -iv"'
    echo 'alias ll="ls -alhtr"'
    echo 'alias weather="curl http://wttr.in/philadelphia\?u"'
    echo 'alias diff="colordiff"'
}  >> ~/.oh-my-zsh/custom/aliases.zsh

source ~/.zshrc
