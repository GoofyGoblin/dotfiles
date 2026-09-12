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

  # sway + wayland configurations
  programs.sway = {
      enable = true;
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
  };


  services.displayManager.ly.enable = true;

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  # nvidia stuff fuck you nvidia
  hardware.graphics = {
      enable = true;
      enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
  	modesetting.enable = true;
	open = false;
	nvidiaSettings = true;
	package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.winter = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
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
  ];

  nixpkgs.config.allowUnfree = true;
  
  fonts.packages = with pkgs; [
  	nerd-fonts.jetbrains-mono
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05"; 
}

