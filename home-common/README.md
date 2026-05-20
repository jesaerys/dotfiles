# home-common

This is a flake containing common Home Manager configuration for all machines.

It's designed to be used as a module for flake-based Home Manager setups.

## Setting up a new machine

- Install Nix, then install Home Manager as described in the manual
  (https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone).
  This will create `home.nix` and `flake.nix` files in `~/.config/home-manager`.

- Update `flake.nix` to include `home-common` as an input:

  ```
  inputs = {
    # ...
    home-common = {
      # Use any flake reference for the URL (github, local path, etc.);
      # see https://nix.dev/manual/nix/2.28/command-ref/new-cli/nix3-flake.html#flake-references
      url = "github:jesaerys/dotfiles?dir=home-common";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  ```

  and in the `outputs` section, include the `home-common`'s configuration to the
  list of modules in addition to `home.nix`:

  ```
  modules = [
    # Order matters!
    home-common.homeManagerModules.default
    ./home.nix
  ];
  ```

- Make sure `home.nix` includes the following machine-specific settings (they
  aren't provided by this flake):
  - `home.stateVersion`
  - `home.username`
  - `home.homeDirectory`

- Use `home-manager` as usual (edit `home.nix`, run `home-manager switch`, etc.)

## Updating

To pull in changes from this flake,

```
nix flake update home-common
home-manager switch
```
