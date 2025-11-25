# hosts/work/configuration.nix
# descrete settings per host
{ config, lib, pkgs, ... }:

{
  imports = [
    ../../configuration.nix  # Import shared config
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-rig";

  # Desktop-specific: Secure Boot with lanzaboote
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Desktop-specific packages (if any)
  # environment.systemPackages = with pkgs; [ ... ];
}
