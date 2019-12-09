# Emacs

## Install

There are a number of options for installing emacs, each one is a little
different:

- GNU:
  - `nix-env -i emacs`

- [emacs-mac](https://github.com/railwaycat/homebrew-emacsmacport):
  - `nix-env -i emacs-mac`
  - Clipboard integration also seems to work well.
  - Automatically binds meta to command. This takes a little getting used to.
    Sometimes conflicts with OS X shorcuts (e.g., C-M-d), and I don't
    understand how to resolve it.
  - This port has a toggle for the title bar, `mac-use-title-bar`. However, as
    of the time that I'm writing this, the toggle isn't available in the cask
    version.


## Note

Editing/keybindings:
- evil
- hydra
- https://github.com/mrkkrp/modalka
- god-mode

Evil mode stuff:
- https://github.com/Ambrevar/evil-special-modes
- https://github.com/jojojames/evil-integrations
- https://github.com/edkolev/evil-expat

idea: use modalka or something similar to enable a custom vim mode which uses
*emacs* bindings while in insert mode. This should give me the best of both
worlds: a vi-like experience for editing and pure emacs everywhere else.

Discovery: https://github.com/justbur/emacs-which-key


## Ideas

Ideas:
- Modal editing model, taking the best from vim, kakoune, vis/sam (and others?)
  - Implemented in modalka?
  - Default emacs while in insert mode (any exceptions to this?)
  - Kakoune's object-verb model
    - Create selections using a rich vocabulary of motions and text objects
    - Operate on selections using simple verbs
  - vis' rejection of line-wise searching
  - Multiple selections
  - Multiple cursors
  - Repeat last insert change
  - Repeat last motion
  - Emacs' repeat multiplier?
  - What about controlling where the cursor ends up after an operation?
    E.g., in emacs, `C-y` places the cursor after the yanked text, while
    `C-u C-y` places the cursor before the yanked text.
  - What about things like spell checking, wrapping, folding, joining, formatting/reflowing,
    completion, ...?
- Spacemacs-like leader behavior, with interactive feedback, for non-editing tasks
  (save, quit, file/buffer/window management, search, help system, ...)
- Is there a way to search a document based on its abstract syntax tree?
  This could enable new kinds of text objects.

- configuration
  - spell checking? Looks like I need to download another program and declare it in emacs.d.
  - Colors/theme
  - restore buffers and windows after quitting
  
