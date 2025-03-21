{ pkgs, lib, config, ... }:

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
      pkgs.rsync
      pkgs.ansible
      pkgs.tealdeer
      pkgs.wakeonlan
      pkgs.wget
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.mysql84
      pkgs.lazygit
      pkgs.lazydocker
      # pkgs.zig
      pkgs.cmake
      pkgs.markdownlint-cli2
      pkgs.nodePackages.prettier
      pkgs.languagetool-rust
      pkgs.lazygit
      pkgs.nodejs_20
      pkgs.pnpm
      pkgs.go
      pkgs.magic-wormhole
      pkgs.bun
      pkgs.uv
    ];
  };

  homebrew = {
    enable = false;

    brews = [
      "mas"
      "exercism"
    ];

    casks = [
      "1password"
      "aldente"
      "cleanshot"
      "docker"
      "firefox"
      "monitorcontrol"
      "obsidian"
      "raycast"
      "skype"
      "zen-browser"
      "google-chrome"
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

  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      show-recents = false;
      persistent-apps = [
        "/Applications/Zen Browser.app"
        "/Applications/Ghostty.app"
        "/Applications/Obsidian.app"
        "/Applications/TickTick.app"
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

  imports = [
    ../../modules/darwin/default.nix
  ];
}
