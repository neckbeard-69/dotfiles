{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.ly.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.flatpak.enable = true;
  services.resolved.enable = true;
  services.printing.enable = true;

  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];

      settings.main = {
        capslock = "overload(control, esc)";
        esc = "capslock";
      };
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  virtualisation.docker.enable = true;

  systemd.packages = [
    pkgs.pritunl-client
  ];

  systemd.targets.multi-user.wants = [
    "pritunl-client.service"
  ];

  systemd.user.services.batsignal = {
    description = "Battery monitor";
    documentation = [ "man:batsignal(1)" ];

    wantedBy = [ "default.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.batsignal}/bin/batsignal -p -f 97 -w 20 -c 10 -d 1 -P Charging -U Discharging";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
}
