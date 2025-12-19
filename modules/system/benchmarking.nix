{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    memtester y-cruncher
    sysbench mprime furmark geekbench
  ];
}