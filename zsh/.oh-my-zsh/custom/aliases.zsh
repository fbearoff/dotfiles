# dirs
alias dot="cd ~/.dotfiles"
alias dl="cd ~/downloads"
alias bk='cd $OLDPWD'

# configs
alias nvimrc="vim ~/.config/nvim/init.lua"
alias zshrc="vim ~/.zshrc"
alias aliases="vim ~/.oh-my-zsh/custom/aliases.zsh"

# Colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# confirm before overwriting something
alias cp="cp -iv"
alias mv="mv -iv"
# alias rm="rm -iv"
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
alias llt="exa -lg --icons --git --tree"

# easier to read disk
alias df="df -h"     # human-readable sizes
alias free="free -m" # show sizes in MB
alias du="du -h"     # human readable sizes

# get top process eating memory
alias psmem="ps auxf | sort -nr -k 4 | head -5"

# get top process eating cpu ##
alias pscpu="ps auxf | sort -nr -k 3 | head -5"

# R
alias R="R --quiet"
alias radian="radian --quiet"

# music management
alias bm="beet ls -a missing:1.. -f '$year-$albumartist-$album https://musicbrainz.org/release-group/$mb_releasegroupid $missing'"
alias sm="rsync -v -rltO --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"omv:~/pool/media/music\""
alias bum="rsync -v -rlt --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"/mnt/f/Music/\""
alias am="mv *.flac /mnt/d/Music"
alias mi="mediainfo"

#git
alias gst="git status"
alias ga="git add"
alias gau="git add -u"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"

# get external IP address
alias myip='curl http://ipecho.net/plain; echo'

# get weather
alias weather="curl http://wttr.in/philadelphia\?u"O

# file associations
alias -s {txt,conf,cfg}=vim
alias -s {gif,png,jpg,tif}=viu
alias -s pdf=zathura
alias -s md=glow

# wget
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

# pacman
alias sp="pacman -Qeq > $HOME/.dotfiles/packages"

# bat
if (( $+commands[bat] )); then
  alias cat='bat'
fi
