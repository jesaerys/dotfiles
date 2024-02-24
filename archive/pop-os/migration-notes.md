# Migration notes

> *2024-01-16:* It's been a little more than one year since I started using my
> Oryx Pro with Pop!_OS in late 2022. I had previously been using MacOS on
> various macbooks for several years, so I had a lot of ingrained habits and
> muscle memory to deal with and the transition was initially pretty rough. I
> took a bunch of notes on my experience along the way, and I decided to compile
> them (somewhat edited) in this doc.
>
> I think most of the issues I had have been resolved at this point, so the
> notes here are just a record of what I used to struggle with. Probably my
> biggest breakthrough has been using kmonad to switch to a new keyboard layout
> with homerow modifiers and a nav layer. This has allowed me to stop fussing
> over the loss of command-key shortcuts and to more comfortably take linux as
> it is. I've also shifted away from relying on vim keybindings both in vscode
> and in the terminal. I'm instead using conventional navigation keys (arrows,
> home/end, pgup/pgdn) which are conveniently available under my fingers in my
> nav layer. And because the nav keys are now so easy to use, I no longer worry
> about things like editing text in non-vim contexts, navigating menus (with
> ctrl-n/ctrl-p), or switching tabs.
>
> There are still some things I miss both about my old macbook setup and about
> vim, but overall I feel just as productive now as I did before I switched to
> linux.
 

## Keyboard stuff

### Observations

ctrl is kind of overloaded in vscode with vscodevim because vim defines
ctrl-based keybindings that conflict with common system ones. This leads to
frequent paper cuts that don't happen in macos. A couple examples:

* ctrl+w doesn't close windows like it normally does
* ctrl+f scrolls in normal mode, does find in insert mode

I also notice that some of the shortcuts advertised in vscode don't work,
probably due to vscodevim. E.g., `ctrl+k v` to open markdown preview.

The normal way to switch tabs in most apps seems to be ctrl+pgup/pgdn.
How am I supposed to touch type those?!? They're further away than the arrow
keys.

I can switch apps using alt+tab, which feels exactly like cmd+tab in macos.
However, in macos I can switch in reverse order using cmd+`, whereas in pop_os I
have to use alt+shift+tab. The best way I've found is to shift with my right
pinky, but it's not as natural as cmd+tab/\` on macos. I hesitate to bind alt+`
because it's used to switch between windows within an app which is kind of nice.

I kind of miss having ctrl+n/p to move down/up in menus as well as basic emacs
keybindings for editing (browser, email, slack, ...). I notice the Gnome Tweaks
app has an option to enable emacs keybindings, but I'm not sure how well that
would work. What other keybindings would get messed up if I enabled this?

My muscle memory from macos:
* cmd+q: quit 
* cmd+w: close
* cmd+x, cmd+c, cmd+v: cut, copy, paste
* cmd+s: save
* cmd+t: new tab
* shift+cmd+[, shift+cma+]: next tab, prev tab
* cmd+l: focus search bar


### Shortcuts

One reason not to heavily customize pop_os shortcuts is because I don't want to
miss out on cool functionality built into the OS, especially as it continues to
develop.

https://github.com/petrstepanov/gnome-macos-remap: a heavily customized shortcut
system using autokey and gsettings. Not sure I want to go this far...

Table of Pop!_OS shortcuts:

