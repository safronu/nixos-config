# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s20f0u11.useDHCP = true;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.networkmanager.enable = true;
  networking.enableIPv6 = false;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  nixpkgs.config = {
   allowUnfree = true;

   openjdk8 = {};   

   firefox = {
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
   };

   chromium = {
    enablePepperFlash = true;
   };

   git = {
    userName  = "safronu";
    userEmail = "uladzislau.safronau@gmail.com";
   };
  };

  environment.systemPackages = with pkgs; [
    wget 
    vim
    chromium 
    firefoxWrapper 
    git
    openjdk8
    sbt 
    rofi
    docker
    docker-compose
    vscode
    pavucontrol
    postman
    skype
    slack
    flameshot
    tdesktop
  ];

  services.xserver = {
   autorun = true;
   enable = true;
   layout = "us,ru";
   xkbOptions = "grp:alt_shift_toggle";
   exportConfiguration = true;
   desktopManager = {
    xterm.enable = false;
    plasma5.enable = true;
   };
   displayManager.lightdm.enable = true;
   windowManager = {
    i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        i3lock
        i3blocks
      ];
    };
   };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ulad = {
     isNormalUser = true;
     extraGroups = [ 
      "wheel" 
      "docker" 
      "audio"
     ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

