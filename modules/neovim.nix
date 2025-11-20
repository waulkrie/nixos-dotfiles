{ config, pkgs, lib, ... }:

{
  # Neovim with LazyVim dependencies
  home.packages = with pkgs; [
    # Tools required for Telescope
    ripgrep
    fd
    fzf
    
    # Language Servers (LSPs)
    lua-language-server
    nil                    # Nix LSP
    nixpkgs-fmt           # Nix formatter
    pyright               # Python LSP
    nodePackages.typescript-language-server
    rust-analyzer
    
    # Formatters
    stylua                # Lua formatter
    black                 # Python formatter
    prettier              # JS/TS formatter
    
    # Other tools
    nodejs                # Required for many plugins
    gcc                   # C compiler for TreeSitter
    unzip                 # For Mason
    cargo                 # For Rust tools
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    
    # Note: LazyVim manages its own plugins
    # So we don't define plugins here - LazyVim handles that
    # You'll clone the LazyVim config to ~/nixos-dotfiles/config/nvim
  };
}
