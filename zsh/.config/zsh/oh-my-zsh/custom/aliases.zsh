# dirs
alias dot="cd $HOME/.dotfiles"
alias dl="cd $HOME/downloads"
alias bk="cd $OLDPWD"

# configs
alias nvimrc="vim $HOME/.config/nvim/init.lua"
alias zshrc="vim $HOME/.zshrc"
alias aliases="vim $HOME/.config/zsh/oh-my-zsh/custom/aliases.zsh"
alias funcs="vim $HOME/.config/zsh/oh-my-zsh/custom/functions.zsh"

# Colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# confirm before overwriting something
alias cp="cp -iv"
alias mv="mv -iv"

# use trash-d as rm replacement
alias rm="trash -v"
alias rmdir="trash -dv"
alias te="trash --empty"
alias tl="trash --list"

# use rsync to copy with progress bar
alias cpv='rsync -ah --info=progress2'

# always create parent directories
alias mkdir="mkdir -pv"

# use exa for colors
alias ls="exa"
alias l="exa -lga --icons --git"
alias ll="exa -lg --icons --git"
alias lls="exa -lg --icons --git --sort new"
alias llt="exa -lg --icons --git --tree --level 3"

# easier to read disk
alias df="df -h"     # human-readable sizes
alias free="free -h" # show sizes in MB
alias du="du -h"     # human readable sizes

# get top process eating memory
alias psmem="ps auxf | sort -nr -k 4 | head -5"

# get top process eating cpu ##
alias pscpu="ps auxf | sort -nr -k 3 | head -5"

# R
alias R="R --quiet --no-save"
alias radian="radian --quiet"

# music management
alias bm="beet ls -a missing:1.. -f '$year-$albumartist-$album https://musicbrainz.org/release-group/$mb_releasegroupid $missing'"
alias sm="rsync -v -rltO --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"omv:$HOME/pool/media/music\""
alias bum="rsync -v -rlt --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"/mnt/e/Music/\""
alias mi="mediainfo"
alias gm="cd ~/downloads/music && lftp hosting -e 'cd red'"

# git
alias gst="git status"
alias ga="git add"
alias gau="git add -u"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias lg="lazygit"

# get external IP address
alias myip='curl http://ipecho.net/plain; echo'

# get weather
alias weather="curl http://wttr.in/philadelphia\?u"O

# file associations
alias -s {txt,conf,cfg}=vim
alias -s {gif,png,jpg,tif}=viu
alias -s pdf=zathura
alias -s md=glow

# pacman
alias sp="pacman -Qeq > $HOME/.dotfiles/packages"

# bat
if (( $+commands[bat] )); then
  alias cat='bat'
fi

# rclone
alias rclone="nocorrect rclone"
alias rcc="rclone mount cloud:/files/ $HOME/cloud --daemon"
alias rccd="cd $HOME && fusermount -u $HOME/cloud"

# wsl
alias sw="/mnt/c/Windows/System32/wsl.exe --shutdown"
alias uw="/mnt/c/Windows/System32/wsl.exe --update"

# backup AUR files
alias ba="rsync ~/aur hosting:~/backup/ -rlv --info=progress2"

# docker
alias ldh="DOCKER_HOST=ssh://hosting lazydocker"

# tmux
alias ta="tmux a"

# global aliases
alias -g C='cat'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'
alias -g G='| rg -S' #smartcase
alias -g W='| wc -l'
