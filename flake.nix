{
  description = "NixOS with Hyprland + Omarchy Components";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      
      nixos-hypr-wk = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/work/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.anon = import ./home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };

      nixos-rig = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # lanzaboote.nixosModules.lanzaboote
          ./hosts/home_desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.anon = import ./home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
