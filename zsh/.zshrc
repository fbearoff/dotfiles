# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

# update automatically without asking
zstyle ':omz:update' mode auto

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

# silence ssh-agent
zstyle :omz:plugins:ssh-agent quiet yes

plugins=(
  autoupdate
  ssh-agent
  sudo
  zsh-autopair
  # zsh-vi-mode
  zsh-syntax-highlighting
)

ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
source $ZSH/oh-my-zsh.sh

## User config
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export MANPAGER='nvim +Man!'
fi

KEYTIMEOUT=1

# exports
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export TERM="xterm-direct"
export R_LIBS_USER="$HOME"/.R/packages
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
