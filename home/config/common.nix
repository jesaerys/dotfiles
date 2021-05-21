{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.stateVersion = "21.03";

  imports = [
    ./zsh.nix
    ./coreutils.nix
  ];

  programs.info.enable = true;
  home.extraOutputsToInstall = [
    "info"
  ];

  home.packages = with pkgs; [
    diffutils
    findutils
    gnugrep
    gnused
    gnutar
    jq
    less
    shellcheck
  ];

  programs.ssh.enable = true;
  # # Setting up ssh keys
  #
  # See the GitHub docs for details on setting up an SSH key
  # (https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
  # In brief,
  #
  #   /usr/bin/ssh-keygen -t ed25519 -C "jacob.simones@gmail.com"
  #   eval "$(/usr/bin/ssh-agent -s)"
  #   /usr/bin/ssh-add ~/.ssh/id_ed25519
  #
  # Add `id_ed25519.pub` to the GitHub account and test:
  #
  #   ssh -T git@github.com
  #
  # The docs recommend integrating with the macOS keychain by setting
  # `UseKeychain` and the `-K` option of `ssh-add`, but these steps aren't
  # necessary. However, if `UseKeychain` *is* set, then make sure to also set
  # `IgnoreUnknown = "UseKeychain"` because `UseKeychain` is not compatible
  # with all hosts (https://developer.apple.com/library/archive/technotes/tn2449/_index.html).
  #
  #
  # # Working with multiple identities
  #
  # On systems with multiple keys for the same host (e.g., multiple accounts on
  # github.com---because GitHub doesn't allow using a key for more than one
  # account), the best setup seems to be to create an aliased host definition
  # for each key in which the key is associated with the host via
  # `IdentityFile`. No more than one of the host definitions can be named after
  # the actual host. For example,
  #
  #   Host github.com
  #     IdentityFile ~/.ssh/id_ed25519
  #
  #   Host github.com/other-account
  #     HostName github.com
  #     IdentityFile ~/.ssh/id_ed25519_other-account
  #
  # With this configuration, the first and second accounts can be accessed
  # using the following commands, respectively:
  #
  #   ssh -T git@github.com
  #   ssh -T git@github.com/other-account
  #
  # Usage in git is similar, just substitite the actual hostname for the alias:
  #
  #   git clone git@github.com/other-account:NixOS/nix.git
  #
  # (Some sources have described also needing to enable `IdentitiesOnly` to get
  # this to work, which may be a good place to start if something breaks.)
  #
  # Another approach is to rely on key lookup in the ssh agent. In principle,
  # configuring `IdentityFile`s isn't necessary if all keys have already been
  # added to the agent; ssh will try each key in turn (in `ssh-add -l` order)
  # until one of them succeeds. The trick, then, is to make sure the desired
  # key is listed before any other keys that are valid for the host. Keys can
  # be reordered by removing certain keys (`ssh-add -d`) and re-adding them to
  # the bottom of the list. This works in a pinch, but it's really cumbersome
  # if needed frequently.
  #
  # Yet another approach (also not as convenient) is to configure ssh on the
  # fly. For example,
  #
  #   ssh -o "IdentitiesOnly=yes" -i ~/.ssh/id_ed25519 -T git@github.com
  #
  # For git commands, set the GIT_SSH_COMMAND environment variable:
  #
  #   GIT_SSH_COMMAND='ssh -o "IdentitiesOnly=yes" -i ~/.ssh/id_ed25519' \
  #       git clone git@github.com:NixOS/nix.git
  #

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

  programs.git = {
    enable = true;
    extraConfig = {
      pull = {
        rebase = false;
      };
    };
    ignores = [
      ".stuff"
    ];
  };

  programs.readline = {
    enable = true;
    variables = {
      editing-mode = "vi";
    };
  };
}

# TODO: completions for cargo?
