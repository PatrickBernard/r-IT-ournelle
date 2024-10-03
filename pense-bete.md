# Pense bête

Des actuces en vrac

## proxmox : pct restore failed (no space left)

Probablement du a l'utilisation d'un disque compresser (zfs) migrer vers un volume non-compresser (ext4)

Il suffit de restaurer à la main en précisant la nouvelle taille

```bash
pct restore <containerId> <pathToBackupArchive> --rootfs <sizeInGiB> --storage <nameOfTargetStorage>
```

## clavier fr sur cloudinit proxmox

```bash
apt install keyboard-configuration console-setup
```

## Boucle for en powershell
```bash
dir *.z64 | ForEach-Object { & 'C:\Program Files\7-Zip\7z.exe' a -tzip $_.BaseName $_.Name }
```

## Installation Linux avec un SSD

* monter les Partitions en noatime
* Pas besoin de trop utiliser le swap sur le machine récente
```bash
echo "vm.swappiness=10" >> /etc/sysctl.conf
sysctl -p
sysctl vm.swappiness
```
* zram-tools pour mettre le swap sur une partie de la mémoire compresser
Déconseiller en production
```bash
apt install zram-tools
```

##  psql lent sur proxmox/lxc : (3h => 2 semaines)

* (todo) problème apparement lié à zfs

# windows

## récupérer la clef windows d'un laptop/minipc,...

```bash
strings /sys/firmware/acpi/tables/MSDM
```
## eviter la connection a un compte microsoft lors de l'installation

* ouvrir une console avec MAJ+F10
``OOBE\BYPASSNRO``
