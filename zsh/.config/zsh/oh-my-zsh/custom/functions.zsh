# archive extractor
ex() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip2 $1;;
          *.rar) unrar x $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *.dmg) hdiutul mount $1;; # mount OS X disk images
          *) echo "'$1' cannot be extracted via >ex<";;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}

# pretty print $PATH
path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

# get number of files opened
function lfo() {
  nums=$(lsof | awk '{ print $2 " " $1; }' | sort -rn | uniq -c | sort -rn | head -20 | awk '{ sub(/^[ \t]+/, ""); print }')
  echo  "# PID Process\n$nums"
}

# find binary
function fb() {
  which "$1"
}

# music
function am() {
  for d in ~/downloads/music/* ; do
    if [[ -d "$d" && ! -L "$d" ]]
      mv "$d"/*.flac /mnt/d/Music
  done
}

# fix x11
function fx() {
  sudo ln -s /mnt/wslg/.X11-unix /tmp/.X11-unix
}

# Shell-GPT integration ZSH v0.1
_sgpt_zsh() {
  _sgpt_prev_cmd=$BUFFER
  BUFFER+="⌛"
  zle -I && zle redisplay
  BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd")
  zle end-of-line
}
zle -N _sgpt_zsh
bindkey ^l _sgpt_zsh
