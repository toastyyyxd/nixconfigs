{ config, ... }:
{
  services.udev.extraHwdb = ''
    evdev:input:*
      KEYBOARD_KEY_70039=leftmeta
  '';
}