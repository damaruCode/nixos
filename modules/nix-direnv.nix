{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nix-direnv.enable = lib.mkEnableOption "enables nix-direnv";
  };

  config = lib.mkIf config.nix-direnv.enable {
    environment.systemPackages = with pkgs; [
      nix-direnv
    ];
  };
}
