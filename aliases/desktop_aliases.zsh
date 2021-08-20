source ./aliases.zsh
alias sm="rsync -v -rlt --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"192.168.1.102::music//\""
alias bum="rsync -v -rlt --chmod=a=rw,Da+x --delete --exclude='*.jpg' --exclude='*.ini' --progress \"/mnt/d/Music/\" \"/mnt/f/Music/\""
