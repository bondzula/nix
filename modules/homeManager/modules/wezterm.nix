{ pkgs, lib, config, ... }:

{
  options = {
    wezterm.enable = lib.mkEnableOption "Enables Wezterm Module";
  };

  config = lib.mkIf config.wezterm.enable {
    home.packages = lib.mkIf (!pkgs.stdenv.isDarwin) (with pkgs; [ wezterm ]);

    xdg.configFile."wezterm/wezterm.lua" = {
      source = ../../../dotfiles/wezterm/wezterm.lua;
    };
  };
}
