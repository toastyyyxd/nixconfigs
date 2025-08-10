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
        sha256 = "sha256:12jqmxah7bsg6hfa30dbdgprjqv20yhsbac97wqs58sl2hj88n3m";
      });
      version = "latest";
    });
    enable = true;
    profiles."main" = {
      userSettings = {
        "zig.zls.enabled" = "on";
        "zig.path" = "zig";
        "zig.zls.path" = "zls";
        "workbench.colorTheme" = "Catppuccin Mocha";
        "window.newWindowProfile" = "main";
      };
        extensions = with pkgs.vscode-marketplace; [
        # Environment compat with Nix using direnv
        mkhl.direnv      
        # Theming
        oderwat.indent-rainbow
        # Zig
        prime31.zig ziglang.vscode-zig lorenzopirro.zig-snippets bwork.zig-tools
        # Typescript, basic support is built-in with vscode
        pmneo.tsimporter yoavbls.pretty-ts-errors stringham.move-ts
        # Nix
        jnoortheen.nix-ide
        # Pythonms-python.python
        ms-python.python
        # Formatting - Prettier
        esbenp.prettier-vscode
        # Git
        eamodio.gitlens donjayamanne.githistory codezombiech.gitignore alefragnani.project-manager
        sanjulaganepola.github-local-actions
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
