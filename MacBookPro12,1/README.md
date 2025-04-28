# Setup for MacBook Pro (Retina, 13-inch, Early 2015)

(A bunch of stuff I don't even remember anymore... probably a combination of
whatever is in `archive/shell-script/misc/setup-notes.md` and
`archive/shell-script/README.md`.)

## zsh

Using zsh because it's the default on macos. `.zshrc` isn't fancy, it's
basically just some completion boilerplate plus a few other settings:

```zsh
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/jake/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

setopt interactivecomments

alias ll='ls -lF'
export PS1='%B%F{blue}%1~ $ %f%b'
export PATH="$PATH:$HOME/.local/bin"
```

## kmonad

Installed ghcup and stack in order to install kmonad,
then installed kmonad (worked as documented).
Seems to work great.

### Upgrading

Ok so the initial installation seemed to go smoothly, but updating kmonad seemed
trickier.

I had `kmonad` checked out in `~/.local/src/kmonad`, so I just went there and
did a `git pull --recurse-submodules`, checked out the tag of the latest release
(0.4.4), and attempted to follow the instructions at
<https://github.com/kmonad/kmonad/blob/0.4.4/doc/installation.md>.

The first major issue I had was that building requires `stack`, which is
available through `brew`, but my computer is so old now that `brew` has to build
absolutely everything from source. It took **9 hours** to build `stack`.

I'm going to think twice before uninstalling anything I got through `brew`...

Then I tried running `stack install --flag kmonad:dext` as ran into the second
issue:

```raw
/Users/jake/.local/src/kmonad/c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/include/pqrs/karabiner/driverkit/client_protocol_version.hpp:5:10: error:
     fatal error: 'type_safe/strong_typedef.hpp' file not found
  |                   
5 | #include <type_safe/strong_typedef.hpp>
  |          ^        
#include <type_safe/strong_typedef.hpp>
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.    
`g++' failed in phase `C++ Compiler'. (Exit code: 1)
Completed 56 action(s).

Error: [S-7282]
       Stack failed to execute the build plan.
       
       While executing the build plan, Stack encountered the error:
       
       [S-7011]
       While building package kmonad-0.4.4 (scroll up to its section to see the error) using:
       /Users/jake/.stack/setup-exe-cache/x86_64-osx/Cabal-simple_w2MFVN35_3.10.3.0_ghc-9.6.6 --verbose=1 --builddir=.stack-work/dist/x86_64-osx/ghc-9.6.6 build lib:kmonad exe:kmonad --ghc-options " -fdiagnostics-color=always"
       Process exited with code: ExitFailure 1
```

Scrolling up a little more, I found,

```raw
Warning: 'include-dirs:
c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/src/Client/vendor/include'
specifies a directory which does not exist.
```

I eventually figured out that the submodules fell out of sync when I checkout
out tag 0.4.4, so the submodules were in a newer, different state than what the
kmonad source expected. So I ran `git submodule update --init --recursive`,
tried again, and it worked.

Another thing that kind of threw me for a loop was installing
`Karabiner-VirtualHIDDevice-Manager`. At some point along the way I thought I
should try reinstalling it from scratch. Uninstalling it was an ordeal. I forget
exactly what I did, but it involved running `sudo launchctl list | grep -i karabiner`,
running some form of `launchctl bootout` on the entries, and then removing
whatever plist files I found in `/Library/Launch{Agents,Daemons}`. I was then
able to install `Karabiner-VirtualHIDDevice-Manager` according to the guide, but
activating it wouldn't work. I kept getting this:

```raw
$ /Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager activate
activation of org.pqrs.Karabiner-DriverKit-VirtualHIDDevice is requested
request of org.pqrs.Karabiner-DriverKit-VirtualHIDDevice requires user approval
```

I finally figured out that all I had to do was go to "System Preferences" >
"Security & Privacy", and click "Allow" next to the message saying something
like: "System software from developer 'pqrs.org' was blocked from loading."

## QLMarkdown

Installed QLMarkdown to preview markdown files with QuickLook
(<https://github.com/sbarex/QLMarkdown>).

```sh
brew install --cask qlmarkdown
```

(Apparently I have homebrew.)
