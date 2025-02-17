{
  description = "nvnix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, self, nixpkgs, stylix, ... }@inputs: {
    nixosConfigurations.x240ofdoom = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./hosts/x240ofdoom/configuration.nix
        stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
