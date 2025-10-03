# Setup for MacBook Pro (M1 Pro, 16-inch, 2021)

## Software

* Firefox, signing in to get synced settings
  * Signed in to Bitwarden, started saving logins for WBD things (SSO, GitHub
    and recovery codes, ...)
  * Not all settings synced
    * Default search engine: DuckDuckGo
    * Disables search suggestions
    * Vertical tabs
* VSCode, signing in via GitHub (jesaerys) to get synced settings
  * Ran command Shell Command: Install `code` command in PATH
* Command line tools (`xcode-select --install`)
* Spotify
* Nix, using the usual recommended multi-user installation.
  * Enabled flakes by adding `experimental-features = nix-command flakes` to
    `~/.config/nix/nix.conf`

I have other tools like `jq`, `awscli`, and whatnot. They're pretty trivial to
add as needed with `nix-env -i`.

***NOTE:*** I installed Karabiner-Elements, but it doesn't work because the
driver extension can't be loaded due to MDM.

## MacOS settings

* *Battery*
  * *Options*
    * Disable *Slightly dim the display on battery*
* *General*
  * *Date & Time*
    * Disable *Set time zone automatically using your current location* because
      the VPN seems to make my computer think it's in New York.
    * Choose Chicago as the closest city.
* *Accessibility*
  * *Zoom*
    * Enable *Use scroll gesture with modifier keys to zoom*
  * *Spoken Content*
    * Enable *Speak selection* (pick a system voice that seems good)
* *Appearance*
  * *Appearance*: *Auto*
  * *Accent color* and *Highlight color*: *Graphite*
*  *Desktop & Dock*
  * Manually removed almost everything from the dock
  * Enable *Automatically hide and show the Dock*
  * Disable *Show suggested and recent apps in Dock*
* *Spotlight*
  * Disable *Siri Suggestions and Websites*
  * Disable *Help Apple Improve Search*
* *Touch ID & Password*
  * Add a fingerprint
* *Keyboard*
  * *Key repeate rate*: fast
* *Trackpad*
  * *Point & Click*
    * Enable *Tap to click*
  * *Text Input*, *Input Sources*, U.S., *Edit…*
    * Disable *Add period with double-space*
    
  * *Scroll & Zoom*
    * Enable *Natural scrolling*

### Finder settings

* *General*
  * Hide *Hard disks* from desktop
  * *New Finder windows show*: jsimones
* *Sidebar*
  * Hide Recents
  * Show jsimones

## zsh

Using zsh because it's the default on macos. Keeping it simple with some
completion boilerplate plus a few other settings:

```zsh
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jsimones/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Repeat "❯" according to SHLVL, adjusting for the fact that vscode terminals
# tend to have SHLVL=3:
PROMPT_CHAR_REPEAT=$SHLVL
[[ "$TERM_PROGRAM" == "vscode" ]] && PROMPT_CHAR_REPEAT=$((SHLVL - 2))
(( PROMPT_CHAR_REPEAT < 1 )) && PROMPT_CHAR_REPEAT=1  # Must be gte 1
PROMPT_STRING=${(l:$PROMPT_CHAR_REPEAT::❯:)}  # zsh left-pad expansion
export PS1='%B%F{blue}%1~ '${PROMPT_STRING}' %f%b'

alias ll='ls -lF'
setopt interactivecomments

export PATH="$PATH:$HOME/.local/bin"

eval "$(direnv hook zsh)"
```

## SSH

Created an SSH key `~/.ssh/id_ed25519` for my work GitHub account, jacobsimones,
using the usual guide
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent.

* Enabled SSO for the SSH key in my settings page on GitHub.

I wanted to be able to work on personal repos on this computer, with access and
commits associated with my personal account, jesaerys. I created a second SSH
key named `~/.ssh/id_ed25519.personal`, added it to the SSH agent, and added it
to my personal github account as usual. Then I changed my `~/.ssh/config` like
so:

```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519

Host github-personal
  HostName github.com
  User git
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519.personal
```

With this setup, I can still clone as usual with my jacobsimones identity. But
for personal repos, I just need to change `github.com` to `github-personal`:

```sh
git clone git@github-personal:jesaerys/dotfiles.git
```

Once cloned, just make sure the repo is configured:

```sh
git config user.name "jesaerys"
git config user.email "simonj0@icloud.com"
```
