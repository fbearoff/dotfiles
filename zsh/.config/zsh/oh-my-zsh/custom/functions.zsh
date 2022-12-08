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

# Septa Status
function isf() {
  rr_late="$(curl 'http://www.isseptafucked.com/api/rr' --silent|jq '.status.late')"
  advisory="$(curl 'http://www3.septa.org/hackathon/Alerts/get_alert_data.php?req1=all' --silent|jq '.')"
  rr_nor="$(echo "$advisory" | jq '.[] | select(.route_id == "rr_route_nor").advisory_message')"
  bus_k="$(echo "$advisory" | jq '.[] | select(.route_id == "bus_route_K").current_message' | head -1)"
 if [[ $rr_nor != "null" ]]; then
   echo "$rr_nor"
 else
   echo "No RR Advisories!"
 fi
 if [[ $bus_k != "null" ]]; then
   echo "Bus K: $bus_k"
 else
   echo "Bus K: No Advisories!"
 fi
 if [[  $rr_late  == "null" ]]; then
   echo "RR is on time!"
 elif [[ $rr_late =~ Norristown ]]; then
   echo "$rr_late"
 else
   echo "RR is on time!"
 fi
}

function nta() {
  next_n=$1
  dir=$2
  re='^[0-9]+$'
  if ! [[ $next_n =~ $re ]]; then
     next_n=1
  fi
  tt=$(curl http://www3.septa.org/hackathon/Arrivals/East%20Falls/"$next_n" --silent |jq)
  if [[ $dir == "home" ]]; then
   echo "$tt" | jq '.[] | .[].Northbound'
  elif [[ $dir == "work" ]]; then
     echo "$tt" | jq '.[] | .[].Southbound'
  else
     echo "$tt" | jq '.[]'
  fi
}

function septa() {
  read "?What is the departing station?: "  depart
  read "?What is the destination?: "  dest
  timetable="$(curl -X 'GET' \
            'https://www3.septa.org/api/Arrivals/index.php?station='${depart// /%20}'&results=20&direction=N' \
            -H 'accept: application/json' \
            --silent | jq)"
  out=$(echo "$timetable" | jq '.[] | .[].Northbound | first(.[] | select(.destination == "'$dest'")) | .train_id, .status, .depart_time')
  echo $out|awk 'BEGIN{ RS = "" ; FS = "\n" }{print "Train " $1 " is " $2 " and departing at " $3}'
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

# |awk '{print $2}'|sed s/:00.000\"//
