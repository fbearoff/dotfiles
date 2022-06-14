#!/bin/bash

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

mkdir -p $ZSH_CUSTOM/plugins/autoupdate

git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins \
  $ZSH_CUSTOM/plugins/autoupdate

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode

git clone https://github.com/hlissner/zsh-autopair.git \
  $ZSH_CUSTOM/plugins/zsh-autopair
