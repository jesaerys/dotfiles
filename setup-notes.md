(This is very rough, never really finished it.)

# Set-up notes

## Starting from a fresh system

### Setting up a new account

### Setting system preferences

### Installing some basics





* Did some stuff in the macos setup wizard, like disable location services,
  disable siri, enable disk encryption, ... Probably not super important to
  keep track of this, and these can always be changed in System Preferences.

* Went through System Preferences panel by panel, mostly to customize various
  appearances and the trackpad. Again, probably not important to keep detailed
  track of these settings. There aren't that many and they're easy enough to
  change in System Preferences. However, there are some things worth pointing
  out:

  * In System Preferences > Spotlight > Search Results, disable both
    "Spotlight Suggestions" and "Allow Spotlight Suggestions in Look up".

  * In System Preferences > Keyboard > Text, disable "Add period with
    double-space".

* Also went through some Finder preferences.

* Downloaded Brave along with these extensions:
  * LastPass (essential)
  * Dark Reader (nice to have)

* Installed Karabiner and imported the following complex modification rules:
  * Change caps_lock key
  * Change return to control

  Enabled the following rules:
  * Change caps_lock to control if pressed with other keys, to escape if pressed alone.
  * Change return to control if pressed with other keys, to return if pressed alone

  Note: these settings are tracked in `~/.config/karabiner/karabiner.json`, which 
  NOTE: I think these mods are brought in by my dotfiles anyway...

* Other nice-to-haves:
  * Spotify
  * Slack?


# Observations

On fresh macos catalina,

* The default shell is `/bin/zsh` and the version is,
  ```shell
  /bin/zsh --version
  zsh 5.7.1 (x86_64-apple-darwin19.0)
  ```

* I keep encountering directories that macos terminal.app needs permission to
  access:

  > “Terminal.app” would like to access files in your Downloads folder.

  By clicking OK, an entry for that directory shows up in System Preferences >
  Security & Privacy > Privacy > Files and Folders. Pretty annoying, but only
  a minor inconvenience.

* Both `/opt` and `/usr/local` exist and are empty.

* `~/.config`, `~/.local`, etc don't exist

* Some tools like `python` and `curl` are available on a fresh system. However,
  attempting to use other tools like `git` or `make` results in a message to
  install command line tools:

  > xcode-select: note: no developer tools were found at
  > '/Applications/Xcode.app', requesting install. Choose an option in the
  > dialog to download the command line developer tools.

  Along with a popup dialog,

  > The "git" command requires the command line developer tools. Would you like
  > to install the tools now?

  I tried choosing "Install", but it failed at the "Finding software" stage:

  > Can't install the software because it is not currently available from the
  > Software Update server.

  I also tried installing the tools with `xcode-select --install`, but that
  failed with the same error.

  Apparently this is a known problem: https://developer.apple.com/forums/thread/660641.
  The recommended solution is to get a copy of the installer from
  https://developer.apple.com/download/more/. I logged in with my Apple ID
  (same credentials I use for the app store) and downloaded `Command Line Tools
  for Xcode 12.dmg`, and the installation was successful.

  Note: Originally I did not install the command line tools right away.
  Instead, I tried getting by with just nix. This mostly worked, but it caused
  some minor annoyances, e.g., vscode asking me to install the command line
  tools whenever I opened a python file.


# Installing nix

Started out with the recommended command, but got an error due to running on
Catalina:
```shell
% curl -L https://nixos.org/nix/install | sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  2490  100  2490    0     0   2294      0  0:00:01  0:00:01 --:--:-- 99600
downloading Nix 2.3.7 binary tarball for x86_64-darwin from 'https://releases.nixos.org/nix/nix-2.3.7/nix-2.3.7-x86_64-darwin.tar.xz' to '/var/folders/98/bl9bpxy566l01fq8hr_8wtb40000gn/T/nix-binary-tarball-unpack.XXXXXXXXXX.DbZrLbBS'...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 26.4M  100 26.4M    0     0  5067k      0  0:00:05  0:00:05 --:--:-- 5781k
Note: a multi-user installation is possible. See https://nixos.org/nix/manual/#sect-multi-user-installation

Installing on macOS >=10.15 requires relocating the store to an apfs volume.
Use sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume or run the preparation steps manually.
See https://nixos.org/nix/manual/#sect-macos-installation

```

Ran again with the `--darwin-use-unencrypted-nix-store` as directed and got
another error, this time due to not having "encryption-at-rest" (I assume this
is a feature on newer macs):
```shell
% sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  2490  100  2490    0     0   2387      0  0:00:01  0:00:01 --:--:--  2387
downloading Nix 2.3.7 binary tarball for x86_64-darwin from 'https://releases.nixos.org/nix/nix-2.3.7/nix-2.3.7-x86_64-darwin.tar.xz' to '/var/folders/98/bl9bpxy566l01fq8hr_8wtb40000gn/T/nix-binary-tarball-unpack.XXXXXXXXXX.Gn8HN8mc'...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 26.4M  100 26.4M    0     0  5603k      0  0:00:04  0:00:04 --:--:-- 6135k
Note: a multi-user installation is possible. See https://nixos.org/nix/manual/#sect-multi-user-installation
Creating volume and mountpoint /nix.

     ------------------------------------------------------------------ 
    | This installer will create a volume for the nix store and        |
    | configure it to mount at /nix.  Follow these steps to uninstall. |
     ------------------------------------------------------------------ 

  1. Remove the entry from fstab using 'sudo vifs'
  2. Destroy the data volume using 'diskutil apfs deleteVolume'
  3. Remove the 'nix' line from /etc/synthetic.conf or the file

Configuring /etc/synthetic.conf...
Password:
nix
Creating mountpoint for /nix...
Creating a Nix Store volume...
error: refusing to create Nix store volume because the boot volume is
       FileVault encrypted, but encryption-at-rest is not available.
       Manually create a volume for the store and re-run this script.
       See https://nixos.org/nix/manual/#sect-macos-installation
```

