{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;  #Sorry stallman sir

  nix = {
	 autoOptimiseStore = true;
	package = pkgs.nixFlakes;
	extraOptions = ''
		experimental-features = nix-command flakes
	'';
   };

  # Fonts
  fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "Mononoki" "JetBrainsMono" ]; })
];

  # Networking
   networking.networkmanager.enable = true;

  # Use the systemd-boot EFI boot loader.
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "nix"; # Define your hostname.

  # Set your time zone.
   time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
    console = {
      font = "Lat2-Terminus16";
       keyMap = "us";
     };

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.demus= {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "users" ]; 
   };

   boot.kernelPackages = pkgs.linuxPackages_latest;



   programs.sway = {
   	enable = true;
	wrapperFeatures.gtk = true;
	extraPackages = with pkgs; [
	swaylock-fancy
	swaylock-effects
	dmenu
	waybar
	wofi
	grim
	slurp
	mako
	alacritty
	];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
      # Text Editors/Editing/Compiler 
	vscode
        neovim 
	gcc

      # System Utils	 
        wget
	usbutils
        coreutils
        git
     	gcc
	ripgrep
	exa
	bat
	tree
	fd

      # Terminal && prompt	
	kitty
	starship
	pfetch

      # Browser, vc, pdf	
	brave
	discord
	discocss
	zathura

      # Theme	 
	lxappearance
	papirus-icon-theme
	brightnessctl
  		
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "22.05"; # Did you read the comment?

}

