return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--compile-commands-dir=build", -- relative to project root
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--query-driver=/**/g++*,/**/c++*,/nix/store/*-gcc*/bin/*g++*", -- crucial for NixOS std headers
          },
        },
      },
    },
  },
}
