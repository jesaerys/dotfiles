# dotfiles

Base configuration for macOS.

Prerequisites:
* Command Line Tools: `xcode-select --install`. This will ensure the
  availability of basic utilities like `git`, `ssh`, and `curl`.
* (Optional) Set up an SSH key for github.com. This is only a convenience and
  can be done at any time.

To install, simply clone this repo and run the provided installer:
```
git clone git@github.com:jesaerys/dotfiles.git
cd dotfiles
./dotfiles install
```

The installation process is not fully automatic, as some steps require an admin
password and/or confirmation.

If shell completion isn't working as expected for some commands, try running
`rm -f ~/.zcompdump; compinit`.


# SSH keys

## Setting up a new key

See the GitHub docs for details on setting up an SSH key
(https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
In brief,

  /usr/bin/ssh-keygen -t ed25519 -C "jacob.simones@gmail.com"
  eval "$(/usr/bin/ssh-agent -s)"
  /usr/bin/ssh-add ~/.ssh/id_ed25519

Add `id_ed25519.pub` to the GitHub account and test:

  ssh -T git@github.com

The docs recommend integrating with the macOS keychain by setting
`UseKeychain` and the `-K` option of `ssh-add`, but these steps aren't
necessary. However, if `UseKeychain` *is* set, then make sure to also set
`IgnoreUnknown = "UseKeychain"` because `UseKeychain` is not compatible
with all hosts (https://developer.apple.com/library/archive/technotes/tn2449/_index.html).


## Working with multiple identities

On systems with multiple keys for the same host (e.g., multiple accounts on
github.com---because GitHub doesn't allow using a key for more than one
account), the best setup seems to be to create an aliased host definition
for each key in which the key is associated with the host via
`IdentityFile`. No more than one of the host definitions can be named after
the actual host. For example,

  Host github.com
    IdentityFile ~/.ssh/id_ed25519

  Host github.com/other-account
    HostName github.com
    IdentityFile ~/.ssh/id_ed25519_other-account

With this configuration, the first and second accounts can be accessed
using the following commands, respectively:

  ssh -T git@github.com
  ssh -T git@github.com/other-account

Usage in git is similar, just substitute the actual hostname for the alias:

  git clone git@github.com/other-account:NixOS/nix.git

(Some sources have described also needing to enable `IdentitiesOnly` to get
this to work, which may be a good place to start if something breaks.)

Another approach is to rely on key lookup in the ssh agent. In principle,
configuring `IdentityFile`s isn't necessary if all keys have already been
added to the agent; ssh will try each key in turn (in `ssh-add -l` order)
until one of them succeeds. The trick, then, is to make sure the desired
key is listed before any other keys that are valid for the host. Keys can
be reordered by removing certain keys (`ssh-add -d`) and re-adding them to
the bottom of the list. This works in a pinch, but it's really cumbersome
if needed frequently.

Yet another approach (also not as convenient) is to configure ssh on the
fly. For example,

  ssh -o "IdentitiesOnly=yes" -i ~/.ssh/id_ed25519 -T git@github.com

For git commands, set the GIT_SSH_COMMAND environment variable:

  GIT_SSH_COMMAND='ssh -o "IdentitiesOnly=yes" -i ~/.ssh/id_ed25519' \
      git clone git@github.com:NixOS/nix.git


# Design notes

At first it seems appealing to manage dotfiles using `make` or even
configuration management tools like ansible, but it may be more trouble than
it's worth. These tools don't really support "rollbacks" (removing files that
were previously installed) without writing explicit recipes/playbooks to do so,
at which point I might as well just write a shell script.

Putting HOME under version control therefore seems appealing because adding,
removing, and changing configuration files is simply a matter of checking out
different branches. See the following for inspiration:
* https://github.com/RichiH/vcsh
* https://pgaskin.net/posts/git-dotfiles/
* https://github.com/alfunx/.dotfiles
* https://github.com/eli-schwartz/dotfiles.sh
The main issue with this approach is that there's no good way to deal with
shadowing of/by checked out files. For example, I have two dotfiles repos that
both have a `.gitignore` file checked out in `~`. Also, this approach relies
heavily on local configuration of git, which doesn't lend itself to version
control and hence why implementations often involve a helper command to init and
clone repos. All of this feels overly complicated and possibly an abuse of git.

I always seem to come back to a shell script installer as the least-bad
solution.
