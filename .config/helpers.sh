

# SHORT HISTORY ALIASES h() H()
#alias h='< ~/.bash_history grep -i'
#alias H='< ~/.bash_history grep'
alias g='grep -i'
alias G='grep'

# SHORT GREP FUNCTIONS c()
alias c='clear'
alias ls='ls --color -h'
#alias gls='ls -p -G --time-style=long-iso --group-directories-first --quoting-style=literal'
alias e='exa --time-style=long-iso --group-directories-first'
alias a=atool
alias yt=youtube-dl
alias df='df -hT'
alias du='du -hs'
alias sbcl='rlwrap sbcl'
bold=$(tput bold)
normal=$(tput sgr0)
#alias ls=exa
#alias ls='ls -h'
alias ll='ls -l'
alias ffmpeg='ffmpeg -hide_banner'
alias grep='grep --color'
alias lsg='ls | grep -i'
alias ip='ip -c'
alias debug="set -o nounset; set -o xtrace"

alias source-highlight="source-highlight --style-css-file /usr/share/source-highlight/sh_easter.css"
alias anime="torify youtube-dl"

alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'

alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'


function xtitle()
{
    case "$TERM" in
    *term* | rxvt)
        echo -en  "\e]0;$*\a" ;;
    *)  ;;
    esac
}


# Aliases that use xtitle
alias top='xtitle Processes on $HOST && top'
alias make='xtitle Making $(basename $PWD) ; make'


# SHORT QUERY FUNCTIONS q()
q() {
    if [ ${#} -eq 1 ]
    then
      ls | grep --color -i ${1} 2> /dev/null
    else
      echo "usage: q string"
    fi
  }

# SHORT QUERY FUNCTIONS Q()
Q() {
    if [ ${#} -eq 1 ]
    then
      ls | grep --color ${1} 2> /dev/null
    else
      echo "usage: Q string"
    fi
}

# SHORT QUERY FUNCTIONS qq()
qq() {
    if [ ${#} -eq 1 ]
    then
      find . \
        | grep -i ${1} 2> /dev/null \
        | cut -c 3-999 \
        | grep --color -i ${1} 2> /dev/null
    else
      echo "usage: qq string"
    fi
}

# SHORT QUERY FUNCTIONS QQ()
QQ() {
    if [ ${#} -eq 1 ]
    then
      find . \
        | grep ${1} 2> /dev/null \
        | cut -c 3-999 \
        | grep ${1} 2> /dev/null
    else
      echo "usage: QQ string"
    fi
}


# wrap these commands for interactive use to avoid accidental overwrites.
rm() { command rm -i "$@"; }
cp() { command cp -i "$@"; }
mv() { command mv -i "$@"; }

function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function ask()          # See 'killps' for example of use.
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}


tolink() {
    sed 's/\\//g' <<< $1
}

video() {
  mpv $(tolink "$1")
}
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    xtitle The $(basename $1|tr -d .[:digit:]) manual
    command man "$@"
}

transpose()
{
  awk '
  {
      for (i=1; i<=NF; i++)  {
          a[NR,i] = $i
      }
  }
  NF>p { p = NF }
  END {
      for(j=1; j<=p; j++) {
          str=a[1,j]
          for(i=2; i<=NR; i++){
              str=str" "a[i,j];
          }
          print str
      }
  }' $@
}

streamplay() {
    notify-send "Starting stream"
    setsid mpv "$1" >/dev/null 2>&1 ||
    notify-send "Stream failed"
}

#fortune metal-fairy-tale

transcode() {
  ffmpeg -i "$1" -c:v libvpx-vp9 -crf $3 -qmin $3 -qmax $3 -b:v 0 -g 240 -auto-alt-ref 2 -lag-in-frames 25 -tile-columns 3 -threads 4 -row-mt 1 -frame-parallel 1 -quality good -speed 4 -pass 1 -an -f webm /dev/null
  ffmpeg -i "$1" -c:v libvpx-vp9 -crf $3 -qmin $3 -qmax $3 -b:v 0 -g 240 -auto-alt-ref 2 -lag-in-frames 25 -tile-columns 3 -threads 4 -row-mt 1 -frame-parallel 1 -quality good -speed $4 -pass 1 -c:a libopus -b:a 96k -f webm "$2"
}

long() {
   $@;
#   espeak "bozd meg";
    mpv ~/Japanese\ Temple\ Bell\ Small-SoundBible.com-113624364.opus > /dev/null;
}

xzmax(){
     XZ_OPT="--lzma2=preset=9e,dict=512MB,nice=273,depth=200,lc=4" \
     xz $@;
}

gogo(){
  mpv "$(curl -s "$1" | grep  'var file = ' | awk -F\" '{print $2}')"
}

gpu(){
  var=$(radeontop -d - -l 1| awk '(NR % 2) == 0 {print $3}')
  printf "${var::-2}\n"
}
