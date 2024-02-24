# dotfiles

WIP setup for Oyrx Pro (oryp10) running Pop!_OS.


## Things I've done

* Set up Pop!_os (create account, tweak some basic desktop settings)

  * Set the power profile to "Battery Life". This seems to help tame the fans a
    bit (the fans tend to sporadically run high during apparently normal
    activities while on the default "Balanced" setting). I'm not yet sure
    whether this setting actually helps the battery last longer. I added this to
    Startup Applications to automatically re-enable the setting after reboot:
    `system76-power profile battery`.

  * Switched from "Hybrid Graphics" (the default) to "Integrated Graphics". I
    did this because when I first got the Oryx Pro, it would often not wake from
    sleep. System76 support eventually suggested switching to integrated
    graphics and I haven't had any issues with waking ever since. It's probably
    worth trying out hybrid graphics every now and then to see if the drivers
    have improved, as I get a sense that hybrid graphics is really the mode that
    System76 intends folks to use.

* Set up firefox (sign in, tweak settings)

  * Scrolling with the touchpad in firefox on linux *really* sucks for some
    reason. It's choppy and not at all smooth, despite having "smooth scrolling"
    enabled in settings. I found a reddit thread that recommended the following,
    which helps a lot:
    ```sh
    echo export MOZ_USE_XINPUT2=1 | sudo tee /etc/profile.d/use-xinput2.sh
    ```
    The resulting scrolling behavior feels a bit too "intertial", but it's way
    better than the default.
  
* Disabled tap-dragging:
  `xinput set-prop 'ELAN0412:00 04F3:316F Touchpad' 'libinput Tapping Drag Enabled' 0`

  * Inspired by https://askubuntu.com/questions/1032459/how-to-disable-the-tap-dragging-feature-in-ubuntu-18-04-libinput-without-dis

  * tl;dr:

    * `xinput list` to find the name and ID of the touchpad:

      * device name: 'ELAN0412:00 04F3:316F Touchpad'

      * ID: 13

    * `xinput list-props 13` to find the name of the property for tap dragging:

      * property name: 'libinput Tapping Drag Enabled'

    * `xinput set-prop ... 0` as shown above to disable

    * `xinput list-props 13` again to verify

  * Added an entry for this in Startup Applications, resulting in the file
    `cat ~/.config/autostart/xinput.desktop`, which can be added to source
    control.

  * ISSUE: the touchpad seems to reset after waking, so I have to rerun the the
    `xinput` command after every wake. Instead of mucking around with on-wake
    automation involving system files and `sudo`, I decided to just add the
    command to my `.bashrc`, so all I have to do is open a terminal and the
    setting is reapplied. Not ideal, but it's safe.

* Installed slack (flatpak) from the pop shop.

