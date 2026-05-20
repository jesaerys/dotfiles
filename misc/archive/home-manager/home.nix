{ config, pkgs, ...}:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  imports = [
    ./home/config/common.nix
  ];

  programs.ssh = {
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  programs.git = {
    userName = "jesaerys";
    userEmail = "jacob.simones@gmail.com";
  };
}
