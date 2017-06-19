# Dotfiles

This directory contains a basic set of dotfiles that should work on almost any
machine. Look in `macos` for macbook-specific dotfiles.

The `bashrc` file in this repo has a mechanism which recursively sources all
files in `~/.config/dotfiles/bash/pre` before it runs, and then all files in
`~/.config/dotfiles/bash/post` after it runs. This makes it possible to further
configure the shell without modifying the main `.bashrc` file (e.g., see the
`macos/install` script).
