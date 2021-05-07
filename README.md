# ArchLinux Installation

- Download ISO from [Archlinux website](https://www.archlinux.org/download/)
- USB prep:
```shell
sudo dd bs=4M if=/ruta/a/archlinux.iso of=/dev/sdX status=progress && sync
```

## Before installing
- Load Keymap: `loadkeys la-latin1`
- Verify EFI mode is enabled: `efivar -l`
- Check internet connection: `ping -c 3 archlinux.org`
- Update timezone
  - `timedatectl set-ntp true`
  - `timedatectl set-timezone America/Bogota`
  - `timedatectl status`

#### Disk partitioning (optional)

> ⚠ This process will wipe your entire disk, backup files if needed. Locate your disk name **sdX** with `lsblk` 

- Create **GPT** partition table:
  - `gdisk /dev/sdX`
  - Key press in order: **x**, **z**, **y**, **y**
- Create partitions `gdisk /dev/sdX`, partitions used for this setup (**boot**, **swap**, **root**, **home**)
  - Press **n** to create new partition
  - Partition number (1-128, default N): **enter**
  - First sector (default): **enter**
  - Last sector: (**+**/**-**)**N**{**KMGT**}
    > boot: **+500M**, swap: **+8G**, root: **+50G**, home: **enter**
  - Hex code or GUID
    > boot: **ef00**, swap: **8200**, root: **8304**, home: **8302**
  - Press **p** then **w** and **y** to confirm

### Format partitions
- **boot**: `mkfs.fat -F32 /dev/sdX1`
- **swap**: `mkswap /dev/sdX2` & `swapon /dev/sdX2`
- **root** and **home**: `mkfs.ext4 /dev/sdXn` n: (3, 4)

### Mounting
- Mount **/** partition in **/mnt**: `mount /dev/sdX3 /mnt`
- Make mount points:
  - `mkdir /mnt/boot`
  - `mkdir /mnt/home`
  - `mount /dev/sdX1 /mnt/boot`
  - `mount /dev/sdX4 /mnt/home`

## Installation

- [ ] todo: Mirrorlist config
- Install base system: `pacstrap -i /mnt base base-devel git nano`
- Generate **fstab** file: `genfstab -U -p /mnt >> /mnt/etc/fstab`
  > Verify the current fstab config for any mistake
- Chroot into Arch: `arch-chroot /mnt`
- Clone this repo and run [base-install.sh](base-install.sh): `git clone https://github.com/RielPi/arch-installation`
- Edit `/etc/mkinitcpio.conf` and add modules for Nvidia:
  - **MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)**
- Edit `/boot/loader/entries/arch.conf` at the end of the line `options root=...` add:
  - **nvidia-drm.modeset=1**
- `mkinitcpio -p linux`
- Exit chroot, `umount -a` & `reboot`

## Post-Installation

- Run [packages.sh](packages.sh)
- Desktop Enviroments
  - Run [kde.sh](kde.sh)
