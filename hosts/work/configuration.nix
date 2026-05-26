# hosts/work/configuration.nix
# descrete settings per host
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../configuration.nix # Import shared config
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos-hypr-wk";

  # Standard boot (no Secure Boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NVIDIA proprietary driver (Quadro M4000)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
  hardware.graphics.enable = true;
}
