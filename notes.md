# Setting up a new MacBook



## 1. Command Line Tools

Install Command Line Tools from the App Store.

Alternatively, run `xcode-select --install` and choose "Install" in the pop-up
window.

> **Note about Xcode:** Xcode is *very* large and takes a long time to install,
> so don't install it unless/until it's needed for certain. Command Line Tools
> should suffice in most cases.



## 2. Updates

Updating all system software is optional, but probably a good idea.

Updates can be installed from the App Store.

Alternatively, run `sudo softwareupdate -i -a`.



## 3. Keyboard customization

Install and run [Karabiner-Elements](https://pqrs.org/osx/karabiner/).

- Karabiner-Elements
  - Complex Modifications
    - Rules
      - Add rule
        - Import more rules from the Internet (open a web browser)
          - (Look for "Change caps_lock key" and choose Import)
	      - Change caps_lock to control if pressed with other keys, to
	        escape if pressed alone: Enable



## 4. Preferences

> **Note to self:** It's incredibly tempting to write a script to set
> preferences in macOS. ***Don't do it!*** It's a giant can of worms and it
> never works out (see Notes below for details and reminders). Just click
> through the necessary UIs and move on.
>
> JavaScript for Automation (JXA) commands are shown where applicable, just for
> reference.


### 4.1. System Preferences

- General
 - Appearance: "Graphite" (`Application('System Events').appearancePreferences.appearance = 'graphite'`)
  - Use dark menu bar and Dock: true (`Application('System Events').appearancePreferences.darkMode = true`)
  - Sidebar icon size: "Small"
- Desktop & Screen Saver
  - Desktop
    - Picture: "El Capitan 2" (`Application('System Events').currentDesktop.picture = '/Library/Desktop Pictures/El Capitan 2.jpg'`)
  - Screen Saver
    - Screen Saver: "Ken Burns"
    - Source: "National Geographic"
- Dock
  - Automatically hide and show the Dock: true (`Application('System Events').dockPreferences.autohide = true`)
- Spotlight
  - Search Results
    - Allow Spotlight Suggestions in Look up: false
    - Spotlight Suggestions: false
- Displays
  - Display
    - Resolution: "1920x1200"
    - Automatically adjust brightness: false
- Keyboard
  - Keyboard
    - Adjust keyboard brightness in low light: false
    - Touch Bar shows: "Expanded Control Strip"
  - Shortcuts
    - Full Keyboard Access: "All controls"
- Trackpad
  - Point & Click
    - Tap to click: true
  - More Gestures
    - Swipe between full-screen apps: "Swipe left or right with four fingers"
    - Mission Control: "Swipe up with four fingers"
    - App Exposé: "Swipe down with four fingers"
- Date & Time
  - Clock
    - Use a 24-hour clock: true
- Accessibility
  - Zoom
    - Use scroll gesture with modifier keys to zoom: "Control"
  - Display
    - Reduce transparency: true
  - Mouse & Trackpad
    - Trackpad Options…
      - Enable dragging: "three finger drag"


### 4.2. Dock

Remove all items (except for Finder and Trash, which can't be removed).


### 4.3. Finder

- General
  - Show on the desktop
    - Hard disks: false
- Sidebar
  - All My Files: false
  - iCloud Drive: false
  - Home: true
  - Recent Tags: false


### 4.4. Misc

Disable dictionary lookup, bound to command-ctrl-d, making that key combination
avaiable for other apps:

```
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'
```

Restart for the change to take effect. I know of no other way to disable
dictionary lookup. Some sources say to uncheck the box System Preferences >
Keyboard > Shortcuts > Services > Searching > Look Up in Dictionary, but I have
not found this to work.


### 4.5. Notes

Ideally, a script would be used to set various preferences such as those in the
System Preferences application. I've spent a considerable amount of time (more
than I'd like to admit) trying to figure this out and I'm now convinced that
there is no good solution. Let this be a reminder to never go down this road
again!

One approach to preference scripting, as demonstrated by dotfiles enthusiasts
all over GitHub, is to modify plist files using command line utilities like
`defaults` and `PlistBuddy`. The
[macOS-Defaults](https://github.com/kevinSuttle/macOS-Defaults) repo is a
canonical example. There are a few things about this approach that bother me,
though. First, figuring out the right domains, keys, and values to put into each
command is extremely tedious and often involves a lot of experimentation.
Second, plist editing commands are often cryptic and require liberal comments to
understand what they do or how they correspond to a UI like System Preferences.
Third, it's often necessary to kill/restart an application or service before a
change can take effect. Neither of these points are deal breakers, but they make
plist editing feel like hacking (in a bad way).

For many settings, especially those that take scalar values, plists editing
works well enough. However, most of the settings *I'm* interested in happen to
be difficult or impossible to apply this way. There are a few reasons for this:

- I can identify the exact domains and keys affected by changing a setting
  through a UI, but sometimes editing those plist values doesn't do anything.
  (Maybe I'm missing something in these cases?)

- Sometimes a plist file reverts after editing it. This is extremely mysterious
  and annoying. It is likely solved by first killing all processes that use the
  plist, but it's not always obvious which processes those are.

- Sometimes changing a setting through a UI doesn't register a change in any
  plist file. (Again, maybe I'm missing something).

A better approach is to use AppleScript or JavaScript for Automation (JXA) to
write [automation
scripts](https://developer.apple.com/library/content/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/).
Unlike to plist editing scripts, these tend to be fairly readable without
comments, their effect is immediate, and scripting dictionaries are available
for convenient reference. Unfortunately, however, the scripting dictionaries
only define a small fraction of the preferences found in System Preferences or
Finder. This fact limits the usefulness of automation scripts in practice, at
least for setting preferences. Hopefully this will improve in the future.

A tempting workaround is to use the automation facility to write UI scripts that
simulate clicking through a UI by hand. Discovering the hierarchy of UI elements
turns out to be no less tedious than plist hacking and the resulting code is
extremely verbose. It wouldn't be hard to look past these inconveniences *if* UI
scripting worked in all circumstances, but it doesn't. Sometimes there are UI
elements on the screen that cannot be accessed through the automation interface
due to how the UI was built. In such cases it's tempting to "fix" the UI script
by scripting the mouse itself using low-level Objective-C libraries--as if a
significant amount of time hasn't already been spent trying automate the UI to
set a single preference. Yak shaving comes to mind…

*Don't waste time hacking plists or scripting the UI.* Just don't. It *never*
works out except in the simplest cases. It's ultimately much easier to just
click through a UI manually.



## 5. SSH keys

See the [GitHub
guide](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
for details.

Create a new key:
```bash
ssh-keygen -t rsa -b 4096 -C "$USER@$HOSTNAME"
```
Accept the default file, `$HOME/.ssh/id_rsa`. Enter a passphrase and save it
in LastPass for later.

Start SSH-agent:
```bash
eval "$(ssh-agent -s)"
```

On macos, ~/.ssh/config should contain,
```
Host *
 AddKeysToAgent yes
 UseKeychain yes
 IdentityFile ~/.ssh/id_rsa
```

Add the key to the agent
```bash
ssh-add -K ~/.ssh/id_rsa
```

Share the public key (`~/.ssh/id_rsa.pub`) with any services that use SSH
access, e.g., GitHub. Use `pbcopy <~/.ssh/id_rsa.pub` to copy the key so it can
be pasted in the browser. For a remote server,

```bash
scp ~/.ssh/id_rsa.pub user@host:~
ssh user@host '[[ -d ~/.ssh ]] && {mkdir -p ~/.ssh; chmod 0700 ~/.ssh;};
    cat ~/id_rsa.pub >> ~/.ssh/authorized_keys;
    rm ~/id_rsa.pub'
```

Now try making an SSH connection. A password shouldn't be required. For GitHub,
```bash
ssh -T git@github.com
```



6. Changing the default shell

To change the default login shell, e.g., to `~/.nix-profile/bin/zsh`, first
make sure the shell is listed in `/etc/shells`. If it isn't, then add it:
```
$ sudo sh -c 'echo ~/.nix-profile/bin/zsh >>/etc/shells'
```

Then, set it as the default using `chsh`:
```
$ chsh -s ~/.nix-profile/bin/zsh
```
