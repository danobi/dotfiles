{ config, pkgs, lib, ... }: 
let
  secrets = import ./secrets.nix;
in
{
  imports = [
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"
  ];

  system.stateVersion = "22.05";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    tailscale
    unifi7
  ];

  users = {
    mutableUsers = false;
    users."${secrets.user}" = {
      isNormalUser = true;
      password = "${secrets.user_password}";
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDdIky9I/pYmBYzh/CVhEjxURYvLJskJq0s8lF4xtza5 dxu@dxuuu.xyz"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/r30nqllTmi12ztwxiUSo9IdGfxIuDuoXXovCuoep2 dxu@aviatrix.com"
      ];
    };
  };

  services.tailscale.enable = true;
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
  services.unifi = {
    enable = true;
    openFirewall = true;
    unifiPackage = pkgs.unifi7;
  };

  networking = {
    hostName = "chhota";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8443 ];
      checkReversePath = "loose";
    };
  };

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  hardware.pulseaudio.enable = true;

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;
}
