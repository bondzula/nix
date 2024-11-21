{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      fd
      ripgrep

      # Build tools
      pkg-config
      gcc
      cmake
      gnumake
      ninja

      unzip
      wget
      tree-sitter

      # Node
      nodejs
      nodePackages.npm

      # Lua
      lua5_4_compat
      lua54Packages.luarocks

      # PHP
      php82
      php82Packages.composer

      # Rust
      cargo
      rustc

      # Go
      go

      # Nix
      deadnix
      nixfmt-rfc-style
      statix

      hadolint
      commitlint
      dotenv-linter
    ];
  };

  # Set default editor to be nvim
  home.sessionVariables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    VISUAL = "${pkgs.neovim}/bin/nvim";
    SUDO_EDITOR = "${pkgs.neovim}/bin/nvim";
    MANPAGER="nvim +Man!";
  };
}
