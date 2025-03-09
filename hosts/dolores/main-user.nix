{ lib, config, pkgs, ... }:

let 
  cfg = config.main-user;
in

{
  options.main-user = {
    enable
      = lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      default = "mr";
      description = ''
        username
      '';
    };
  };
  android_sdk.accept_license = true;


  config = lib.mkIf cfg.enable{
    users.users.${cfg.userName} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "toor";
      extraGroups = [ "dialout" "wheel" "docker" ];

      packages = with pkgs; [
        android-tools
        android-studio-full
        android-studio-tools
        android-udev-rules
        appimage-run
        archiver
        bat
        bitwarden
        qemu
        virt-manager
        brave
        btop
        clang
        code-cursor
        direnv
        discord
        doas
        docker
        eza
        fd
        file
        flatpak
        fprintd
        fzf
        git
        gnome-boxes
        gnome-software
        gnumake
        hyprland
        hyprlock
        hyprpaper
        hyprshot
        kitty
        lazygit
        libarchive-qt
        libfprint
        libfprint-2-tod1-vfs0090
        moonlight-qt
        mpv
        neovim
        nerdfetch
        networkmanagerapplet
        nodejs_22
        pavucontrol
        pcmanfm
        pipx
        plexamp
        pstree
        python3
        python311Packages.pip
        ranger
        ripgrep
        ryujinx
        sshfs
        steam
        stow
        swaynotificationcenter
        sxiv
        tmux
        trayscale
        typescript-language-server
        unzip
        usbutils
        vim
        vscode
        waybar
        wf-recorder
        wget
        wl-screenrec
        wofi
        wofi-emoji
        zsh
      ];
    };
  };
}
