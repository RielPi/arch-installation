# ArchLinux Installation

## Before installing
- Load Keymap: `loadkeys la-latin1`
- Verify boot mode (EFI): `efivar -l`
- Check internet connection: `ping -c 3 archlinux.org`
- Update timezone
  - `timedatectl set-ntp true`
  - `timedatectl set-timezone America/Bogota`
  - `timedatectl status`

#### Disk partitioning (optional)
- Create **GPT** partition table:
  - `gdisk /dev/sdX`
  - Key press in order: **x**, **z**, **y**, **y**
- Create partitions `gdisk /dev/sdX`
  - Press **n** to create new partition
  - Partition number (1-128, default N): **enter**
  - First sector (default): **enter**
  - Last sector: (**+**/**-**)**N**{**KMGT**}
    > Assign "50gb": **+50G**
  - Hex code or GUID
    > EFI System ef00, BIOS: **ef02** <br>
    > Linux x86-64 root (/): **8304** <br>
    > Linux home (/home): **8302** <br>
    > Linux swap [Swap]: **8200** <br>
  - Press **p** then **w** and **y** to confirm

#### Disk formating (ext4)
- **/boot**: `mkfs.fat -F32 /dev/sdX1`
- **/** and **/home**: `mkfs.ext4 /dev/sdXn`
- **swap**: `mkswap /dev/sdXn & swapon /dev/sdXn`

#### Mounting
- Mount **/** partition in **/mnt**: `mount /dev/sdXn /mnt`
- Make mount points:
  - `mkdir /mnt/boot`
  - `mkdir /mnt/home`
  - `mount /dev/sdX1 /mnt/boot`
  - `mount /dev/sdXn /mnt/home`

