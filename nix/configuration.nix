
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # programs
  programs.niri.enable = true;
  programs.hyprland.enable = true;
  programs.fish.enable = true;
	programs.openvpn3.enable = true;
	programs.obs-studio = {
	  enable = true;

	  plugins = with pkgs.obs-studio-plugins; [
		obs-backgroundremoval
		obs-pipewire-audio-capture
		obs-gstreamer
		obs-vkcapture
	  ];
	};
environment.sessionVariables = {
  XDG_SESSION_TYPE = "wayland";
  XDG_CURRENT_DESKTOP = "Hyprland";
  XDG_SESSION_DESKTOP = "Hyprland";
};
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # services
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.ly.enable = true;
  services.xserver.enable = true;
	services.flatpak.enable = true;
	services.resolved.enable = true;
	  services.xserver.xkb = {
		layout = "us";
		variant = "";
  };
  services.printing.enable = true;

  services.keyd = {
	enable = true;
	keyboards = {
			default = {
				ids = ["*"];
				settings = {
					main = {
						capslock = "overload(control, esc)";
						esc = "capslock";
					};
				};
			};
		};
	};

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


# Portal configuration
xdg.portal = {
  enable = true;
  wlr.enable = false;
  extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
  config.common.default = "*";
};
  systemd.packages = [
    pkgs.pritunl-client
  ];

  systemd.targets.multi-user.wants = [
    "pritunl-client.service"
  ];
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  virtualisation.docker.enable = true;
  networking.networkmanager.enable = true;

  # other
  time.timeZone = "Asia/Baghdad";
  i18n.defaultLocale = "en_US.UTF-8";
  users.users."mohammed" = {
    isNormalUser = true;
    description = "mohammed";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # packages
  environment.systemPackages = with pkgs; [
	neovim
	niri
	git
	fastfetch
	docker
	brightnessctl
	go
	gopls
	golangci-lint
	golangci-lint-langserver
	stow
	ghostty
	fish
	zoxide
	tmux
	yazi
	dms-shell
	ly
	quickshell
	keyd
	brave
	vscodium
	tree-sitter
	fd
	skim
	fzf
	yazi
	starship
	lazygit
	lazydocker
	rustc
	gcc
	eza
	wl-clipboard
	pavucontrol
	slurp
	grim
	satty
	air
	jetbrains-mono
	libnotify
	cargo
	lazysql
	postgresql
	beekeeper-studio
	foliate
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
	cloc
	btop
	repgrep
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
