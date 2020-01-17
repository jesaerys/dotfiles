Nix automatically places the following paths on PATH:

- `${HOME}/.nix-profile/bin`
- `/nix/var/nix/profiles/default/bin`

Nix does this by modifying `/etc/bashrc` to source
`/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh`, which prepends
PATH with the aforementioned paths. Recall that `/etc/bashrc` is sourced by
`/etc/profile`, which is automatically sourced for all login shells.

Interestingly, the nix paths appear in PATH twice---once at the beginning and
once at the end---for any login shell spawned from another login shell, e.g.,
terminals in vscode. This happens because,

- The parent shell's PATH begins with the nix paths due to `nix-daemon.sh`,
  as explained above.

- The spawned shell inherits PATH from the parent shell. It then sources
  `/etc/profile`, which sources `/usr/libexec/path_helper` (see `man
  path_helper`).

  - The path_helper utility is mainly responsible for building up a *new* PATH
    from the entries in `/etc/paths` (`/usr/local/bin`, etc.) plus whatever
    it finds in `/etc/paths.d` (e.g., TeX, if installed).

  - It appends the original PATH to the new PATH. This is why the nix paths
    end up at the end.

  - It also removes duplicates such that only the first occurrence of an
    entry is preserved. This is why system entries like `/usr/local/bin` only
    show up once.

- Then, `/etc/bashrc` is sourced, followed by `nix-daemon.sh`, which adds the
  nix paths to the beginning of PATH.
