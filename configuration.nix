{ pkgs, inputs, ... }:
{
  imports = [
    ./features/nvidia.nix
    # ./features/vm.nix
    ./features/steam.nix
    # ./features/via.nix
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "damaruNixOS";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
  };

  services.xserver.enable = false;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "altgr-intl";

  services.greetd = {
    enable = true;
    vt = 2;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd Hyprland";
    };
  };

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
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  security.pam.services.swaylock = { };

  users.users.damaru = {
    isNormalUser = true;
    extraGroups = [
      "qemu-libvirtd"
      "libvirtd"
      "wheel"
      "video"
      "audio"
      "disk"
      "networkmanager"
      "vboxusers"
      "user-with-access-to-virtualbox"
    ];
  };

  users.defaultUserShell = pkgs.zsh;

  services.openssh.enable = true;

  networking.firewall.enable = true;

  system.stateVersion = "23.11";
}
