# Alpine

- Est une distribution très légère particulierement à la mode pour les conteneurs

## Installation Proxmox LXC

- via : <https://community-scripts.github.io/ProxmoxVE>
- ``bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/alpine.sh)"``

## gestion des packages

- mise à jour index : ``apk update``
- mise à jour package : ``apk upgrade``
- ajout package : ``apk add <package>``
- suppression package : ``apk add <package>``

## ajout utilisateurs

``setup-user``

## doas (= sudo)

- alpine n'utilise pas ``sudo`` mais ``doas`` depuis la 3.15
- ``apk add doas``
- les deux systèmes utilise le groupe "wheel" comme sur redhat,fedora, ...

## à faire

- un role ansible pour les utilisateurs "admin"
- un role ansible pour les paquets de base
- un role pour le hardening (iptable, ...)
