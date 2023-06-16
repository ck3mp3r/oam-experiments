{ system, pkgs, version, sha256s }:

let
  url = "https://github.com/kubevela/kubevela";

  # Define a mapping from Nix system names to Kubevela system names
  systemMap = {
    "x86_64-linux" = "linux-amd64";
    "aarch64-linux" = "linux-arm64";
    "x86_64-darwin" = "darwin-amd64";
    "aarch64-darwin" = "darwin-arm64";
  };
  velaSystem = systemMap.${system};

  pname = "vela";
  tarballName = "vela-${version}-${velaSystem}.tar.gz";
  fullUrl = "${url}/releases/download/${version}/${tarballName}";
  sha256 = sha256s.${system};

  vela = pkgs.stdenv.mkDerivation rec {
    inherit pname version;

    src = pkgs.fetchurl {
      inherit sha256;
      url = fullUrl;
    };

    buildPhase = ''
      tar xvf $src
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp vela $out/bin/vela
    '';

    meta = with pkgs.lib; {
      description = "An easy-to-use yet highly extensible cloud native platform for deploying and managing applications.";
      homepage = "https://kubevela.io/";
      license = licenses.asl20;
      platforms = platforms.all;
    };
  };
in
vela
