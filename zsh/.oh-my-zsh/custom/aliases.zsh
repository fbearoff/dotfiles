alias nvimrc="nvim ~/.config/nvim/"

# Colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# confirm before overwriting something
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# easier to read disk
alias df="df -h"     # human-readable sizes
alias free="free -m" # show sizes in MB

# get top process eating memory
alias psmem="ps auxf | sort -nr -k 4 | head -5"

# get top process eating cpu ##
alias pscpu="ps auxf | sort -nr -k 3 | head -5"

alias weather="curl http://wttr.in/philadelphia\?u"
alias R="R --quiet"
alias bm="beet ls -a missing:1.. -f '$year-$albumartist-$album https://musicbrainz.org/release-group/$mb_releasegroupid $missing'"

alias sm="rsync -v -rltO --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"omv:~/pool/media/music\""
alias bum="rsync -v -rlt --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"/mnt/f/Music/\""
alias ls="exa"
alias l="exa -lga --icons --git"
alias ll="exa -lg --icons --git"
alias llt="exa -lg --icons --git --tree"
alias vim="nvim"
alias am="mv *.flac /mnt/d/Music"

#git
alias gst="git status"
alias ga="git add"
alias gau="git add -u"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git pull"
