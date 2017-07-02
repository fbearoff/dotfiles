#!/bin/bash

ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf

#set aliases
echo 'alias tmux="tmux -2"' >> ~/.oh-my-zsh/custom/aliases.zsh
echo 'alias cp="cp -iv"' >> ~/.oh-my-zsh/custom/aliases.zsh
echo 'alias mv="mv -iv"' >> ~/.oh-my-zsh/custom/aliases.zsh
echo 'alias ll="ls -alhtr"' >> ~/.oh-my-zsh/custom/aliases.zsh
echo 'alias weather="curl http://wttr.in/philadelphia\?u"' >> ~/.oh-my-zsh/custom/aliases.zsh
echo 'alias diff="colordiff"'  >> ~/.oh-my-zsh/custom/aliases.zsh
