{
  config,
  lib,
  ...
}:
{
  options = {
    zsh.enable = lib.mkEnableOption "enables zsh";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      shellInit = ''
        # Function to switch and save the current path
        function cd() {
          builtin cd "$@";
          echo "$PWD" > ~/.cwd;
        }
        export cd
        alias cwd='cd "$(cat ~/.cwd)"'
        cwd
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
        theme = "nebirhos";
      };
      shellAliases = {

        # Nix
        updateos = "nh os switch ~/.config/nixos";
        updatehome = "nh home switch ~/.config/homemanager";
        cleanstore = "nh clean all --keep 3";

        # System
        open = "xdg-open";

      };
    };
  };
}
