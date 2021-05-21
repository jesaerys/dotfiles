import ./home/shell.nix {
  pkgs = import (import ./nix/sources.nix).nixpkgs {};
  home_manager_config = "./home.nix";
}
