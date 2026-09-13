{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Ho_Chi_Minh";

  #i hope i always check every bash script from curl before running it
  security.sudo.enable = true;

  #change shell
  programs.zsh.enable = true;

  # sway + wayland configurations
  programs.sway = {
      enable = true;
      extraOptions = [ "--unsupported-gpu" ];
      wrapperFeatures.gtk = true;
  };

  programs.xwayland.enable = true;

  xdg.portal = {
  	enable = true;
  	wlr.enable = true;
  	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  	config.common.default = "*";
  };

  environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";
  	SDL_VIDEODRIVER = "wayland";
  	QT_QPA_PLATFORM = "wayland;xcb";
  	GDK_BACKEND = "wayland, x11";
  	_JAVA_AWT_WM_NONREPARENTING = "1";
    WLR_UNSUPPORTED_GPU = "1";
  };


  services.displayManager.ly.enable = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  # nvidia stuff fuck you nvidia
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
  	modesetting.enable = true;
	open = false;
	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };

  environment.sessionVariables = {
  	GBM_BACKEND = "nvidia-drm";
  	__GLX_VENDOR_LIBRARY_NAME = "nvidia";
  	WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.winter = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      tree
    ];
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-unikey
      fcitx5-configtool
      fcitx5-gtk
    ];
    fcitx5.waylandFrontend = true;
  };


  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    pulseaudio
  	vim
  	wget
  	waybar
  	rofi
  	foot
  	grim
  	dunst
	  gcc
  	slurp
	  wl-clipboard
	  cmake
    bash
    swaybg
  ];

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
  	nerd-fonts.jetbrains-mono
  ];

  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}

