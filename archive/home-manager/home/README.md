# home

Dotfiles system and personal configuration library based on [Home Manager].

The only prerequiste is [Nix]. Home Manager itself is provided in a Nix shell,
in which nixpkgs is pinned using [Niv] (also provided in the shell). This
approach is inspired by [home-manager-template].

To start a new dotfiles project in the current directory,

1. Clone or symlink this repo:
   ```shell
   git clone git@github.com:jesaerys/home.git
   ```

2. Create a Home Manager config file for this computer, importing any of the
   configurations included in this repo:
   ```shell
   cat <<EOF >home.nix
   { config, pkgs, ...}: {
     home.username = builtins.getEnv "USER";
     home.homeDirectory = builtins.getEnv "HOME";
     imports = [ ./home/config/common.nix ];
     # etc.
   }
   EOF
   ```

3. Use Niv to create `nix/sources.{json,nix}` and pin nixpkgs as needed, e.g.,
   ```shell
   nix-shell -p niv --run 'niv init; niv update nixpkgs -b nixpkgs-unstable'
   ```

4. Create a Nix shell file that runs the included `shell.nix` with the pinned
   nixpkgs and the Home Manager config file:
   ```shell
   cat <<EOF >shell.nix
   import ./home/shell.nix {
     pkgs = import (import ./nix/sources.nix).nixpkgs {};
     home_manager_config = "./home.nix";
   }
   EOF
   ```

   > ***Note:*** It's very important to make sure the value of
   > `home_manager_config` is a string. Without the quotes, the value would be
   > a path and Nix would add that file to the store, causing all imports in
   > the configuration files to break.

5. Finally, run `home-manager` in the Nix shell:
   ```shell
   nix-shell --run 'home-manager switch'
   ```

   All Home Manager commands can be run this way, even `home-manager
   uninstall`.

If Home Manager is providing a shell, make sure to make it the default, e.g.,
```shell
echo "$HOME/.nix-profile/bin/zsh" | sudo tee -a /etc/shells >/dev/null
chsh -u $USER -s $HOME/.nix-profile/bin/zsh
```


[Home Manager]: https://github.com/nix-community/home-manager
[home-manager-template]: https://github.com/ryantm/home-manager-template
[Niv]: https://github.com/nmattia/niv
[Nix]: https://nixos.org

