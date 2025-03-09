# nixos config

Very basic, but at the same time, very personal config - wouldn't use it for anything other than maybe inspiration.


## Packages
Installs `hyprland`, -paper, -lock, -shot, `brave`, `ghostty`, `neovim`, `lazygit`, `fzf`, `btop`, `eza`, `fd`, `bat`, `doas`, `direnv`, `bitwarden`, `discord`, `slack` and a bunch more programming language stuff, like language servers and such, while I have started to migrate that to independant nix-shell's on a per project basis, to keep the config cleaner and more manageable.

Personal packages are in  hosts/dolores/main-user.nix , while the more "system-y" packages like the desktop and such are in `hosts/dolores/configuration.nix` and hyprland is configured in `hosts/dolores/home.nix`.
