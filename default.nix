{
  lib,
  clangStdenv,
  fetchFromGitHub,
}:
clangStdenv.mkDerivation rec {
  pname = "mu-lang-compiler";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "CpalmerD20";
    repo = "Mu-Lang-Compiler";
    rev = "v${version}";
    hash = "sha256-HyRVaHw31+xQuUUC3i3DDMnwpnhoEM6nquaZmFO4W/o=";
  };

  buildPhase = ''
    clang -o mu *.c
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp mu $out/bin/
  '';

  meta = with lib; {
    description = "Mu-Lang C compiler";
    homepage = "https://github.com/CpalmerD20/Mu-Lang-Compiler";
    #license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; ["djacu"];
    mainProgram = "mu-lang-compiler";
    platforms = platforms.all;
  };
}
