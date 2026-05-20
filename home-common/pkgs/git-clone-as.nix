# ## What
#
# Here is a helper script to clone and configure git repos with a specific
# user.name, user.email, and SSH key.
#
# ## Why
#
# This makes it easier to use different identities for different git repos,
# usually personal stuff vs work stuff. It works by configuring git to use a
# custom ssh command that specifies the SSH key to use for the repo, and also
# sets the user.name and user.email for commits.
#
# ## Alternative
#
# Another solution that's commonly used is to write an `~/.ssh/config` file
# with one host entry per identity, something like this:
#
# ```
# Host github.com
#   AddKeysToAgent yes
#   UseKeychain yes
#   IdentityFile ~/.ssh/id_ed25519.work
#
# Host github-personal
#   HostName github.com
#   User git
#   AddKeysToAgent yes
#   UseKeychain yes
#   IdentityFile ~/.ssh/id_ed25519.personal
# ```
#
# A regular `git clone git@github.com:foo/bar.git` would then cause git to use
# the work identity, whereas `git clone git@github-personal:foo/bar.git` would
# cause git to use the personal identity. Having to change the hostname after
# pasting the clone URL in the latter case is a mild annoyance. Also, this
# solution doesn't address configuration, so user.name and user.email still
# need to be set manually in each repo.
#
# In contrast, the script defined here is nicer because it takes care of both
# the SSH key and the user configuration in one shot.
#
# ## Tips
#
# - Create a shell alias that binds the first three arguments, e.g.,
#   `git-clone-personal="git-clone-as alf alf@email.com ~/.ssh/id_ed25519.personal"
#   and use it like this: `git-clone-personal git@github.com:foo/bar.git`.
#
# - Even better, create a shell script to the same effect, e.g., a script
#   named `git-clone-personal` containing a single line
#   `git-clone-as alf alf@email.com ~/.ssh/id_ed25519.personal "$@"`.
#   Then, take advantage of git's subcommand system to invoke it like this:
#   `git clone-personal git@github.com:foo/bar.git`.

{ pkgs }:

pkgs.writeShellApplication {
  name = "git-clone-as";
  runtimeInputs = [ pkgs.git ];
  text = ''
    usage () {
      cat <<'EOF'
    Usage: git-clone-as <user-name> <user-email> <identity-file> ...

    Clone and configure a git repository with the specified user.name,
    user.email, and SSH identity file.

    Example:
      git-clone-as alf alf@email.com ~/.ssh/id_ed25519 git@github.com:foo/bar.git

    Arguments:
      <user-name>       The value to set for git config user.name
      <user-email>      The value to set for git config user.email
      <identity-file>   The SSH private key file to use for this repository
      ...               All remaining arguments forwarded to git clone

    Options:
      -h, --help   Show this help text and exit.
    EOF
    }

    case "$1" in
      -h|--help)
        usage
        exit 0
        ;;
    esac

    if [ "$#" -lt 3 ]; then
      echo "Error: expected at least 3 arguments." >&2
      usage
      exit 2
    fi

    user_name="$1"
    shift
    user_email="$1"
    shift
    identity_file="$1"
    shift

    if [ ! -f "$identity_file" ]; then
      echo "Error: SSH identity file not found: $identity_file" >&2
      exit 1
    fi

    # Tell ssh to use the specified identity file:
    ssh_cmd="ssh -i $identity_file"
    
    # Don't try other keys if the specified one doesn't work:
    ssh_cmd+=" -o IdentitiesOnly=yes"

    # Add the key to the ssh agent so it can be used again without needing to
    # re-enter the passphrase:
    ssh_cmd+=" -o AddKeysToAgent=yes"

    # Use the macOS keychain to store the passphrase (if any) for the key:
    ssh_cmd+=" -o UseKeychain=yes"

    git clone \
      -c "core.sshCommand=$ssh_cmd" \
      -c "user.name=$user_name" \
      -c "user.email=$user_email" \
      "$@"
  '';
}
