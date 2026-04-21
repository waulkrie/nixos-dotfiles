{ config, pkgs, lib, ... }:

{
  # Neovim with LazyVim dependencies
  home.packages = with pkgs; [
    # Neovim itself
    neovim

    # Tools required for Telescope
    ripgrep
    fd
    fzf

    # Language Servers (LSPs)
    lua-language-server
    nil                    # Nix LSP
    nixpkgs-fmt           # Nix formatter
    pyright               # Python LSP
    typescript-language-server
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

  # LazyVim config is managed via symlink in home.nix
  # Aliases are set in bash config
}
