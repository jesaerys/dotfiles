# macOS dotfiles

This directory contains macbook-specific dotfiles. These are meant to be
installed in addition to the basic set in the parent directory.

Some set-up tips for a new computer (assumes admin rights):

- Preferences
  - Map caps lock to control (see Hammerspoon below for mapping control to
    control/escape).
  - Some other nice tweaks:
    - Graphite appearance (button, menu, and window look)
    - Use dark menu bar and dock
    - Automatically hide and show the Dock
    - Scaled resolution, "more space"
    - Touch bar shows expanded control strip
    - Enable three-finger dragging (Accessibility > Mouse & Trackpad > Trackpad
      Options)
    - All trackpad gestures; tap to click; four-finger swipe for full-screen
      apps, mission control, and expose

- Make sure to update Xcode and Command Line Tools to their latest versions.

- [Hammerspoon](http://www.hammerspoon.org/)
  - [ControlEscape.spoon](https://github.com/jasonrudolph/ControlEscape.spoon):
    install as a spoon (download zip, unpack, double click); it is activated by
    the `hammerspoon/init.lua` file in this repo)

- [iTerm2](https://iterm2.com/)
  - [base16-iterm2](https://github.com/chriskempson/base16-iterm2) has some
    nice color presets, namely `base16-tomorrow.dark` (which is actually a
    light theme)
  - Some other nice tweaks:
    - Dark theme
    - Do not show per-pane title bar with split panes
    - Do not dim background panes or windows
    - Hide scroll bars
    - Never use thin strokes for anti-aliased text
    - 12pt Menlo Regular, 120% vertical spacing
    - Silence bell

- [Homebrew](https://brew.sh/)
  - bash: make sure to add `/usr/local/bin/bash` to `/etc/shells`, and then do
    `chsh -s /usr/local/bin/bash` to make this version of bash the default
  - bash-completion (sourced by `bash_profile` in this repo)
  - git
  - ncurses: for its terminfo database (linked by the install script), which is
    more up-to-date than macOS's
  - neovim
  - tree

- [Anaconda](https://anaconda.org/)

- ssh keys: [The GitHub guide](https://help.github.com/enterprise/2.9/user/articles/connecting-to-github-with-ssh/)
  is a good refresher
