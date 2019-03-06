#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

WM="xmonad"

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

PATH="/home/thoth/exec:$PATH"
BROWSER="chromium"
export PATH BROWSER

# load solarized
xrdb ~/.Xresources
xbacklight -set 90

# load umlaute
xmodmap ~/.Xmodmap

xset s 9000
xset dpms 9000 9000 9000
xset m 0 0 # disable mouse acceleration (sc2)
nm-applet &
pasystray &
blueman-applet &
arandr-indicator &
conky -c ~/.conkyrc1
conky -c ~/.conkyrc2
udiskie --tray &
#xscreensaver -no-splash &
#xss-lock -- xscreensaver-command -lock &
synclient maxtaptime=0
xsetroot -cursor_name left_ptr
redshift &

rm -f .xmonad/xmonad.state
xmobar > /tmp/xmobar.stdout 2> /tmp/xmobar1.stderr &
#xmobar -x 0 > /tmp/xmobar1.stdout 2> /tmp/xmobar1.stderr &
# Goal was to have one xmobar per screen. But this creates a blocked pipe
# that will lead to a system freeze.
#xmobar -x 1 > /tmp/xmobar2.stdout 2> /tmp/xmobar2.stderr &
#xmobar -x 1 & --overlays the other xmobar in a single monitor setup
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
    --expand true --width 10 --transparent true --alpha 0 --tint 0x000000 \
    --height 16 --monitor 0 &  
exec /usr/bin/xmonad

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
