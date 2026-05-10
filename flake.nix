{
  description = "Modular Nix configuration for macOS and WSL2";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      username = "knsugiyama";
      # macOS configuration
      darwinSystem = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit username; };
        modules = [
          ./hosts/macos/default.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit username; };
            home-manager.users.${username} = import ./hosts/macos/home.nix;
          }
        ];
      };
      
      # WSL2 (Linux) configuration
      homeConfiguration = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit username; };
        modules = [ ./hosts/wsl2/home.nix ];
      };
    in {
      # For macOS: darwin-rebuild switch --flake .#macos
      darwinConfigurations.macos = darwinSystem;

      # For WSL2: home-manager switch --flake .#wsl2
      homeConfigurations.wsl2 = homeConfiguration;
    };
}
