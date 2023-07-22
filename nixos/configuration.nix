{ config, pkgs, lib, ... }: 
let
  secrets = import ./secrets.nix;
in
{
  imports = [
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/d4ea64f2063820120c05f6ba93ee02e6d4671d6b.tar.gz" }/raspberry-pi/4"
  ];

  system.stateVersion = "23.05";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  environment.systemPackages = with pkgs; [
    sshfs
    tmux
    wol
    vim
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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0Cu4NxH9B/1r3clSBC7oO2Uq6MNt6z8YaRDa3vQczL dxu@dxuuu.xyz"
      ];
    };
  };

  services = {
    tailscale.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    unifi = {
      enable = true;
      openFirewall = true;
      unifiPackage = pkgs.unifi7;
    };
    adguardhome = {
      enable = true;
      openFirewall = true;
      settings = {
        bind_host = "0.0.0.0";
        bind_port = 3000;
      };
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
      user = "${secrets.user}";
      group = "users";
    };
  };

  networking = {
    hostName = "chhota";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        # For unifi controller
        8443
        # For adguardhome to serve dns
        53
      ];
      allowedUDPPorts = [
        # For adguardhome to serve dns
        53
      ];
      checkReversePath = "loose";
    };
  };

  boot.kernel.sysctl = {
    # Allow ipv4 forwarding so host can be used as a tailscale exit node
    "net.ipv4.conf.all.forwarding" = true;
  };

  # Enable GPU acceleration
  # Currently disabled due to https://github.com/NixOS/nixos-hardware/issues/631
  #hardware.raspberry-pi."4".fkms-3d.enable = true;

  hardware.pulseaudio.enable = true;
  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;
}
