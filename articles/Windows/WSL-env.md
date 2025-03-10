# Linux sous windows

## WSL

..historique ?

## Virtualisation Hardware

* Vérifier si la virtualisation matériel est activé
  * ``Get-ComputerInfo | Select-Object HyperV*``
  * ``systeminfo``
  * via le ``Gestionnaire des tâches`` => ``Performances`` => ``Processeur``

* Activer la virtualisation matériel
  * Dans le bios F2/DEL/F12/F10 ... selon le matériel
  * Activé ``Intel Virtualization Technology`` ou ``AMD-V`` selon le CPU

### Installer WSL 2 en mode connecté

* Vérifier si on est bien en WSL 2

```bash
wsl --status
Distribution par défaut : Debian
Version par défaut : 2
```

* Si non :

```bash
wsl --set-default-version 2
```

* Lister les distributions disponible

```bash
wsl --list --online
Voici une liste des distributions valides qui peuvent être installées.
Installer en utilisant 'wsl.exe --install <Distro>'.

NAME                            FRIENDLY NAME
Ubuntu                          Ubuntu
Debian                          Debian GNU/Linux
kali-linux                      Kali Linux Rolling
Ubuntu-18.04                    Ubuntu 18.04 LTS
Ubuntu-20.04                    Ubuntu 20.04 LTS
Ubuntu-22.04                    Ubuntu 22.04 LTS
Ubuntu-24.04                    Ubuntu 24.04 LTS
OracleLinux_7_9                 Oracle Linux 7.9
OracleLinux_8_7                 Oracle Linux 8.7
OracleLinux_9_1                 Oracle Linux 9.1
openSUSE-Leap-15.6              openSUSE Leap 15.6
SUSE-Linux-Enterprise-15-SP5    SUSE Linux Enterprise 15 SP5
SUSE-Linux-Enterprise-15-SP6    SUSE Linux Enterprise 15 SP6
openSUSE-Tumbleweed             openSUSE Tumbleweed
```

* Installer votre distribution préféré

```bash
wsl --install Debian
```

Cette commande installeras directement tout les sous-systeme windows nécéssaire.
``Sous-système Windows pour Linux (WSL)`` et ``VirtualMachinePlatform``

### Installation en mode non-connecté

* Installation manuel des sous systèmes windows

```bash
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

* Reboot
* activé la version 2 : ``wsl --set-default-version 2``
* Télécharger une distribution Linux : <https://learn.microsoft.com/fr-fr/windows/wsl/install-manual#downloading-distributions>
* ``Add-AppxPackage -Path chemin\vers\appx``

### Lancer WSL

* En ligne de commande ``wsl``
* ou via le raccourcie créer dans le menu démarrer

### Configurer la distribution Linux

#### Création de l'utilisateur

Au 1er démarrage du WSL, celui demandera une création d'utilisateur / mot de passe.

#### Interface graphique de configuration

``wsl-settings``

#### Ajouter Systemd (si nécéssaire)

Dans votre environnement linux :

``sudo echo -e "[boot]\nsystemd=true" >> /etc/wsl.conf``

Reboot Linux (windows term) : ``wsl --shutdown``

## Installation des outils

Faite comme avec votre système linux classique en ligne de commande.

ex : ``sudo apt install terminator``

## Multiple WSL

?

## Networking avec WSL

?

### dhcp

?

### ip fixe

?