Referred to the manual for the command to create a new APFS volume:
```shell
% sudo diskutil apfs addVolume disk1 APFS 'Nix Store' -mountpoint /nix
Password:
Will export new APFS Volume "Nix Store" from APFS Container Reference disk1
Started APFS operation on disk1
Preparing to add APFS Volume to APFS Container disk1
Creating APFS Volume
Created new APFS Volume disk1s6
Mounting disk
Setting volume permissions
Disk from APFS operation: disk1s6
Finished APFS operation on disk1
```

(Note: the actual command in the manual references "diskX", which doesn't
exist. Running the command as-is will produce the error, "Could not find APFS
Container Reference diskX". I used `diskutil apfs list` to see that my machine
uses the container named "disk1".)

Then, as directed, I retried the installer:
```shell
% sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100  2490  100  2490    0     0   2159      0  0:00:01  0:00:01 --:--:--  2159
downloading Nix 2.3.7 binary tarball for x86_64-darwin from 'https://releases.nixos.org/nix/nix-2.3.7/nix-2.3.7-x86_64-darwin.tar.xz' to '/var/folders/98/bl9bpxy566l01fq8hr_8wtb40000gn/T/nix-binary-tarball-unpack.XXXXXXXXXX.PHU1I3Ea'...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 26.4M  100 26.4M    0     0  5453k      0  0:00:04  0:00:04 --:--:-- 5954k
Note: a multi-user installation is possible. See https://nixos.org/nix/manual/#sect-multi-user-installation
Creating volume and mountpoint /nix.

     ------------------------------------------------------------------ 
    | This installer will create a volume for the nix store and        |
    | configure it to mount at /nix.  Follow these steps to uninstall. |
     ------------------------------------------------------------------ 

  1. Remove the entry from fstab using 'sudo vifs'
  2. Destroy the data volume using 'diskutil apfs deleteVolume'
  3. Remove the 'nix' line from /etc/synthetic.conf or the file

Using existing 'Nix Store' volume
Configuring /etc/fstab...
123
164
performing a single-user installation of Nix...
copying Nix to /nix/store.............................................
installing 'nix-2.3.7'
building '/nix/store/hqqr5jaxy2kaxij5jzz3kd8gd63qfdkm-user-environment.drv'...
created 7 symlinks in user environment
installing 'nss-cacert-3.49.2'
building '/nix/store/055gdwqrwg839skhjcp65r2inyzdxs1p-user-environment.drv'...
created 9 symlinks in user environment
unpacking channels...
created 1 symlinks in user environment
modifying /Users/jake/.zshrc...

Installation finished!  To ensure that the necessary environment
variables are set, either log in again, or type

  . /Users/jake/.nix-profile/etc/profile.d/nix.sh

in your shell.
```

Done.


# Changing the shell

macOS uses zsh 5.7.1 (`/bin/zsh`) as the default shell. To install the latest
zsh and set it as the default login shell,

```shell
nix-env -i zsh
sudo chpass -s $(readlink ~/.nix-profile/bin/zsh) jake
```


# dotfiles

Can't clone dotfiles without git. Either,
* Install command line tools
* Install git by some other means (nix, brew, ...)

Can't clone dotfiles via ssh without an ssh key. Part of adding a key involves
creating/modifying `~/.ssh/config`, which is tracked in dotfiles. Either,
* Forego getting ssh config from dotfiles and set up a key and the config
  manually following https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
  (I think this option makes the most sense)
* Clone dotfiles by some other means (https?) to get the ssh config. Still have
  to create the key itself, though.






# home-manager

Install nix, then install [home-manager](https://github.com/nix-community/home-manager):

```shell
$ nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
$ nix-shell '<home-manager>' -A install
```

```shell
$ home-manager switch
```

Now, have to set nix's zsh as the default shell:
```shell
$ echo $HOME/.nix-profile/bin/zsh | sudo tee -a /etc/shells
$ chsh -s $HOME/.nix-profile/bin/zsh
```








# Cool projects

https://github.com/koekeishiya/yabai

https://github.com/gokcehan/lf
https://github.com/jarun/nnn

https://github.com/junegunn/fzf

https://github.com/voldikss/vim-floaterm
https://github.com/liuchengxu/vim-clap

https://github.com/lincheney/fzf-tab-completion
https://github.com/Aloxaf/fzf-tab







# Upgrade to Big Sur (macOS 11.0)

Installed via Software Update in System Preferences.

Setup wizard after logging in for the first time:
- Disabled analytics
- Disabled Siri

Nix still seems to work, e.g., `/etc/shells` was not modified as a result of
the upgrade. A new directory was created, `~/Desktop/Relocated Items.nosync`.
It only contained the default version of `/etc/shells`, so I deleted it.