| shortcut           | command                           | category                          |
|--------------------|-----------------------------------|-----------------------------------|
| alt+super+s        | toggle screen reader              | accessibility                     |
| alt+super+8        | toggle zoom                       | accessibility                     |
| alt+super+=        | zoom in                           | accessibility                     |
| alt+super+-        | zoom out                          | accessibility                     |
| super+f            | open home folder                  | launchers                         |
| super+e            | launch email client               | launchers                         |
| super+f1           | launch help browser               | launchers                         |
| super+t            | launch terminal                   | launchers                         |
| super+b            | launch web browser                | launchers                         |
| super+return       | adjustment mode                   | move, resize, and swap windows    |
| shift+super+h      | move window to left monitor       | move, resize, and swap windows    |
| shift+ctrl+super+j | move window to lower monitor      | move, resize, and swap windows    |
| shift+super+j      | move window to lower workspace    | move, resize, and swap windows    |
| shift+super+l      | move window to right monitor      | move, resize, and swap windows    |
| shift+ctrl+super+k | move window to upper monitor      | move, resize, and swap windows    |
| shift+super+j      | move window to upper workspace    | move, resize, and swap windows    |
| super+/            | launch and switch applications    | navigate applications and windows |
| super+j            | switch focus to window down       | navigate applications and windows |
| super+h            | switch focus to window left       | navigate applications and windows |
| super+l            | switch focus to window right      | navigate applications and windows |
| super+k            | switch focus to window down       | navigate applications and windows |
| ctrl+super+k       | switch to workspace above         | navigation                        |
| ctrl+super+j       | switch to workspace below         | navigation                        |
| ctrl+super+end     | move window to last workspace     | navigation                        |
| ctrl+super+home    | move window to workspace 1        | navigation                        |
| super+tab, alt+tab | switch applications               | navigation                        |
| ctrl+alt+tab       | switch system controls            | navigation                        |
| ctrl+alt+escape    | switch system controls directly   | navigation                        |
| super+end          | switch to last workspace          | navigation                        |
| super+home         | switch to workspace 1             | navigation                        |
| alt+escape         | switch windows directly           | navigation                        |
| alt+f6             | switch windows of an app directly | navigation                        |
| super+`            | switch windows of an app          | navigation                        |
| shift+ctrl+alt+r   | record a screencast interactively | screenshots                       |
| shift+print        | take a screenshot                 | screenshots                       |
| print              | take a screenshot interactively   | screenshots                       |
| alt+print          | take a screenshot of a window     | screenshots                       |
| super+n            | focus the active notification     | system                            |
| super+escape       | (disabled) lock screen            | system                            |
| ctrl+alt+delete    | log out                           | system                            |
| super+a            | show all applications             | system                            |
| super+v            | show the notification list        | system                            |
| alt+f2             | show the run command prompt       | system                            |
| super+d            | show workspaces                   | system                            |
| super+o            | change window orientation         | tiling                            |
| super+s            | toggle stacking mode              | tiling                            |
| super+g            | toggle floating/tiling window     | tiling                            |
| super+y            | toggle auto tiling                | tiling                            |
| super+space        | switch to next input source       | typing                            |
| shift+super+space  | switch to previous input source   | typing                            |
| alt+space          | activate the window menu          | windows                           |
| super+q            | close window (i.e., quit app?)    | windows                           |
| alt+f7             | move window                       | windows                           |
| alt+f8             | resize window                     | windows                           |
| super+m            | toggle maximization state         | windows                           |
| ctrl+super+h       | view as split on left             | windows                           |
| ctrl+super+l       | view as split on right            | windows                           |

* The only change I've made is to disable "lock screen" because I often hit
  super+escape when switching apps.

* The "Emacs Input" keybindings appear to be stored in
  `/usr/share/themes/Emacs/gtk-2.0-key/gtkrc` and
  `/usr/share/themes/Emacs/gtk-3.0/gtk-keys.css`
  * Can I toggle this setting with gsettings?
  * The keybinding include ctrl+n/p, but I doubt it will work the way I want in
    firefox because ctrl+n is used to open a new window.

* firefox keybindings?
  * Probably possible to set ctrl+shift+[ and ctrl+shift+] for prev/next tab,
    but requires an extension like
    https://addons.mozilla.org/en-US/firefox/addon/shortkeys
  * Not sure how to get ctrl+n/p functionality in the search bar, though.

* vscode keybindings? vscodevim?
  * ctrl+n/p works in completion menu, but not in the other vscode menus (e.g.,
    command palette, quick pickers, ...)

* Idea: another go at homerow modifiers? The philosophy here is instead of
  remapping a bunch shortcuts, remap the keyboard to make shortcuts easier to
  type.
  * I could set `a` to hyper, and map hyper+h/j/k/l to arrow keys
  * I could take this further by mapping pgup/pgdown to hyper+[/]
    and home/end to hyper+u/i or hyper+o/p.
  * Or use a nav layer instead of hyper

https://tbuss.de/posts/2021/5-capslock_as_vim_modifier/

/usr/bin/xmodmap: can be used to map a key to hyper (because System76 Keyboard
Configuration does not (yet) support hyper).

/usr/bin/xdotool: used to send keystrokes
  E.g., `xdotool keyup h key --clearmodifiers Left`

Drawbacks of home row mods:
* No way have tapped mods, e.g., tap alt to bring up the menu bar, tap super to bring up search, ...
* How to cancel a mod press without resolving as a letter? 
* can't hold to repeat letters
  * A potential way out of this is to resolve the key down event as the letter
    if there's no key up after ~1s. This will feel exactly like the normal
    hold-to-repeat behavior.
* The reason home row mods is nice is because each finger can be mapped to one
  of the four usual mods: ctrl, alt, cmd/super, and shift. But what if I wanted
  to support hyper as well? (Or wait, is hyper just shorthand for shift+ctrl+alt+super?)
* Ghosting/blocking (see https://www.microsoft.com/applied-sciences/projects/anti-ghosting-demo/)
  * In each of the following combinations, the last key is not registered on the
    Oryx Pro keyboard:
    * k l r
    * k ; `
    * k ; q
    * k ; g
    * a d 7
    * a d /
    * a f h
    * d f .
  * These issues can be alleviated by using other keys for combos, e.g., m for shift+ctrl, , for ctrl+alt, ...
    This could work well because I haven't detected any blocking issues for two-key combos.
  * Another idea is to use the thumb to determine when a key acts as a mod?
    Described here: https://precondition.github.io/home-row-mods

