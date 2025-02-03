{ config, lib, pkgs, inputs, stylix, ... }:

let 
  homeDir = "/home/mr";
in 
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./main-user.nix
      inputs.home-manager.nixosModules.default
    ];

  
  programs.steam.enable = true;

  nixpkgs.overlays = [ # WORKAROUND for 7zz
      (final: prev: {
        _7zz = prev._7zz.override { useUasm = true; };
      })
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dolores"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  time.timeZone = "Europe/Copenhagen";

  services.udev.packages = [ 
    pkgs.platformio-core
    pkgs.openocd
  ];

  nix.nixPath = [ "/home/mr/.nixos" ];

  # Bluetooth?
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "dk";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # RICE RICE BABY
  stylix.enable = true;
  stylix.image = ./yosimite.png;
  stylix.autoEnable = true;
  stylix.polarity = "dark";
  stylix.fonts = {
    monospace = {
      package = pkgs.fantasque-sans-mono;
      name = "FantasqueSansMono";
    };
    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";

  # Enable sound.
  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.noto
    noto-fonts-cjk-sans
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.fantasque-sans-mono
    fira-code-symbols
 ];

  programs.nh = { # Nix Helper
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/mr/NIXOSSS";
  };
  
  # Home manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "mr" = import ./home.nix;
    };
    backupFileExtension = "backup";
  };

  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.fprintd.enable = true;

  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Auto Update
  system.autoUpgrade = {
    enable = true;
  };


  # Garbage collection
  #nix.gc = {
  #  automatic = true;
  #  dates = "weekly";
  #  options = "--delete-older-than 7d";
  #  };
  
  # Increase buffer size
  nix.settings.download-buffer-size = "256M"; # Increase size as needed

  nix.settings.trusted-users = [
    "root"
    "@wheel"
    "mr"
  ];
  nix.settings.allowed-users = [
    "root"
    "@wheel"
    "mr"
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  main-user.enable = true;
  main-user.userName = "mr";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     cargo
     clang
     code-minimap
     file
     fprintd  
     fzf
     git
     gnumake
     go
     jq
     jre
     julia
     libfprint
     libfprint-2-tod1-vfs0090
     lua
     lua-language-server
     lua51Packages.luarocks-nix
     lua51Packages.luasnip
     php
     php83Packages.composer
     pulseaudioFull
     tokyonight-gtk-theme
     tree-sitter
     wl-clipboard-rs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];

  # Tailscale
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  # Docker
  virtualisation.docker.enable = true;

  # Virtualization
  virtualisation.libvirtd.enable = true;
  # if you use libvirtd on a desktop environment

  programs.virt-manager.enable = true; # can be used to manage non-local hosts as well

  # DOAS 
  security.doas.enable = true;
  security.sudo.enable = true;
  security.doas.extraRules = [{
   users = ["mr"];
   keepEnv = true; 
   persist = true;
  }];

  programs.zsh.enable = true; 

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  system.stateVersion = "24.05"; # Did you read the comment?

  # flake.nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
