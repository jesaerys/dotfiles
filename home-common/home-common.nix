{ config, pkgs, lib, ... }:

let
  gitCloneAs = pkgs.callPackage ./pkgs/git-clone-as.nix {};

  gitClonePersonal = pkgs.writeShellScriptBin "git-clone-personal" ''
    git-clone-as jesaerys simonj0@icloud.com ~/.ssh/id_ed25519.personal "$@"
  '';
in
{
  programs.home-manager.enable = true;
  news.display = "silent";

  home.packages = [
    gitCloneAs
    gitClonePersonal
    pkgs.jq
    pkgs.shellcheck
  ];

  home.shellAliases = {
    ll = "ls -lF";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Using zsh because it's the default on macos.
  programs.zsh = {
    enable = true;

    initContent = lib.mkMerge [
      (lib.mkOrder 1000 ''
        # Repeat "❯" according to SHLVL:
        PROMPT_CHAR_REPEAT=$SHLVL
        # SHLVL=3 when vscode is launched from Apple Terminal using `code`.
        # To adjust for this, subtract 2 from if TERM_SESSION_ID is set
        # (a sign that vscode was launched from Apple Terminal):
        [[ "$TERM_PROGRAM" == "vscode" && -n "$TERM_SESSION_ID" ]] && PROMPT_CHAR_REPEAT=$((PROMPT_CHAR_REPEAT - 2))
        (( PROMPT_CHAR_REPEAT < 1 )) && PROMPT_CHAR_REPEAT=1  # Must be gte 1
        PROMPT_STRING=''${(l:$PROMPT_CHAR_REPEAT::❯:)}  # zsh left-pad expansion
        export PS1="%B%F{blue}%1~ "''${PROMPT_STRING}" %f%b"
      '')

      (lib.mkAfter ''
        # Ensure Nix profile wins command resolution:
        path=("$HOME/.nix-profile/bin" $path)
      '')
    ];

    setOptions = [
      # Don't let live sessions share history in real time, but still have every
      # session incrementally append to the same history file. Use `fc -R` to
      # read the latest history:
      "NO_SHARE_HISTORY"
      "INC_APPEND_HISTORY"

      "INTERACTIVE_COMMENTS"
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      core = {
        editor = "code --wait";
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
}
