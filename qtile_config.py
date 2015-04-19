from libqtile.config import Key, Screen, Group, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget
from libqtile import hook
import os
import signal
import subprocess
import re


###########################################################
### Keys                                                ###
###########################################################
mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key(
        [mod], "k",
        lazy.layout.down()
    ),
    Key(
        [mod], "j",
        lazy.layout.up()
    ),
    Key([mod, "control"], "h",
        lazy.layout.grow()
    ),
    Key([mod, "control"], "l",
        lazy.layout.shrink()
    ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_down()
    ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_up()
    ),
    Key([mod, "shift"], "space",
        lazy.layout.flip()
    ),
    # Move windows up or down in current stack
    Key(
        [mod, "control"], "k",
        lazy.layout.shuffle_down()
    ),
    Key(
        [mod, "control"], "j",
        lazy.layout.shuffle_up()
    ),
    Key(
        [mod, "control"], "f",
        lazy.window.toggle_fullscreen()
    ),

    Key(
        [mod], "1",
        lazy.to_screen(0),
        lazy.group.toscreen(0)
    ),
    Key(
        [mod], "2",
        lazy.to_screen(1),
        lazy.group.toscreen(1)
    ),

    # Switch window focus to other pane(s) of stack
    Key(
        [mod], "space",
        lazy.layout.next()
    ),

    # Swap panes of split stack
    Key(
        [mod, "shift"], "space",
        lazy.layout.rotate()
    ),
    Key(
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB+")
    ),
    Key(
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -c 0 -q set Master 2dB-")
    ),
    Key(
        [], "XF86AudioMute",
        lazy.spawn("amixer -q set Master toggle"),
    ),
    # Leads to errors :(
    #Key(
    #    [], "XF86AudioMicMute",
    #    lazy.spawn("amixer -c 0 -q set Capture toggle")
    #),
    Key(
        [], "XF86Display",
        lazy.spawn("scrot '/home/thoth/view/screen_capture/%Y_%m_%d_%H:%M:%S.png'")
    ),
    Key(
        [], "XF86Tools",
        lazy.spawn('/home/thoth/exec/record_screen')
    ),
    Key(
        [], "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -dec 5")
    ),
    Key(
        [], "XF86MonBrightnessUp",
        lazy.spawn("xbacklight -inc 5")
    ),
    Key(
        [], "XF86LaunchA",
        lazy.spawn("xscreensaver-command --lock")
    ),
    Key(
        [], "XF86MyComputer",
        lazy.spawn("systemctl suspend")
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"], "Return",
        lazy.layout.toggle_split()
    ),
    Key([mod], "Return", lazy.spawn("terminator")),
    Key([mod], "BackSpace", lazy.spawn("Thunar")),
    Key([mod], "Return", lazy.spawn("terminator")),
    Key([mod], "comma", lazy.spawn("xterm -e 'journalctl -lfp0..4'")),
    Key([mod], "period", lazy.spawn("xterm -e 'htop'")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.nextlayout()),
    Key([mod], "w", lazy.window.kill()),
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod], "r", lazy.spawncmd()),
    Key([mod, "control", "shift"], "q", lazy.shutdown()),
]


###########################################################
### Groups                                              ###
###########################################################
groups = [
    Group("a.mail",
        matches=[Match(wm_class=['Mail', 'Thunderbird'])
    ]),
    Group("s.www", matches=[
        Match(wm_class=['chromium'], role=['browser'])
    ]),
    Group("d.dev", matches=[
        Match(wm_class=['terminator'])
    ]),
    Group("f.open"),
    Group("u.notes", matches=[
        Match(wm_class=['Qt Jambi application', 'keepassx', 'Keepassx'])
    ]),
    Group("i.msg", matches=[
        Match(wm_class=['Skype', 'skype', 'Pidgin', 'pidgin'])
    ]),
    Group("o.game", matches=[
        Match(wm_class=['Wine'])
    ]),
    Group("p.ctrl", matches=[
        Match(wm_class=['xterm', 'Xterm'])
    ]),
]

for i in groups:
    # mod1 + letter of group = switch to group
    name = i.name.split(".")[0]
    keys.append(
        Key([mod], name, lazy.group[i.name].toscreen())
    )

    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
        Key([mod, "shift"], name, lazy.window.togroup(i.name))
    )

dgroups_key_binder = None
dgroups_app_rules = []

border = dict(border_focus = "#072474")

layouts = [
    layout.Max(),
    layout.MonadTall(**border),
    layout.TreeTab(),
    #layout.Stack(stacks=2)
]


###########################################################
### Widgets                                             ###
###########################################################
widget_options = dict(fontsize=14)
screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(**widget_options),
                widget.Sep(),
                widget.Notify(**widget_options),
                widget.Prompt(**widget_options),
                widget.WindowName(**widget_options),
                widget.Pacman(**widget_options),
                #widget.NetGraph(),
                widget.Systray(),
                widget.BatteryIcon(battery_name="BAT0"),
                widget.BatteryIcon(battery_name="BAT1"),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p', **widget_options),
            ],
            30,
        ),
    ),
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(**widget_options),
                widget.WindowName(**widget_options),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p', **widget_options),
            ],
            30,
        ),
    ),
]


###########################################################
### Startup                                             ###
###########################################################
pid_record_path = os.path.expanduser("~/.qtile_tasks")

# Startup
def is_running(process):
    process = process.split()[0]
    s = subprocess.Popen(["ps", "axw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x):
            return True
    return False

def execute_once(process):
    if not is_running(process):
        return subprocess.Popen(process.split()).pid

def execute(process):
    return subprocess.Popen(process.split()).pid

@hook.subscribe.startup_once
def startup():
    execute("feh --bg-max --randomize /home/thoth/view/wallpaper/"),
    pids = [
        execute_once("nm-applet"),
        execute_once("udiskie --tray"),
        execute_once("xscreensaver -no-splash"),
        execute_once("xss-lock -- xscreensaver-command -lock"),
        execute_once("synclient MaxTapTime=0"),
        execute_once("skype"),
        execute_once("pidgin"),
        execute_once("chromium"),
        execute_once("thunderbird"),
        execute_once("keepassx"),
        execute_once("xflux -l 52.478836 -g 13.436614 -k 4400"),
        #execute_once("xfce4-power-manager"),
    ]
    pids = [str(p) for p in pids if p]
    with open(pid_record_path, "w") as pid_record:
        pid_record.write(",".join(pids))

def shutdown():
    with open("pid_record_path") as pid_file:
        pids = pid_file.read().split(",")
    for pid in pids:
        try:
            os.kill(int(pid), signal.SIGTERM)
        except OSError:
            pass # so process doesn't exist anymore, so what.
    lazy.shutdown()


###########################################################
### More hooks                                          ###
###########################################################
# Dialogues
@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    wclass = window.window.get_wm_class() == 'gcr-prompter'
    transient = window.window.get_wm_transient_for()
    if dialog or transient or wclass:
        window.floating = True

@hook.subscribe.screen_change
def restart_on_randr(qtile, ev):
    qtile.cmd_restart()
