{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
  };

  # Load the dotfile
  xdg.configFile."zellij/config.kdl" = {
    source = ../../../dotfiles/zellij/config.kdl;
  };
}
