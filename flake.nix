{
  description = "nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Function to run a command and trim the output
    runCommand = cmd: builtins.replaceStrings ["\n"] [""] (builtins.readFile (builtins.toFile "command-output" ''
      if command -v ${cmd} >/dev/null 2>&1; then
        ${cmd}
      else
        echo "unknown"
      fi
    ''));

    # Get username from $USER env var, fall back to `whoami` command if not set
    username = let
      userEnv = builtins.getEnv "USER";
      result = if userEnv != "" then userEnv else runCommand "whoami";
    in
      if result == "unknown"
      then throw "Failed to determine username. Please set the USER environment variable or ensure 'whoami' is available."
      else result;
    
    # Get hostname from $HOSTNAME env var, fall back to `hostname` command if not set
    hostname = let
      hostEnv = builtins.getEnv "HOSTNAME";
      result = if hostEnv != "" then hostEnv else runCommand "hostname";
    in
      if result == "unknown"
      then throw "Failed to determine hostname. Please set the HOSTNAME environment variable or ensure 'hostname' is available."
      else result;

    # Function to get the system
    getSystem = let
      system = builtins.currentSystem;
      supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    in
      if builtins.elem system supportedSystems
      then system
      else throw "Unsupported system: ${system}";

    # Helper function to generate system-specific configurations
    mkSystem = nixpkgs.lib.nixosSystem {
      system = getSystem;
      specialArgs = {inherit inputs outputs;};
      modules = [./nixos/configuration.nix];
    };

    # Helper function to generate home-manager configurations
    mkHome = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${getSystem};
      extraSpecialArgs = {inherit inputs outputs username;};
      modules = [./home-manager/home.nix];
    };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#hostname'
    nixosConfigurations = {
      ${hostname} = mkSystem;
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#username@hostname'
    homeConfigurations = {
      "${username}@${hostname}" = mkHome;
    };
  };
}
