{ config, lib, ... }:

{
  imports = [
    ./modules/atuin.nix
    ./modules/btop.nix
    ./modules/eza.nix
    ./modules/fd.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/nvim.nix
    ./modules/ripgrep.nix
    ./modules/starship.nix
    ./modules/zellij.nix
    ./modules/zoxide.nix
    ./modules/zsh.nix
    ./modules/nushell.nix
    ./modules/direnv.nix
  ];

  zsh.enable = lib.mkDefault true;
  direnv.enable = lib.mkDefault true;
}
