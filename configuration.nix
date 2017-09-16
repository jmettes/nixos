## Edit this configuration file to define what should be installed on
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

  networking.hostName = "nixos"; # Define your hostname.
  #networking.networkmanager.enable = true;
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Australia/Canberra";

  nixpkgs.config = import ./nixpkgs-config.nix;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    systemToolsEnv
    chromium
    dmenu
    vim
    haskellPackages.X11
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    xorg.xbacklight
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      ubuntu_font_family
      unifont
    ];
  }; 

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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;
  # services.xserver.synaptics.enable = true;


  services.xserver = {
    enable = true;

    synaptics = {
      enable = true;
      tapButtons = true;
      fingersMap = [1 3 2];
      horizTwoFingerScroll = true;
      vertTwoFingerScroll = true;
      scrollDelta = 107;
      accelFactor = "0.1";
      twoFingerScroll = true;

      # palm detection
      # https://askubuntu.com/questions/229311/synaptics-touchpad-solving-2-finger-problem-triggered-by-resting-palm/772103#772103
      palmDetect = true;
      palmMinWidth = 10;
      palmMinZ = 0;
      additionalOptions = ''
        # https://askubuntu.com/a/772103
        Option "AreaLeftEdge" "2000"
        Option "AreaRightEdge" "5500"
      '';
    };

# libinput has "disableWhileTyping", which works pretty well for palm detection
# but does not support 'kinetic scrolling/coasting' like synaptics:
#    libinput = {
#      enable = true;
#      accelProfile = "adaptive";
#      accelSpeed = "0.7";
#      scrollMethod = "twofinger";
#      tapping = true;
#      naturalScrolling = false;
#      disableWhileTyping = true;
#      tappingDragLock = false;
#    };



    # synaptics.enable = true;
    # synaptics.minSpeed = "1";
    # synaptics.palmDetect = true;
    # synaptics.twoFingerScroll = true;

    displayManager.slim.enable = true;
    displayManager.slim.defaultUser = "jonathan";

    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  users.extraUsers.jonathan = {
    isNormalUser = true;
    uid = 1000;
    description = "Jonathan Mettes";
    home = "/home/jonathan";
    extraGroups = [ "wheel" ];
 };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
