{ lib, config, pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  programs.bash.enable = true;
  programs.vscode = {
    package = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
      pname = "vscode-insiders";
      src = (builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
        sha256 = "sha256:1m8kzz4pjfwi19ra6jz8m2c7ni9mfsdvgx1nws2xzsz1j8qbji48";
      });
      version = "latest";
    });
    enable = true;
    profiles."main" = {
      userSettings = {
        "zig.zls.enabled" = "on";
        "zig.path" = "zig";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "window.newWindowProfile" = "main";
      };
      enableUpdateCheck = false;
      enableExtensionUpdateCheck  = false;
        extensions = with pkgs.vscode-marketplace; [
        # Environment compat with Nix using direnv
        mkhl.direnv      
        # Theming
        (catppuccin.catppuccin-vsc.override {
          accent = "mauve";
          boldKeywords = true;
          italicComments = true;
          italicKeywords = true;
          extraBordersEnabled = false;
          workbenchMode = "default";
          bracketMode = "rainbow";
        })
        catppuccin.catppuccin-vsc-icons oderwat.indent-rainbow
        # Zig
        prime31.zig ziglang.vscode-zig lorenzopirro.zig-snippets bwork.zig-tools
        # Typescript, basic support is built-in with vscode
        pmneo.tsimporter yoavbls.pretty-ts-errors stringham.move-ts
        # Nix
        jnoortheen.nix-ide
        # Formatting - Prettier
        esbenp.prettier-vscode
        # Git
        eamodio.gitlens donjayamanne.githistory codezombiech.gitignore alefragnani.project-manager
        # Copilot
        github.copilot github.copilot-chat
        # Remote SSH
        ms-vscode-remote.remote-ssh ms-vscode-remote.remote-ssh-edit ms-vscode.remote-explorer
        # Markdown
        yzhang.markdown-all-in-one
        # Docker
        ms-azuretools.vscode-docker ms-azuretools.vscode-containers
        # Prisma
        prisma.prisma abians.prisma-generate-uml
        # Discord activity
        icrawl.discord-vscode
      ];
    };
  };
}
