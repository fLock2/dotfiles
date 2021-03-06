# fLock's qtile config that I kinda sorta stole from Derek Taylor sorry
# coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List  # noqa: F401

mod = "mod1"              # Sets mod key to Alt like a human who has used a laptop before
myTerm = "kitty"      # My terminal of choice
myBrowser = "vivaldi-stable" # My terminal of choice

keys = [
        ### The essentials
        Key([mod, "shift"], "Return",
            lazy.spawn(myTerm),
            desc='Launches My Terminal'
            ),
        Key([mod], "b",
            lazy.spawn(myBrowser),
            desc='Vivaldi'
            ),
        Key([mod], "Tab",
            lazy.screen.toggle_group(),
            desc='Move to last used group'
            ),
        Key([mod, "shift"], "Tab",
            lazy.next_layout(),
            desc='Switch to next layout'
            ),
        Key([mod, "shift"], "q",
            lazy.window.kill(),
            desc='Kill active window'
            ),
        Key([mod, "shift"], "r",
            lazy.restart(),
            desc='Restart Qtile'
            ),
        Key([mod, "shift"], "e",
            lazy.shutdown(),
            desc='Shutdown Qtile'
            ),
        Key([mod, "shift"], "s",
            lazy.spawn("urxvt -e systemctl suspend -i"),
            desc='Suspend Qtile'
            ),
        ### Treetab controls
        Key([mod, "shift"], "h",
            lazy.layout.move_left(),
            desc='Move up a section in treetab'
            ),
        Key([mod, "shift"], "l",
            lazy.layout.move_right(),
            desc='Move down a section in treetab'
            ),
        ### Window controls
        Key([mod], "j",
            lazy.layout.down(),
            desc='Move focus down in current stack pane'
            ),
        Key([mod], "k",
            lazy.layout.up(),
            desc='Move focus up in current stack pane'
            ),
        Key([mod, "shift"], "j",
                lazy.layout.shuffle_down(),
                lazy.layout.section_down(),
                desc='Move windows down in current stack'
                ),
        Key([mod, "shift"], "k",
                lazy.layout.shuffle_up(),
                lazy.layout.section_up(),
                desc='Move windows up in current stack'
                ),
        Key([mod], "h",
                lazy.layout.shrink(),
                lazy.layout.decrease_nmaster(),
                desc='Shrink window (MonadTall), decrease number in master pane (Tile)'
                ),
        Key([mod], "l",
                lazy.layout.grow(),
                lazy.layout.increase_nmaster(),
                desc='Expand window (MonadTall), increase number in master pane (Tile)'
                ),
        Key([mod], "n",
                lazy.layout.normalize(),
                desc='normalize window size ratios'
                ),
        Key([mod], "m",
                lazy.layout.maximize(),
                desc='toggle window between minimum and maximum sizes'
                ),
        Key([mod, "shift"], "f",
                lazy.window.toggle_floating(),
                desc='toggle floating'
                ),
        Key([mod], "f",
                lazy.window.toggle_fullscreen(),
                desc='toggle fullscreen'
                ),
        ### Stack controls
         Key([mod, "shift"], "Tab",
                 lazy.layout.rotate(),
                 lazy.layout.flip(),
                 desc='Switch which side main pane occupies (XmonadTall)'
                 ),
         Key([mod], "space",
                 lazy.layout.next(),
                 desc='Switch window focus to other pane(s) of stack'
                 ),
         Key([mod, "shift"], "space",
                 lazy.layout.toggle_split(),
                 desc='Toggle between split and unsplit sides of stack'
                 ),
]

