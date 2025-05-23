{ pkgs, lib, config, ... }:

{
  options = {
    direnv.enable = lib.mkEnableOption "enables direnv";
  };

  config = lib.mkIf config.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      config = {
        global = {
          hide_env_diff = true;
        };
      };
    };
  };
}
