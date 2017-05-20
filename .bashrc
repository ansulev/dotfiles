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
alias systemctl='sudo systemctl'
alias pms='sudo pm-suspend'
alias reboot='sudo reboot'
alias halt='sudo poweroff'

# Networking
alias nmenu='sudo wifi-menu'
alias wconn='sudo netctl start home-wifi'
alias ddos='sudo hping3 -c 10000 -d 120 -S -w 64 -p 6881 --flood --rand-source'

# Stats
alias svcstat="systemctl list-units --state=running | grep -v systemd | awk '{print $1}' | grep service"
alias batstat='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

# Browsers
alias opera='opera --disk-cache-dir=/tmp/opera'
alias inox='inox --disk-cache-dir=/tmp/chromium'

# Sync time
alias stime='sudo ntpd -qg; sudo hwclock -w'

# Mount wdpass
alias wdpass='sudo cryptsetup luksOpen --key-file=/crypto_keyfile.bin /dev/sdb1 wdpass ; sudo mount -o compress=lzo,autodefrag /dev/mapper/wdpass /mnt/wdpass'

# Handy functions
source ~/.sh.d/functions
