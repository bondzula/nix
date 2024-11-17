{ pkgs, lib, config, ... }:

{
  options = {
    nushell.enable = lib.mkEnableOption "Enables NuShell Module";
  };

  config = lib.mkIf config.nushell.enable {
    programs.nushell = {
      enable = true;

      # NOTE: While those EVN varaibles do work, this is not a correct setup, plus i dont thing it would be compatable with other systems (Windows, Linux)
      extraConfig = ''
        # Load environment variables from login shell
        def --env load_nix_env [] {
          let path_entries = ($env.PATH | split row (char esep))
          let system_paths = [
            # NixOS system paths
            "/run/current-system/sw/bin"
            "/nix/var/nix/profiles/default/bin"
            # Nix user profile
            $"($env.HOME)/.nix-profile/bin"
            # Homebrew path
            "/opt/homebrew/bin"
            $"/etc/profiles/per-user/($env.USER)/bin"
          ]

          # Combine and deduplicate paths
          let new_path = ($path_entries | prepend $system_paths | uniq)
          $env.PATH = ($new_path | str join (char esep))

          # Load NIX_PATH
          $env.NIX_PATH = $'($env.HOME)/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/($env.USER)/channels'

          # Set other important Nix variables
          $env.NIX_PROFILES = "/nix/var/nix/profiles/default $env.HOME/.nix-profile"

          # If you're using NixOS, you might also want:
          # $env.NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"

          # Set up Homebrew if it exists
          if ($"/opt/homebrew/bin/brew" | path exists) {
            $env.HOMEBREW_PREFIX = "/opt/homebrew"
            $env.HOMEBREW_CELLAR = "/opt/homebrew/Cellar"
            $env.HOMEBREW_REPOSITORY = "/opt/homebrew"
          }
        }

        # Call the function to load Nix environment
        load_nix_env
      '';
    };
  };
}
