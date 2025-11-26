{ pkgs, inputs, ... }:
{
  # custom module options
  nix-helpers.enable = true;
  zsh.enable = true;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
  };

  services.xserver.enable = false;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "altgr-intl";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gh
    git
    vim
    zip
    wget
    cups
    tree
    unzip
    git-lfs
    neofetch

    nerd-fonts.caskaydia-cove

    inputs.nixvim.packages.x86_64-linux.default
  ];

  programs.zsh.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "25.05";
}
