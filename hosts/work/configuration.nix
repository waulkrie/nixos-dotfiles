# hosts/work/configuration.nix
# descrete settings per host
{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix  # Import shared config
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-hypr-wk";

  # Work-specific: autologin
  services.getty.autologinUser = "anon";

  # Standard boot (no Secure Boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
