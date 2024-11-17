{ lib, config, ... }:

{
  options = {
    starship.enable = lib.mkEnableOption   "Enables Starship Prompot";
  };

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        # Disable AWS module
        aws = { disabled = true; };

        # Enable nix_shell
        nix_shell = {
          symbol = "❄️";
          format = "via [$symbol $state](bold blue)";
        };

        # Disable the container indicator
        container = { disabled = true; };
      };
    };
  };
}
