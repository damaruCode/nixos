{ pkgs,... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # custom module options
  greetd.enable = true;
  nix-helpers.enable = true;
  via-rules.enable = true;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ace";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
  };

  services.xserver.enable = false;
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "altgr-intl";

  services.printing.enable = true;

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gh
    git
    vim
    wget
    cups
    tree
    unzip
    git-lfs
    neofetch
    home-manager
  ];

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;

  users.users.damaru = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
  };

  users.defaultUserShell = pkgs.zsh;

  services.openssh.enable = true;

  networking.firewall.enable = true;

  system.stateVersion = "23.11";
}
