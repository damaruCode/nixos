{ pkgs, ... }:
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
  services.udev.packages = [ via-rules ];
}