Take a look at kmonad: https://github.com/kmonad/kmonad/, https://www.reddit.com/r/vim/comments/pmqj0x/kmonad_gives_you_superpowers_youll_end_up_using/
* Does this eliminate the need for xcape? sxhkd? autokey?


## Things I miss from macos

Is there some way to scroll to zoom?

Is there a way to have automatic switching between light/dark system themes?

Dictionary?
* I tried Dictionary in the pop shop. It was ok, but no thesaurus.
* I also tried Hypatia. It says it comes with a thesaurus, but I couldn't figure
  it out.
* Maybe I don't need this. It turns out that switching to firefox and using `!d`
  to search for a word isn't that inconvenient.


## Annoyances

System76:

* Wake issues? Examples:

  * I closed the lid while on battery, then a while later I plugged it in and
    then opened the lid and the system would not wake.

  * In the system menu (w/ volume, wifi, etc) I chose "Power Off / Log Out" >
    "Suspend", and I wasn't able to wake it up.

  * System76 support suggested the following:
    ```
    sudo apt purge ~nvidia
    sudo apt clean
    sudo apt update
    sudo apt install system76-driver-nvidia
    sudo systemctl reboot
    ```
    I ran these commands on 2023-01-05. Time will tell whether it makes a
    difference.

    2023-01-17: The commands didn't fix the problem.

    2023-01-31: Support had me switch to integrated graphics a week ago, and I
    haven't had any issues whatsoever. Actually, waking feels significantly
    snappier now. I told support, and they responded, "We are working on a
    firmware update to address suspend issues though I don't have an ETA for
    when it would be released but we are working on!"

* Battery doesn't perform very well

  * Drains noticeably during light use. I haven't tested the life extensively,
    but, I seriously doubt I would make it through a substantial fraction of a
    regular work day before having to plug in.

  * Seems to drain overnight. It's as if something is still running after the
    lid is closed. Sometimes the battery drains completely.

  * Really slow to charge, almost 3 hours to get to 70%.

* Video conferencing is laggy. Here I have this beefy machine, yet doing a
  google meet in chrome slows my whole system down. `top` consistently shows 
  100% CPU for the chrome process. Bi-weekly company retro is the worst because
  I also have the trello board open, which spikes the CPU for firefox. I don't
  have any issues on my 2015 macbook.

* Speakers are not good. Even my 2015 macbook sounds better than this thing.

* The mic must not be very good because everyone seems to strongly prefer the
  audio from my headset.

* Fan constantly on and off during light work (e.g., browsing firefox with a
  few tabs and a terminal session).

* Display flickers sometimes. Closing the lid and waking seems to fix it.
  (Maybe this is an nvidia driver issue? If so, then maybe it will be resolved
  at the same time as the wake issue above?)

* Not usually a big deal, but waking often briefly shows my desktop (whatever
  windows are open) before displaying the login screen. This is technically a
  security issue given that someone could glance confidential/sensitive
  information simply by opening the lid.

* I don't like that the keyboard isn't centered. The main part of the keyboard
  is shoved over to the left to make room for the numpad, which is entirely
  superfluous.

Slack:

* No system theme sync setting?!?

* Can I make the menu bar go away?


## Migration troubles

All of the keyboard issues mentioned above.

My vscode config has a bunch of cmd-based shortcuts that don't port to linux :(


## Things I've tried

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
