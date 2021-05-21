{ pkgs, home_manager_config }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    niv
    home-manager
  ];

  shellHook = ''
    export HOME_MANAGER_CONFIG="${home_manager_config}"
  '';
}
