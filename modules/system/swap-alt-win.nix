{ config, ... }:
{
  services.udev.extraHwdb = ''
    evdev:atkbd:*
      KEYBOARD_KEY_38=leftmeta   # Alt → Super
      KEYBOARD_KEY_db=leftalt    # Super → Alt
  '';
}
