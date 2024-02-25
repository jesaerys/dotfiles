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
