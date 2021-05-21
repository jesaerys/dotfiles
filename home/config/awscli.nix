{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.awscli
  ];

  programs.zsh.initExtra = ''
    autoload bashcompinit && bashcompinit
    complete -C $profile/bin/aws_completer aws
  '';
}
