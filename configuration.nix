## Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # virtualbox boot loading
  boot.loader.grub.device = "/dev/sda";
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.docker.enable = true;
#  virtualisation.docker.enableOnBoot = true;

  networking.hostName = "nixos"; # Define your hostname.

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
    busybox
    dmenu
    docker
    emacs
    firefox
    vim
    haskellPackages.X11
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    linuxPackages.virtualboxGuestAdditions
    rxvt_unicode
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


  services.xserver = {
    enable = true;

    displayManager.slim.enable = true;
    displayManager.slim.defaultUser = "jonathan";

    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  users.extraUsers.jonathan = {
    isNormalUser = true;
    uid = 1000;
    description = "Jonathan Mettes";
    home = "/home/jonathan";
    extraGroups = [ "wheel" "docker" ];
 };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
