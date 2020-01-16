# Installation

GNU ls is available in coreutils:

```
nix-env -iA nixpkgs.coreutils-full
```

Installing the `-full` version because it includes the manpages; the regular
`coreutils` derivation does not.


# Color testing

Sometimes it's tempting to write a script for testing `ls` output to help
decide on a good set of colors. Ideas I've had include,

- Execute a script that creates a directory with all different file types
  inside; run `ls` on the result.

  This doesn't really work because, in my experience, all of the file types
  are never found together in the same directory, and the result just looks
  completely artificial. Besides, I know of no easy way to create
  block/character device files, so this approach is incomplete. 

- Source a script that runs `ls` on some specific paths to simulate a
  "typical" screen of output when looking around the filesystem.

  The problem with this approach is that "typical" `ls` output only shows
  regular files and directories. Symlinks and executables are common enough,
  but they show up less frequently. All of the other file types are pretty
  uncommon; in fact, I can't find any pipes on my current system. It *is*
  possible to get a good mix of files in a screenfull of output using clever
  globing syntax, but the result looks anything but typical.

The main thing to get right when choosing colors is differentiating between
regular files, directories, symlinks, and executables. It's common to have a
mix of two or three of these types in a given directory (e.g., `/etc`,
`/usr/bin`). Very few directories will have all four.

Setuid/setguid executables are probably the next priority. When these are
found, they're usually mixed in with a larger number of regular executables
(e.g., `/usr/bin`), so they should be colored such that they stand out as
special (if that's the goal). Ditto for others-writable/sticky directories
with respect to regular directories (e.g., `/var`).

The remaining file types—sockets, pipes, block/character devices—are much
less common. They tend to be found together (e.g., `/var/run`, `/dev`), so it
should be sufficient to color them such that they stand out from regular
files and directories.
