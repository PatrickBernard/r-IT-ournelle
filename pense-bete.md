# Pense bête

Des actuces en vrac

## Proxmox

### proxmox : pct restore failed (no space left)

Du a l'utilisation d'un disque compresser (zfs) migrer vers un volume non-compresser (ext4) ?

(Réponse de nidouille) C'est la migration du Mode block du zfs vers un file system qui a posé problème.

Il suffit de restaurer à la main depuis une backup. (j'ai du re-spécifier la taille du rootfs)

```bash
pct restore <containerId> <pathToBackupArchive> --rootfs <sizeInGiB> --storage <nameOfTargetStorage>
```

### ajouter un clavier fr dans un cloudinit proxmox

```bash
apt install keyboard-configuration console-setup
```

## Linux

### Installation Linux avec un SSD

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

### purger les vieille config

```bash
apt purge $(dpkg -l | grep '^rc' | awk '{print $2}')
```

### psql lent sur proxmox/lxc : (3h => 2 semaines)

* (todo) problème apparement lié à zfs ?

## windows

### Boucle for en powershell

```bash
dir *.z64 | ForEach-Object { & 'C:\Program Files\7-Zip\7z.exe' a -tzip $_.BaseName $_.Name }
```

### récupérer la clef windows d'un laptop/minipc

```bash
strings /sys/firmware/acpi/tables/MSDM
```

### eviter la connection a un compte microsoft lors de l'installation

* ouvrir une console avec MAJ+F10
``OOBE\BYPASSNRO``
