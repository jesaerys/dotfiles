# Things I miss from macos

Is there some way to scroll to zoom?

Is there a way to have automatic switching between light/dark system themes?

Dictionary?
* I tried Dictionary in the pop shop. It was ok, but no thesaurus.
* I also tried Hypatia. It says it comes with a thesaurus, but I couldn't figure
  it out.
* Maybe I don't need this. It turns out that switching to firefox and using `!d`
  to search for a word isn't that inconvenient.


# Annoyances

System76:

* Battery doesn't perform very well
  * Drains noticeably during light use. I haven't tested the life extensively,
    but, I seriously doubt I would make it through a substantial fraction of a
    regular work day before having to plug in.
  * Seems to drain overnight. It's as if something is still running after the
    lid is closed.
    * Sometimes the battery drains completely.
  * Really slow to charge, almost 3 hours to get to 70%.
    * 0% at 8:10
* Display flickers sometimes. Closing the lid and waking seems to fix it.
* Fan constantly on and off during light work (e.g., browsing firefox with a
  few tabs and a terminal session).
* Wake issues? Examples:
  * I closed the lid while on battery, then a while later I plugged it in and
    then opened the lid and the system would not wake.
  * In the system menu (w/ volume, wifi, etc) I chose "Power Off / Log Out" >
    "Suspend", and I wasn't able to wake it up.
  * Not usually a big deal, but waking often briefly shows my desktop (whatever
    windows are open) before displaying the login screen. This is technically a
    security issue given that someone could glance confidential/sensitive
    information simply by opening the lid.
* Speakers are not good.

Slack:

* No system theme sync setting?!?
* Can I make the menu bar go away?


# Migration troubles

All of the keyboard issues mentioned above.

My vscode config has a bunch of cmd-based shortcuts that don't port to linux :(


# Things I've tried

* Installed keyboard configurator from the pop shop. This app is the system76
  way to config the keyboard.

  * Set the keyboard to my liking, then exported my config to a file which can
    be imported later.

  * These remappings happen at the firmware level, so they always apply, e.g.,
    at the login screen after restarting.

    * This means that if I remap return to ctrl and use xcape to use it as both
      ctrl and return, then I won't be able to use that key as return until I
      log in (when the xcape command runs). The Oryx Pro has an enter key in the
      numpad, so I can always use that.

  * There is a setxkbmap command that can do some of these remappings (e.g.,
    caps lock to ctrl), but apparently not all of them (e.g., return to ctrl).

  * Seems like kmonad can handle remappings, so I can use that instead of
    keyboard configurator or setxkbmap.

* Installed xcape (`sudo apt install xcape`)

  * The command `xcape -e 'Control_L=Escape;Control_R=Return'` is used to map
    caps lock (ctrl) to escape when tapped, and return (ctrl) to return when
    tapped.

  * The `xev` command is very useful for figuring out the name of a key.

  * Added an entry for this in Startup Applications, resulting in the file
    `cat ~/.config/autostart/xcape.desktop`, which can be added to source
    control.

  * Ended up disabling this because not having a functioning Enter key before
    login was getting annoying. I'll use kmonad for this kind of thing in the
    future.

Tips and things to look into:
* https://www.reddit.com/r/pop_os/comments/kvs19m/how_i_back_up_my_keybinds_etc/
