{ config, pkgs, ... }:

{
  home.sessionPath = [
    "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"
  ];
  # TODO: consider setting `"terminal.integrated.shellArgs": []` instead of
  # disabling `terminal.integrated.inheritEnv`; see
  # https://code.visualstudio.com/docs/editor/integrated-terminal#_why-are-there-duplicate-paths-in-the-terminals-path-environment-variable-andor-why-are-they-reversed
  #programs.zsh.initExtra = ''
  #  # Shells in vscode don't inherit USER when terminal.integrated.inheritEnv is false
  #  export USER=$(whoami)
  #'';

  # Symlink preferences file?
}
