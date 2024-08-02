{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
  
  environment.systemPackages = with pkgs; [
    nvd
    nix-output-monitor
  ];
}
