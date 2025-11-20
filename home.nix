{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  
  # Directories to symlink to .config
  configs = {
    hypr = "hypr";
    waybar = "waybar";
    foot = "foot";
    nvim = "nvim";
    kitty = "kitty";
  };
in
{
  home.username = "anon";
#  home.homeDirectory = "/home/anon";
  home.stateVersion = "25.05";

  # Import modules
  imports = [
    ./modules/neovim.nix
  ];

  # Home packages
  home.packages = with pkgs; [
    # CLI tools
    ripgrep
    fd
    fzf
    bat
    eza
    btop
    
    # Development
    gcc
    nodejs
    python3
    
    # Nix utilities
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-cli
      ];
      text = ''
        selected=$(nix search nixpkgs "$1" | fzf)
        if [ -n "$selected" ]; then
          pkg=$(echo "$selected" | awk '{print $1}' | sed 's/legacyPackages.x86_64-linux.//')
          nix shell nixpkgs#"$pkg"
        fi
      '';
    })
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "waulkrie";
    userEmail = "aobare@gmail.com";
  };

  # Bash configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
      ll = "eza -la";
      ls = "eza";
      cat = "bat";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-hypr-wk";
    };
    
    # Auto-start Hyprland on login (TTY1)
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec Hyprland
      fi
    '';
  };

  # Symlink config directories (Tony's approach)
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  # GTK theme for Nautilus and other GTK apps
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
