{ inputs, pkgs, wayland, config, stylix, lib, ... }:

let
  homeDir = "/home/mr";
  wallpaperPath = "/home/mr/Pictures/wallpapers/wallpapers/abstract/fluid-art.jpg";
  waybar_conf_dir = "${homeDir}/.config/waybar/";
  launcher = "wofi --show drun --show-icons --allow-images --allow-images --allow-markup --style ./wofi.css";
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    hyprpaper & 
    waybar -c ${waybar_conf_dir}/config -s ${waybar_conf_dir}/style.css &
    ${pkgs.trayscale}/bin/trayscale --hide-window &
    ${pkgs.picom}/bin/picom -b &
  '';
in

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mr";
  home.homeDirectory = "/home/mr";
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "ALT";
      "$terminal" = "/home/mr/.local/bin/ghostty";
      "$browser" = "brave --enable-features=TouchpadOverscrollHistoryNavigation";
      "$filemanager" = "pcmanfm";
      "$menu" = "${launcher}";

      monitor = "eDP-1,1920x1080@60,0x0,1";

      exec-once = ''${startupScript}/bin/start'';

      general = {
        allow_tearing = false;
        resize_on_border = true;
        extend_border_grab_area = 20;
      };

      input = {
        kb_layout = "dk";
        kb_options = "caps:swapescape";
        follow_mouse = "1";
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
          scroll_factor = 0.8;
        };
      };

      gestures = {
        workspace_swipe = true;
      };
      
      decoration = {
        rounding = 12;
        inactive_opacity = 0.8;
        shadow = {
          enabled = true;
        };
        blur = {
          enabled = true;
          size = 20;
      	};
      };
      
      misc = {
        disable_hyprland_logo = true;	
        disable_splash_rendering = true;
        font_family = "monospace";
      };

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        "$mod, T, exec, $filemanager"
        "$mod, RETURN, exec, $terminal"
        "$mod, D, exec, $menu"
        "$mod, E, exec, wofi-emoji"
        "CTRL $mod, L, exec, hyprlock"
        "$mod, F, fullscreen"
        "$mod SHIFT, X, exit"
        "$mod SHIFT, Q, killactive"
        "$mod, W, exec, $browser"
        "$mod SHIFT, C, togglefloating"
        "CTRL, ESCAPE, exec, wezterm start btop"
        ", PRINT, exec, flameshot"

        # Media keys
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@" # Mute
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+" # Up 
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-" # Down

        # Windows and Focus
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, u"
        "$mod, k, movefocus, d"
        "$mod, l, movefocus, r"

        # Swap windos
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, j, movewindow, u"
        "$mod SHIFT, k, movewindow, d"
        "$mod SHIFT, l, movewindow, r"
        
        # Cycle last workspace
        "$mod, TAB, workspace, previous"

        # Toggle Waybar
        "$mod, q, exec, pkill -SIGUSR1 waybar"

      ]
      ++(
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
      );
    };
  };
  wayland.windowManager.hyprland.extraConfig = ''
    # window resize
    bind = $mod, r, submap, resize
    submap = resize
    binde = , l, resizeactive, 10 0
    binde = , h, resizeactive, -10 0
    binde = , k, resizeactive, 0 -10
    binde = , j, resizeactive, 0 10
    bind = , escape, submap, reset
    submap = reset
  '';
}

