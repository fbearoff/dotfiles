# Path to your oh-my-zsh installation.
export ZSH=$HOME/.config/zsh/oh-my-zsh

ZSH_THEME="bira"

# update automatically without asking
zstyle ':omz:update' mode auto

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

if [[ -x "$(command -v docker)" ]]; then
  plugins=(
  docker
  docker-compose
  )
elif [[ $(uname -r) =~ (m|M)icrosoft ]]; then
  plugins+=(ssh-agent)
fi
plugins+=(
  autoupdate
  sudo
  zsh-autopair
  # zsh-vi-mode
  zsh-syntax-highlighting
)

# ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent identities github

ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
source $ZSH/oh-my-zsh.sh

## User config

PATH=$HOME/.local/bin:$PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  export MANPAGER='nvim +Man!'
fi
# Adding wsl-open as a browser for Bash for Windows
if [[ $(uname -r) =~ (m|M)icrosoft ]]; then
  if [[ -z $BROWSER ]]; then
    export BROWSER=wsl-open
  else
    export BROWSER=firefox
  fi
fi

KEYTIMEOUT=1
setopt dotglob

# exports
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

export TERM="xterm-direct"
export R_ENVIRON_USER="$XDG_CONFIG_HOME"/R/Renviron
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
