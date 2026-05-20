{ config, pkgs, ... }:

{
  programs.zsh.initExtraBeforeCompInit = ''
    fpath+=(~/.local/share/zsh/site-functions)
  '';

  home.file.".local/share/zsh/site-functions/_docker".source =
    "/Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion";

  home.file.".local/share/zsh/site-functions/_docker-compose".source =
    "/Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion";
}
