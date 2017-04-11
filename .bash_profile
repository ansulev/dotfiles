#
# ~/.bash_profile
#

# source profile and bashrc if exists
[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.profile ]] && . ~/.profile

# if ~/.bin or ~/.scripts exist, include them in PATH
if [ -d "$HOME/.bin" ] ; then
    PATH="$PATH:$HOME/.bin"
fi
if [ -d "$HOME/.scripts" ] ; then
    PATH="$PATH:$HOME/.scripts"
fi

# start x on login
if [[ -z $DISPLAY && ! -e /tmp/.X11-unix/X0 ]]; then
  exec xinit -- /usr/bin/X -nolisten tcp vt7
fi
