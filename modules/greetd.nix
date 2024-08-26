{ pkgs, lib, config, ... }:
{
  options = {
      greetd.enable = lib.mkEnableOption "enables greetd";
  };

  config = lib.mkIf config.greetd.enable {
    services.greetd = {
      enable = true;
      vt = 2;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd Hyprland";
      };
    };
  };
}
