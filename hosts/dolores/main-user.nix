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
        ghostty
        yt-dlp
        bat
        bitwarden
        vscode
        qemu
        virt-manager
        brave
        btop
        clang
        direnv
        doas
        docker
        eza
        fd
        file
        flatpak
        fprintd
        fzf
        git
        gnumake
        hyprland
        hyprlock
        hyprpaper
        hyprshot
        kitty
        lazygit
        mpv
        neovim
        nerdfetch
        networkmanagerapplet
        nodejs_23
        pavucontrol
        pcmanfm
        pipx
        pstree
        python3
        python311Packages.pip
        pyright
        uv
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
