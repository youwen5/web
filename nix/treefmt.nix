rustToolchain: {
  # Used to find the project root
  projectRootFile = "flake.nix";

  programs = {
    nixfmt.enable = true;
    taplo.enable = true;
    rustfmt.enable = true;
    rustfmt.package = rustToolchain;
    yamlfmt.enable = true;
    prettier.enable = true;
  };

  settings.global.excludes = [
    ".direnv/*"
    ".envrc"
    "dist/"
    "pnpm-lock.yaml"
    "web/pnpm-lock.yaml"
    ".luminite/"
  ];
}
