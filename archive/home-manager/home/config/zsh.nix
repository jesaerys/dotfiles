{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";

    initExtraBeforeCompInit = ''
      # Basic emacs keys for insert mode
      bindkey -v '^F' forward-char
      bindkey -v '^B' backward-char
      bindkey -v '^E' end-of-line
      bindkey -v '^A' beginning-of-line
      bindkey -v '^N' down-line-or-history
      bindkey -v '^P' up-line-or-history
      bindkey -v '^?' backward-delete-char
      bindkey -v '^K' kill-line
      bindkey -v '^R' history-incremental-search-backward
      bindkey -v '^S' history-incremental-search-forward

      # Redefine up/down history commands to only look locally
      down-line-or-history() {
          zle set-local-history 1
          zle .down-line-or-history
          zle set-local-history 0
      }
      zle -N down-line-or-history
      up-line-or-history() {
          zle set-local-history 1
          zle .up-line-or-history
          zle set-local-history 0
      }
      zle -N up-line-or-history

      export KEYTIMEOUT=1  # Faster escape into command mode

      unsetopt flowcontrol  # Prevent terminal driver from ^S/^Q (see stty)

      setopt interactivecomments

      PS1='%B%F{4}%1~ ❯ %f%b'

      unalias run-help; autoload run-help
    '';

    shellAliases = {
      help = "run-help";
    };
  };
}
# HIST_IGNORE_ALL_DUPS
