{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule rec {
  pname = "gcsemulator";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "fullstorydev";
    repo = "emulators";
    tag = "storage/v${version}";
    hash = "sha256-BuBPQV/98l3RmP4L6KfwQaPXUaaxRr54MU3p5WIKJ+I=";
  };

  modRoot = "./storage";

  vendorHash = "sha256-NrC+hXb4EjzZaFw0wQyDuRUFilh41eDFA6NunuMnd0k=";

  subPackages = [ "cmd/gcsemulator" ];

  # See https://github.com/fullstorydev/emulators/blob/storage/v1.0.0/storage/Makefile#L61.
  ldflags = [ "-X main.version=v${version}" ];

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "High quality Google Cloud Storage emulator for local development stacks";
    homepage = "https://github.com/fullstorydev/emulators";
    license = lib.licenses.mit;
    mainProgram = "gcsemulator";
    maintainers = with lib.maintainers; [ commiterate ];
  };
}
