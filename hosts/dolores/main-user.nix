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


  config = lib.mkIf cfg.enable{
    users.users.${cfg.userName} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "toor";
      extraGroups = [ "dialout" "wheel" "docker" ];

      packages = with pkgs; [
        android-tools
        archiver
        bat
        bitwarden
        brave
        btop
        clang
        direnv
        discord
        doas
        docker
        eza
        fd
        figma-linux
        file
        flatpak
        fprintd
        fzf
        git
        gnome-boxes
        gnome-software
        gnumake
        google-chrome
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
        mullvad
        mullvad-vpn
        neovim
        nerdfetch
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
        yarn
        zed-editor
        zsh
      ];
    };
  };
}