group_names = [("WEBS", {'layout': 'monadtall'}),
        ("NOTE", {'layout': 'monadtall'}),
        ("DOCS", {'layout': 'monadtall'}),
        ("SYST", {'layout': 'monadtall'}),
        ("DEVS", {'layout': 'monadtall'}),
        ("CHAT", {'layout': 'monadtall'}),
        ("FREE", {'layout': 'monadtall'}),
        ("VOLM", {'layout': 'monadtall'}),
        ("MUSC", {'layout': 'floating'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

layout_theme = {"border_width": 2,
        "margin": 2,
        #enby colors
        #"border_focus": "fff430",
        #"border_normal": "9c59d1"
        #Nord colors
        #"border_focus": "88C0D0",
        #"border_normal": "5E81AC"
        #Solarized colors
        "border_focus": "FDF6E3",
        "border_normal": "93A1A1"
        }

layouts = [
        #layout.MonadWide(**layout_theme),
        #layout.Bsp(**layout_theme),
        #layout.Stack(stacks=2, **layout_theme),
        #layout.Columns(**layout_theme),
        #layout.RatioTile(**layout_theme),
        #layout.Tile(shift_windows=True, **layout_theme),
        #layout.VerticalTile(**layout_theme),
        #layout.Matrix(**layout_theme),
        #layout.Zoomy(**layout_theme),
        layout.MonadTall(**layout_theme),
        layout.Max(**layout_theme),
        layout.Stack(num_stacks=2),
        layout.RatioTile(**layout_theme),
        layout.TreeTab(
            font = "Iosevka",
            fontsize = 14,
            #Enby Colors
            #bg_color = "1c1f24",
            #active_bg = "c678dd",
            #active_fg = "000000",
            #inactive_bg = "a9a1e1",
            #inactive_fg = "1c1f24",
            #Nord Colors
            #bg_color = "2E3440",
            #active_bg = "4C566A",
            #active_fg = "ECEFF4",
            #inactive_bg = "3B4252",
            #inactive_fg = "E5E9F0",
            #Solarized Colors
            bg_color = "002B36",
            active_bg = "073642",
            active_fg = "93A1A1",
            inactive_bg = "002B36",
            inactive_fg = "839496",
            padding_left = 0,
            padding_x = 0,
            padding_y = 5,
            section_top = 10,
            section_bottom = 20,
            level_shift = 8,
            vspace = 3,
            panel_width = 225
            ),
        layout.Floating(**layout_theme)
        ]
# enby colors
#colors = [["#121212", "#121212"], # panel background
#        ["#3d3f4b", "#434758"], # background for current screen tab
#        ["#272822", "#272822"], # font color for group names
#        ["#fff430", "#fff430"], # border line color for current tab
#        ["#fff430", "#fff430"], # border line color for 'other tabs' and color for 'odd widgets'
#        ["#9c59d1", "#9c59d1"], # color for the 'even widgets'
#        ["#bbbbbb", "#bbbbbb"], # window name
#        ["#9c59d1", "#9c59d1"]] # backbround for inactive screens

# Nord Colors
#colors = [["#2E3440", "#2E3440"], # panel background
#        ["#3d3f4b", "#434758"], # background for current screen tab
#        ["#D8DEE9", "#D8DEE9"], # font color for group names
#        ["#88C0D0", "#88C0D0"], # border line color for current tab
#        ["#4C566A", "#4C566A"], # border line color for 'other tabs' and color for 'odd widgets'
#        ["#3B4252", "#3B4252"], # color for the 'even widgets'
#        ["#bbbbbb", "#bbbbbb"], # window name
#        ["#5E81AC", "#5E81AC"]] # backbround for inactive screens

# Solarized Colors
colors = [["#073642", "#073642"], # panel background
        ["#073642", "#073642"], # background for current screen tab
        ["#93A1A1", "#93A1A1"], # font color for group names
        ["#EEE8D5", "#EEE8D5"], # border line color for current tab
        ["#073642", "#073642"], # border line color for 'other tabs' and color for 'odd widgets'
        ["#073642", "#073642"], # color for the 'even widgets'
        ["#93A1A1", "#93A1A1"], # window name
        ["#93A1A1", "#93A1A1"]] # backbround for inactive screens

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
        #font="SFMono Nerd Font Mono",
        #font="Cascadia Mono",
        font="Iosevka",
        #font="Fira Code",
        fontsize = 14,
        padding = 2,
        background=colors[2]
        )
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
            widget.Sep(
                linewidth = 0,
                padding = 6,
                foreground = colors[2],
                background = colors[0]
                ),
            widget.Sep(
                linewidth = 0,
                padding = 6,
                foreground = colors[2],
                background = colors[0]
                ),
            widget.GroupBox(
                font = "Iosevka SemiBold",
                fontsize = 14,
                margin_y = 3,
                margin_x = 0,
                padding_y = 5,
                padding_x = 3,
                borderwidth = 3,
                active = colors[3],
                inactive = colors[7],
                rounded = False,
                highlight_color = colors[1],
                highlight_method = "line",
                this_current_screen_border = colors[6],
                this_screen_border = colors [4],
                other_current_screen_border = colors[6],
                other_screen_border = colors[4],
                foreground = colors[2],
                background = colors[0]
                ),
            widget.Prompt(
                prompt = prompt,
                font = "Cascadia Mono",
                padding = 10,
                foreground = colors[3],
                background = colors[1]
                ),
            widget.Sep(
                linewidth = 0,
                padding = 40,
                foreground = colors[2],
                background = colors[0]
                ),
            widget.WindowName(
                foreground = colors[6],
                background = colors[0],
                padding = 0
                ),
            widget.Systray(
                    background = colors[0],
                    padding = 5
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 6,
                    foreground = colors[0],
                    background = colors[0]
                    ),
            #widget.Net(
            #        interface = "wlp4s0",
            #        format = '{down} ?????? {up}',
            #        foreground = colors[2],
            #        background = colors[0],
            #        padding = 5
            #        ),
            widget.Battery(
                    padding = 2,
                    foreground = colors[2],
                    background = colors[5],
                    update_interval = 10
                    ),
            # widget.ThermalSensor(
              #          foreground = colors[2],
              #          background = colors[5],
              #          threshold = 90,
              #          padding = 5
              #          ),
              widget.TextBox(
                      text = " ???",
                      padding = 2,
                      foreground = colors[2],
                      background = colors[0],
                      fontsize = 14
                      ),
              widget.CheckUpdates(
                      update_interval = 1800,
                      distro = "Arch_checkupdates",
                      display_format = "{updates} Updates",
                      foreground = colors[2],
                      mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e paru -Syu')},
                      background = colors[0]
                      ),
              widget.TextBox(
                      text = " ????",
                      foreground = colors[2],
                      background = colors[5],
                      padding = 0,
                      fontsize = 14
                      ),
              widget.Memory(
                      foreground = colors[2],
                      background = colors[5],
                      mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e gotop')},
                      padding = 5
                      ),
              widget.CurrentLayoutIcon(
                      custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                      foreground = colors[0],
                      background = colors[0],
                      padding = 0,
                      scale = 0.7
                      ),
              widget.CurrentLayout(
                      foreground = colors[2],
                      background = colors[0],
                      padding = 5
                      ),
              widget.TextBox(
                      text = " Vol:",
                      foreground = colors[2],
                      background = colors[5],
                      padding = 0
                      ),
              widget.Volume(
                      foreground = colors[2],
                      background = colors[5],
                      padding = 5
                      ),
              widget.Clock(
                      foreground = colors[2],
                      background = colors[0],
                      format = "%A, %B %d - %H:%M "
                      ),
              ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[7:8]               # Slicing removes unwanted widgets (systray) on Monitors 1,3
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                 # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20))]

if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)

def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)

def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)

mouse = [
        Drag([mod], "Button1", lazy.window.set_position_floating(),
            start=lazy.window.get_position()),
        Drag([mod], "Button3", lazy.window.set_size_floating(),
            start=lazy.window.get_size()),
        Click([mod], "Button2", lazy.window.bring_to_front())
        ]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    Match(wm_class='kdenlive'),       # kdenlive
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
    Match(wm_class='urxvt'), # for running commands
    ])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
