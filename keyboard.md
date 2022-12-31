# Keyboard stuff

## Observations

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


## Shortcuts

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
  * I could set `a` to hyper, and mapped hyper+h/j/k/l to arrow keys
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
