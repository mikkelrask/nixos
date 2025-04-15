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
        appimage-run
        bat
        bitwarden
        btop
        clang
        direnv
        doas
        docker
        eza
        fd
        yq
        file
        flatpak
        fprintd
        fzf
        ghostty
        git
        gnumake
        hyprland
        hyprlock
        hyprpaper
        hyprshot
        lazygit
        moonlight-qt
        mpv
        neovim
        nerdfetch
        networkmanagerapplet
        nodejs_23
        pavucontrol
        pcmanfm
        pstree
        pyright
        python3
        python311Packages.pip
        qemu
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
        unzip
        usbutils
        uv
        vim
        virt-manager
        vscode
        waybar
        wf-recorder
        wget
        wl-screenrec
        wofi
        wofi-emoji
        yt-dlp
        zsh
      ];
    };
  };
}
