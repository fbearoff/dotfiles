alias tmux="tmux -2"
alias cp="cp -iv"
alias mv="mv -iv"
alias ll="ls -alhtr"
alias weather="curl http://wttr.in/philadelphia\?u"
alias diff="colordiff"
alias R="R --quiet"
alias bm="beet ls -a missing:1.. -f '$year-$albumartist-$album https://musicbrainz.org/release-group/$mb_releasegroupid $missing'"

alias sm="rsync -v -rlt --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"192.168.1.102::music//\""
alias bum="rsync -v -rlt --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"/mnt/f/Music/\""
