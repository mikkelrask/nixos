{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dolores"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "da_DK.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "dk";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable sound.
  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    hack-font
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "DroidSansMono" ]; })
  ];

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Auto Update
  system.autoUpgrade = {
    enable = true;
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
    };
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mr = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      gnome.gnome-software
      flatpak
      trayscale
      ncmpcpp
      mpv
      ranger
      bitwarden-desktop
      stow
      tmux
      neofetch
      doas
      kitty
      git
      swaynotificationcenter
      fd
      eza
      bat
      steam
      heroic
      kitty
      hyprland
      hyprpaper
      hyprlock
      sxiv
      wofi
      nodejs_22
      yarn
      cava
      waybar
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     pstree
     zsh
     neovim
     git
     fzf
     wget
     pavucontrol
     pcmanfm
     unclutter
     pfetch-rs
     python3
     python311Packages.pip 
     pipx
     gnumake
     docker
     unzip
     btop
     plexamp
     clang
     ripgrep
     vscode
     (vscode-with-extensions.override {
       vscodeExtensions = with vscode-extensions; [
         bbenoist.nix
         ms-python.python
         ms-azuretools.vscode-docker
         ms-vscode-remote.remote-ssh
       ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
         {
           name = "remote-ssh-edit";
           publisher = "ms-vscode-remote";
           version = "0.47.2";
           sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
         }
       ];
     })
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Tailscale
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  # Docker
  virtualisation.docker.enable = true;

  # DOAS 
  security.doas.enable = true;
  security.sudo.enable = true;
  security.doas.extraRules = [{
   users = ["mr"];
   # Optional, retains environment variables while running commands 
   # e.g. retains your NIX_PATH when applying your config
   keepEnv = true; 
   persist = true;  # Optional, only require password verification a single time
  }];

  programs.zsh.enable = true; 

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.hyprland = {
    enable = true;
  };

  system.copySystemConfiguration = true;

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?


}
# Test
