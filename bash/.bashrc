IFS=$'\n\t'
set -o pipefail

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	set -eu
	return
fi

source $HOME/.config/helpers.sh
source $HOME/.config/completion.sh

#PLAN9=/home/bzs/src/plan9port
#export PLAN9
PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/home/bzs/.local/bin"
#"$PATH:/sbin:/usr/sbin:$HOME/.local/bin"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
#export SYSTEMD_PAGER=

# do not overwrite files when redirecting output by default.
set -o noclobber
set -o notify
set -o ignoreeof

shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob        # Necessary.
shopt -u mailwarn
unset MAILCHECK

bind 'set completion-ignore-case on'

#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset


ALERT=${BWhite}${On_Red} # Bold White on red background

NCPU=$(grep -c 'processor' /proc/cpuinfo)    # Number of CPUs
SLOAD=$(( 100*${NCPU} ))        # Small load
MLOAD=$(( 200*${NCPU} ))        # Medium load
XLOAD=$(( 400*${NCPU} ))        # Xlarge load

function load()
{
    local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
    # System load of the current host.
    echo $((10#$SYSLOAD))       # Convert to decimal.
}

# Returns a color indicating system load.
function load_color()
{
    local SYSLOAD=$(load)
    if [ ${SYSLOAD} -gt ${XLOAD} ]; then
        echo -en ${ALERT}
    elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
        echo -en ${Red}
    elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
        echo -en ${BRed}
    else
        echo -en ${Green}
    fi
}

function disk_color()
{
    if [ ! -w "${PWD}" ] ; then
        echo -en ${Red}
        # No 'write' privilege in the current directory.
    elif [ -s "${PWD}" ] ; then
        local used=$(command df -P "$PWD" |
                   awk 'END {print $5} {sub(/%/,"")}')
        if [ ${used} -gt 95 ]; then
            echo -en ${ALERT}           # Disk almost full (>95%).
        elif [ ${used} -gt 90 ]; then
            echo -en ${Red}            # Free disk space almost gone.
        else
            echo -en ${BCyan}           # Free disk space is ok.
        fi
    else
        echo -en ${Yellow}
        # Current directory is size '0' (like /proc, /sys etc).
    fi
}


function job_color()
{
    if [ $(jobs -s | wc -l) -gt "0" ]; then
        echo -en ${BRed}
    elif [ $(jobs -r | wc -l) -gt "0" ] ; then
        echo -en ${BCyan}
    fi
}
#PS1="\[${Cyan}\$(date +%H:%M)${NC} \]"
PS1="\[\$(job_color)\]\u"
PS1=${PS1}"\[${NC}\]@"
PS1=${PS1}"\[\$(load_color)\]\h\[${NC}\]:"
PS1=${PS1}"\[\$(disk_color)\]\w\[${Red}\]☭\[${NC}\]"


export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h:ls:jobs"
export HISTSIZE=-1
export HISTFILESIZE=-1

export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m %H:%M:%S]$(echo -e ${NC}) "


export HISTCONTROL=ignoredups
export HISTCONTROL="$HISTCONTROL erasedups:ignoreboth"

export EDITOR="nano"

alias more='less'
#export PAGER=less

#export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \
#:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'


export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
#export LESS='-R '

#PATH="/home/bzs/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/home/bzs/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/bzs/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/bzs/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/bzs/perl5"; export PERL_MM_OPT;
