# Pense bête

Des actuces en vrac

## Git

```bash
git commit --allow-empty -m "commit vide pour déclencher des actions"
```

## Proxmox

### proxmox : pct restore failed (no space left)

Du a l'utilisation d'un disque compresser (zfs) migrer vers un volume non-compresser (ext4) ?

(Réponse de nidouille) C'est la migration du Mode block du zfs vers un file system qui a posé problème.

Il suffit de restaurer à la main depuis une backup. (j'ai du re-spécifier la taille du rootfs)

```bash
pct restore <containerId> <pathToBackupArchive> --rootfs <sizeInGiB> --storage <nameOfTargetStorage>
```

### backup sur le noeud proxmox

Il peut etre ineteressant d'installer proxmoxbackupserver directement sur le noeud plutot que dans une vm.

- Ouvrir le port 8007

```bash
echo "deb http://download.proxmox.com/debian/pbs $(awk -F'=' '/VERSION_CODENAME/ {print $2;}' /etc/os-release) pbs-no-subscription" >> /etc/apt/sources.list
apt update
apt install proxmox-backup
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
echo "vm.swappiness=10" > /etc/sysctl.d/swappiness.conf
sysctl -p /etc/sysctl.d/swappiness.conf
```

* zram-tools pour mettre le swap sur une partie de la mémoire compresser

Déconseiller en production

```bash
apt install zram-tools
```

### swapiness a 10


### purger les vieille config

```bash
apt purge $(dpkg -l | grep '^rc' | awk '{print $2}')
```

### psql lent sur proxmox/lxc : (3h => 2 semaines)

* chez aday
  * (todo) problème apparement lié à zfs ?
  * ssh est aussi affecté, le problème est général, probablement un pb de configuration

## windows

### Boucle for en powershell

```bash
dir *.z64 | ForEach-Object { & 'C:\Program Files\7-Zip\7z.exe' a -tzip $_.BaseName $_.Name }
```

### Récupérer la clef windows d'un laptop/minipc

```bash
strings /sys/firmware/acpi/tables/MSDM
```

### Eviter la connection a un compte microsoft lors de l'installation

* Lors de l’invite de création de compte Microsoft :
  * ouvrir une console avec MAJ+F10
  * taper : ``OOBE\BYPASSNRO``

### Eviter la connection a un compte microsoft lors de l'installation (V2) à tester

* Lors de l’invite de création de compte Microsoft :
  * ouvrir une console avec MAJ+F10
  * taper : ``start ms-cxh:localonly``
