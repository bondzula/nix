{ pkgs, ... }:

{
  users.users.stefan = {
    name = "stefan";
    home = "/Users/stefan";
  };

  environment = {
    systemPath = [
      "/opt/homebrew/bin"
    ];

    systemPackages = [
      pkgs.git
      pkgs.zellij
    ];
  };

  homebrew = {
    enable = true;

    brews = [
      "mas"
    ];

    casks = [
      "1password"
      "aldente"
      "chatgpt"
      "cleanshot"
      "firefox"
      "monitorcontrol"
      "obsidian"
      "raycast"
      "roon"
      "skype"
      "wezterm"
      "zen-browser"
      "visual-studio-code"
    ];

    masApps = {
      "Infuse • Video Player" = 1136220934;
      "Tailscale" = 1475387142;
      "TickTick:To-Do List, Calendar" = 966085870;
    };
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      show-recents = false;
      persistent-apps = [
        "/Applications/Zen Browser.app"
        "/Applications/WezTerm.app"
        "/Applications/Obsidian.app"
        "/Applications/TickTick.app"
        "/Applications/ChatGPT.app"
        "/Applications/1Password.app"
        "/Applications/Roon.app"
        "/Applications/Skype.app"
      ];
    };

    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      InitialKeyRepeat = 15;
      KeyRepeat = 1;
      "com.apple.mouse.tapBehavior" = 1;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
    };

    WindowManager = {
      StandardHideDesktopIcons = true;
      StandardHideWidgets = true;
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
