{
  pkgs,
  lib,
  config,
  ...
}:
let
  via-rules = pkgs.writeTextFile {
    name = "99-via.rules";
    text = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
    '';
    destination = "/etc/udev/rules.d/99-via.rules";
  };
in
{
  options = {
    via-rules.enable = lib.mkEnableOption "enables udev rules for via";
  };

  config = lib.mkIf config.via-rules.enable {
    services.udev.packages = [ via-rules ];
  };
}
