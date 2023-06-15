{
  description = "OAM devshell";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, flake-utils, devshell, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell =
        let
          # Define the URL, version and sha256 hash
          vela-version = "v1.9.0";
          vela-sha256 = {
            # aarch64-linux = "<your-specific-hash-for-linux>";
            aarch64-darwin = "Rn19RLgv7ng8LyR+q862gH2yCeEu/StkG8CX9Kx/s/M=";
          };

          pkgs = import nixpkgs {
            inherit system;

            overlays = [ devshell.overlays.default ];
          };

          vela = import ./nix/vela.nix {
            inherit system pkgs;
            version = vela-version;
            sha256s = vela-sha256;
          };

        in
        pkgs.devshell.mkShell {
          packages = with pkgs; [ vela kubernetes-helm ];
          imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
        };
    });
}
