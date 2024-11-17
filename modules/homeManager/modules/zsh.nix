{ pkgs, lib, config, ... }:

{
  options = {
    zsh.enable = lib.mkEnableOption "enables zsh home manager module";
  };

  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      defaultKeymap = "emacs";

      history = {
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        extended = true;
        ignoreDups = true;
        expireDuplicatesFirst = true;
      };

      shellAliases = {
        # Clean the home directory
        wget = "wget --hsts-file=$XDG_CACHE_HOME/wget_hsts";
      };

      initExtraFirst = ''
        # Check if nix profile exists, and if it does, load it
        if [ -e /home/bondzula/.nix-profile/etc/profile.d/nix.sh ]; then . /home/bondzula/.nix-profile/etc/profile.d/nix.sh; fi
      '';

      initExtra = ''
        # Setup NODE
        path+=('/home/bondzula/.npm-packages/bin')

        export NODE_PATH="~/.npm-packages/lib/node_modules"

        # Export path
        export PATH
      '';

      envExtra = ''
        export XDG_CACHE_HOME=~/.cache
      '';

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
          };
        }
        {
          name = "zsh-powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./../../../dotfiles/zsh;
          file = "p10k.zsh";
        }
      ];
    };
  };
}
