# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

zstyle ':omz:update' mode auto      # update automatically without asking

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  autoupdate
  sudo
  zsh-autopair
  # zsh-vi-mode
  zsh-syntax-highlighting
)

# User configuration
export TERM="xterm-direct"
export R_LIBS_USER='~/.R/packages'
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export MANPAGER='nvim +Man!'
fi

KEYTIMEOUT=1
