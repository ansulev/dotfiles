#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Completion should be enabled by default if available
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

## OVERALL CONDITIONALS {{{
_islinux=false
[[ "$(uname -s)" =~ Linux|GNU|GNU/* ]] && _islinux=true

_isxrunning=false
[[ -n "$DISPLAY" ]] && _isxrunning=true

_isroot=false
[[ $UID -eq 0 ]] && _isroot=true
# }}}

# Set Editor and Browser
export EDITOR="vim"
export BROWSER="opera"

#
# Color output in console
#
alias ls='ls --color=auto'
alias diff='diff --color=auto'
# grep
export GREP_COLORS="1;32"
alias grep='grep --color=auto'
# less
export LESS='-R'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
# man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Fix for stupid apps
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# VMWare Fix
export VMWARE_USE_SHIPPED_LIBS='yes'

# Wine
export WINEPREFIX=$HOME/.config/wine/
export WINEARCH=win32
export WINEDLLOVERRIDES="winemenubuilder.exe=d"

# History Options
shopt -s histappend # append to the history file, don't overwrite it
shopt -s cmdhist # multiple line commands should be in a single line of history
# Ignore lines beginning with a space for purposes of history
HISTCONTROL=ignorespace
# write history live, rather than when a shell exits...
PROMPT_COMMAND='history -a'
# for setting history length see HISTSIZE and HISTFILESIZE in bash (1)
HISTSIZE=1000
HISTFILESIZE=5000
HISTIGNORE=l[asl]:cd:x:exit:man:sd:rs:telnet:ssh

# Useful Bash tweaks
shopt -s checkwinsize # update window size after every command
shopt -s autocd # typing a directory name should cd to that directory
shopt -s globstar # allow the /dir/**/file syntax
shopt -s extglob # extended globs

# Define console colors and variables
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P1DC322F" #red
    echo -en "\e]P2859900" #green
    echo -en "\e]PBB58900" #yellow
    echo -en "\e]P4268BD2" #blue
    echo -en "\e]P5D33682" #magenta
    echo -en "\e]P62AA198" #cyan
    clear #for background artifacting
fi

RESET='\[\033[0m\]'   # Text Reset
# Regular Colors
BLACK='\[\033[0;30m\]'    # Black
RED='\[\033[0;31m\]'      # Red
GREEN='\[\033[0;32m\]'    # Green
YELLOW='\[\033[0;33m\]'   # Yellow
BLUE='\[\033[0;34m\]'     # Blue
PURPLE='\[\033[0;35m\]'   # Purple
CYAN='\[\033[0;36m\]'     # Cyan
WHITE='\[\033[0;37m\]'    # White
# Bold
BBLACK='\[\033[1;30m\]'   # Black
BRED='\[\033[1;31m\]'     # Red
BGREEN='\[\033[1;32m\]'   # Green
BYELLOW='\[\033[1;33m\]'  # Yellow
BBLUE='\[\033[1;34m\]'    # Blue
BPURPLE='\[\033[1;35m\]'  # Purple
BCYAN='\[\033[1;36m\]'    # Cyan
BWHITE='\[\033[1;37m\]'   # White

# Default prompt is [user@host shortdir]$
# PS1='[\u@\h \W]\$ '

# PS1 for root (no git prompt):
# root@hostname:/working/directory
# #
# If connected via SSH, hostname and username will be different colours
#if [ -n "$SSH_CLIENT" ]; then
#  HOSTNAME_COLOUR=$BPURPLE
#else
#  HOSTNAME_COLOUR=$BCYAN
#fi
#PS1="${BRED}\u${RESET}@${HOSTNAME_COLOUR}\h${RESET}:${GREEN}\w\n ${RESET}# "

# PS1 for regular user:
# user@hostname:/working/directory (git branch)
# $
source /usr/share/git/completion/git-prompt.sh
PS1='\[\033[1;33m\]\u\[\033[0m\]@\[\033[1;36m\]\h\[\033[0m\]:\[\033[1;37m\]\w\[\033[0m\] \[\033[0;32m\]$(__git_ps1 "(%s)")\[\033[0m\]\n \$ '

#
# Common aliases
#
alias cls='clear'
alias mkdir='mkdir -p -v'
alias rmf='rm -rf'
#
alias l='ls -F'
alias la='ls -aF'
alias ll='ls -lh'
alias lha='ls -lhaF'
alias dir='ls -lhaF'
#
alias vi='vim'
alias sv='sudo vim'
alias sc='scite'
alias ssc='sudo scite'

# Pacman and yaourt
alias pacup='sudo pacman -Syu'
alias pacs='sudo pacman -S'
alias pacc='sudo pacman -Scc'
alias pacro='sudo pacman -Rns $(pacman -Qtdq)' # remove orphaned
alias paclf="pacman -Qii | awk '/^MODIFIED/ {print $2}'" # list changed files
alias pacr='sudo pacman -Rnsc'
alias yus='yaourt -S'
alias yup='yaourt -Sua'

# Privileges escalation
alias rc-update='sudo rc-update'
alias rc-service='sudo rc-service'
alias service='sudo service'
alias systemctl='sudo systemctl'
alias pms='sudo pm-suspend'
alias reboot='sudo reboot'
alias halt='sudo poweroff'

# Stats
alias svcstat="systemctl list-units --state=running | grep -v systemd | awk '{print $1}' | grep service"
alias batstat='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

# Browsers
alias opera='opera --disk-cache-dir=/tmp/opera'
alias inox='inox --disk-cache-dir=/tmp/chromium'

# Sync time
alias stime='sudo ntpd -qg; sudo hwclock -w'

# Handy functions
#source ~/.sh.d/functions

# Detailed information on an IP address or hostname
ipif() {
    if grep -P "(([1-9]\d{0,2})\.){3}(?2)" <<< "$1"; then
    curl ipinfo.io/"$1"
    else
    ipawk=($(host "$1" | awk '/address/ { print $NF }'))
    curl ipinfo.io/${ipawk[1]}
    fi
    echo
}

# Optimizing images for web, usage: $ smartresize input.jpg 900 output_dir
smartresize() {
   mogrify -path $3 -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}

# Extract
extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                   c=(bsdtar xvf);;
            *.7z)  c=(7z x);;
            *.Z)   c=(uncompress);;
            *.bz2) c=(bunzip2);;
            *.exe) c=(cabextract);;
            *.gz)  c=(gunzip);;
            *.rar) c=(unrar x);;
            *.xz)  c=(unxz);;
            *.zip) c=(unzip);;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                   continue;;
        esac

        command "${c[@]}" "$i"
        ((e = e || $?))
    done
    return "$e"
}

# cd and ls in one
cl() {
    local dir="$1"
    local dir="${dir:=$HOME}"
    if [[ -d "$dir" ]]; then
        cd "$dir" >/dev/null; ls
    else
        echo "bash: cl: $dir: Directory not found"
    fi
}

# Calculator
calc() {
    echo "scale=3;$@" | bc -l
}

# Simple note taker
note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # no arguments, print file
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        printf "%s" > "$HOME/.notes"
    else
        # add all arguments to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

# Simple task utility
todo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi

    if ! (($#)); then
        cat "$HOME/.todo"
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
        > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
        read -p "Type a number to remove: " number
        sed -i ${number}d $HOME/.todo "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}

#
# More cool functions: https://bbs.archlinux.org/viewtopic.php?id=30155
#

