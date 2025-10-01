{
  fetchFromGitHub,
  stdenv,
  lib,
  nodejs, deno,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "catppuccin-palette-dist";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "palette";
    rev = "v${finalAttrs.version}";
    hash = lib.fakeSha256;
  };

  nativeBuildInputs = [
    nodejs
    deno
  ];

  pnpmDeps = pnpm_9.fetchDeps {
    inherit (finalAttrs) pname version src;
    fetcherVersion = 1;
    hash = "sha256-7NrDYd4H0cPQs8w4lWlB0BhqcYZVo6/9zf0ujPjBzsE=";
  };

  buildPhase = ''
    runHook preBuild

    pushd node_modules/sqlite3
    node-gyp rebuild
    popd

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib
    cp -r * $out/lib
    makeWrapper ${nodejs}/bin/node "$out/bin/cdxgen" --add-flags "$out/lib/bin/cdxgen.js"
    makeWrapper ${nodejs}/bin/node "$out/bin/cdxgen-evinse" --add-flags "$out/lib/bin/evinse.js"
    makeWrapper ${nodejs}/bin/node "$out/bin/cdxgen-repl" --add-flags "$out/lib/bin/repl.js"
    makeWrapper ${nodejs}/bin/node "$out/bin/cdxgen-verify" --add-flags "$out/lib/bin/verify.js"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Creates CycloneDX Software Bill-of-Materials (SBOM) for your projects from source and container images";
    mainProgram = "cdxgen";
    homepage = "https://github.com/CycloneDX/cdxgen";
    license = licenses.asl20;
    maintainers = with maintainers; [
      dit7ya
      quincepie
    ];
  };
})