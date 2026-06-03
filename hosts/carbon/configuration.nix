{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/system/journald.nix
    ../../modules/system/utils.nix
    ../../modules/system/docker.nix
    inputs.home-manager.nixosModules.default
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };

  services.fail2ban.enable = true;

  networking = {
    hostName = "carbon";
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  time.timeZone = "Asia/Hong_Kong";

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 21d";
    };
  };

  users.users.toasty = {
    isNormalUser = true;
    description = "toasty";
    initialPassword = "changeme";
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      (builtins.readFile ../../assets/id_ed25519_sk.pub)
    ];
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "toasty" = import ./home.nix;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment.systemPackages = with pkgs; [
    tmux
    btop
    wget
    curl
    rsync
  ];

  system.stateVersion = "25.05";
}
