#!/bin/sh

export DESKTOP_SESSION=gnome
export QT_QPA_PLATFORMTHEME=qt5gtk2
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=opera
export EDITOR=scite

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# set keyboard repead rate
xset r rate 280 30
# per window kbd layout
perWindowLayoutD
# adjust backlight
xbacklight -set 15

# gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# openrc start openbox session
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session openbox-session > ~/.ob_session.log 2>&1

# systemd start openbox session
/usr/bin/openbox-session > ~/.openbox_startup.log 2>&1
