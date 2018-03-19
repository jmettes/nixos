# ga nixos config

## installing on virtualbox

`systemctl start display-manager`

Open gparted create single partion ext4 partition

```
$ mkfs.ext4 -j -L nixos /dev/sda1
$ mount LABEL=nixos /mnt
$ nixos-generate-config --root /mnt
$ vi /mnt/etc/nixos/configuration.nix
```
```
{ config, pkgs, ...} :
{
  boot.loader.grub.device = "/dev/sda";
  services.openssh.enable = true;
  services.virtualbox.enable = true;

  fileSystems = [
    { mountPoint = "/";
      label = "nixos";
    }
  ];
}
```
```
$ nixos-install
$ reboot
```

Then when rebooted

```
curl https://raw.githubusercontent.com/jmettes/nixos/ga/configuration.nix --output configuration.nix
curl https://raw.githubusercontent.com/jmettes/nixos/ga/nixpkgs-config.nix --output nixpkgs-config.nix

nixos-rebuild switch
```

