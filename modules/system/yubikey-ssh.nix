{ lib, config, pkgs, home-manager, ... }:
{
  programs.ssh.extraConfig = lib.mkBefore ''
Host *
  IdentityFile ${../../assets/id_ed25519_sk}
  IdentitiesOnly yes
  AddKeysToAgent no
'';
}
