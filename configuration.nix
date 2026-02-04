# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# SHARED ACCROSS ALL HOSTS
{
  config,
  lib,
  pkgs,
  ...
}: {
  time.timeZone = "America/Chicago";

  # Services
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.displayManager.ly.enable = true;
  systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  # Security
  security.pam.services.hyprlock = {};
  security.polkit.enable = true;
  networking.firewall.checkReversePath = false;
  networking.networkmanager.enable = true;
  powerManagement.enable = true;

  nix.settings.trusted-users = ["root" "anon"];

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock.enable = true;

  # User config
  users.users.anon = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "lp" "scanner" "storage"];
    packages = with pkgs; [tree];
  };

  # Common programs
  programs.firefox.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      glib
      libgcc
    ];
  };
  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    # hypr stuff
    hyprpolkitagent
    waybar
    hyprshot
    hyprlauncher
    quickshell

    # development
    alejandra #nix format
    nixd
    devenv

    # utils
    nautilus
    vim
    wget
    curl
    btop
    fastfetch
    wireguard-tools
    protonvpn-gui
    traceroute
    google-chrome

    # terminals
    kitty
    ghostty
    foot

    # notification manager
    mako

    # sound
    pipewire
    wireplumber
  ];

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.zed-mono
    powerline-fonts
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";
}
