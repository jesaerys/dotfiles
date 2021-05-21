{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.coreutils
  ];

  programs.zsh = {
    shellAliases = {
      ls = "ls -F";
      ll = "ls -l";
    };
  };
}
