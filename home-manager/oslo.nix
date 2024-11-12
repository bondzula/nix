{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.

    # User's information
    username = "stefan";
    homeDirectory = "/Users/stefan";

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      awscli2
      terraform
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
    ./modules/wezterm.nix
    ./modules/zellij.nix
    ./modules/zoxide.nix
    ./modules/zsh.nix
  ];
}