* Installed vscode (deb) from the pop shop.

  * I originally tried installing the flatpak version, but it's not able to use
    system SDKs, and it seems like that would cause problems down the road.

  * Set vscode as my git editor (so I don't have to use vi/vim):
    ```sh
    git config --global core.editor "code --wait"
    ```

* Installed rustup: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`.
  This added the line `. "$HOME/.cargo/env"` to both `~/.bashrc` and `~/.profile`.

* Created another gnome terminal profile that's a copy of "Pop", but with font
  size reduced to 10pt.

* Keyboard shortcuts:

  * Disabled the "Super+Esc" keyboard shortcut for locking the screen. I did
    this in Settings > Keyboard > "View and Customize Shortcuts" > System >
    "Lock screen". Now "Super+Esc" will simply cancel app switching via
    "Super+Tab".

  * Ran `ibus-setup` in the terminal to open the `ibus` config gui, then in the
    Emoji tab, I changed the "Emoji annotation" shortcut from "ctrl+shift+e" to
    "ctrl+alt+shift+super+e". I also changed the "Unicode code point" shortcut
    from "ctrl+shift+u" to "ctrl+alt+shift+super+u". This allows "ctrl+shift+e"
    to be used in vscode.

* Installed `kmonad`, which is a haskell project built using `stack`. (Release
  binaries are available for linux, but not for macOS, so I thought I might as
  well get used to building it myself.)

  * Started by installing `stack` via `ghcup`:

    * The installation docs list a number of system requirements which I
      installed via `apt`. One of them, `libffi6`, was not found, so I installed
      `libffi8` instead:
      ```sh
      sudo apt install build-essential curl libffi-dev libffi8 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5
      ```

    * I then ran the interactive `ghcup` installer. I accepted all of the
      defaults, except I chose to also install the language server (because why
      not):
      ```sh
      curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
      ```

    * After that, `stack` was available in `~/.ghcup/bin/`.

  * Then cloned the `kmonad` repo:
    ```sh
    cd ~/.local/share
    git clone https://github.com/kmonad/kmonad.git
    cd kmonad
    ```

  * Built the latest release (tag 0.4.1) according to the instructions:
    ```sh
    git checkout 0.4.1
    stack build
    stack install
    ```

  * `kmonad` was then available in `~/.local/bin`.

  * When I first tried to apply a keymap with `kmonad mymap.kbd`, I got:
    ```
    kmonad: /dev/uinput: openFd: permission denied (Permission denied)
    ```
    Looking at the [Linux FAQ][linux-faq], getting uinput permissions requires
    some extra steps.

    * I had to reboot after adding myself to the `input` and `uinput` groups
      before the `groups` command showed that I belonged to them.

    * I (sudo) created `/lib/udev/rules.d/99-kmonad.rules` with the recommended
      line. I used `/lib/udev/rules.d` instead of `/etc/udev/rules.d` because on
      my system the former already contained a bunch of `*.rules` files and
      therefore seemed like the right place, whereas the latter was an empty
      directory. I adopted the existing number-prefix naming convention, using
      99 to put my file near the end of the list.

    * I had to reboot again so that the uinput module was added to the kernel
      (verified by running `modprobe --first-time uinput`)

    * I seem to have to run `sudo modprobe uinput` every time I wake and reboot.

  * It isn't really explained in the docs, but `kmonad` works as a running
    process. For testing out layouts, just run `kmonad mylayoutfile.kbd` in a
    terminal, type some stuff elsewhere, then ctrl-c to stop `kmonad` in the
    terminal where it was running. Running it on startup/login will require
    either an init module or maybe an entry in Startup Applications.

[linux-faq]:
    https://github.com/kmonad/kmonad/blob/master/doc/faq.md#q-how-do-i-get-uinput-permissions


## Working with multiple GitHub accounts

Given multiple GitHub accounts, each with its own SSH key, what's the best way
to contribute to different repos using a specific account for each repo, all on
the same computer? A common use case is having a personal account and a work
account.

Here's a fairly simple solution using only git config:

```sh
export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519.foo -o IdentitiesOnly=true'  # 1
git clone git@github.com:foo/myrepo.git
cd myrepo
git config user.name 'foo'  # 2
git config user.email 'foo@email.com'
git config core.sshCommand "$GIT_SSH_COMMAND"  # 3
```

1. This effectively tells git which SSH key to use to clone the repo.

   Without this, SSH will try a bunch of different keys until it finds one that
   works for github.com (I think this is explained in `man ssh_config`). If each
   key is registered on github.com, then SSH will happily use whichever one it
   finds first. However, private repos can only be cloned by certain GitHub
   users as determined by the SSH key. Setting GIT_SSH_COMMAND explicitly
   controls which key will be used for cloning.

   An ostensible alternative is to reorder the keys in the SSH agent so that the
   desired one is encountered by SSH first. The command `ssh-add --list` shows
   the current order in which keys will be tried, from top to bottom.
   Unfortunately, there is no way (that I'm aware) to actually reorder the keys,
   so this isn't really workable in practice. The only way is to clear *all* of
   keys from the agent using `ssh-add -D` and then add the desired key with
   `ssh-add ~/.ssh/id_ed25519.foo` (i.e., the key is at the top of the list
   because it's the only key in the list). The passphrase needs to be re-entered
   every time a different key is used, which kind of defeats the convenience of
   using the SSH agent.

2. The user name and email are configured for git, just for *this* repo. The name
   and email should correspond to a GitHub account so that, when commits are
   viewed in GitHub, they are properly linked to that account.
   
   Keep in mind that this happens no matter what key is used to push the
   commits. For instance, consider the case in which commits are made with
   `user.name` and `user.email` set to "foo" and "foo@email.com", respectively
   (corresponding to a GitHub account), and those commits are pushed to the repo
   with the key `~/.ssh/id_ed25519.bar` (corresponding to a different GitHub
   account that has access to the repo). When viewed in GitHub, the repo will
   show that those commits are associated with the "foo" account, not the "bar"
   account.

3. The SSH command is set so that the desired key is used for all future git
   operations, without needing to use GIT_SSH_COMMAND.


### Other solutions

#### SSH config

Another very good solution is to use SSH config as described here:
https://stackoverflow.com/a/43009365. Basically, with a `~/.ssh/config` file
like this,

```
Host github.com-foo
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519.foo

Host github.com-bar
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519.bar
```

The example above becomes,

```sh
git clone git@github.com-foo:foo/myrepo.git
cd myrepo
git config user.name 'foo'
git config user.email 'foo@email.com'
```

Which looks a little cleaner than using GIT_SSH_COMMAND. However, aliases in git
commands can be confusing for anyone not familiar with SSH config, and therefore
may not be as intuitive. It also involves `~/.ssh/config` behind the scenes.


#### Shell script wrapper

The GitHub docs suggest creating a shell script wrapper for `git` that
dynamically sets GIT_SSH_COMMAND depending on the repo:
<https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-your-personal-account/managing-multiple-accounts>.
This is not a very elegant solution, though.


### In the browser

Firefox has multi-account containers, which makes it possible to be logged in to
multiple GitHub accounts simultaneously using a separate container for each
account.


## Dotfiles

I don't have much for actual config files these days. Both vscode and firefox
manage my settings in the cloud and I don't have a lot of other software to
configure.

I'm pretty much running the stock `~/.bashrc` from when my user account was
created. The only customizations I've added to that file are my prompt, the
tap-drag fix mentioned above, and whatever boilerplate is required for various
programming languages (e.g., `rustup`, `pyenv`, etc.):

```sh
PS1='\[\033[01;34m\]\W \$\[\033[00m\] '

# I already added this command in autostart, but the setting is lost during
# wake from sleep. This stupid hack reapplies the setting when a terminal is
# launched. It's not ideal, but it avoids having to muck with
# /lib/systemd/system-sleep/.
xinput set-prop 'ELAN0412:00 04F3:316F Touchpad' 'libinput Tapping Drag Enabled' 0
```

Other than that, I only have a couple settings in `~/.gitconfig` and
`~/.ssh/config` for work and that's it.
