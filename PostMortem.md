# PostMortem

Ensemble de trucs qui m'ont pété à la tronche et leurs résolutions

## Panne aléatoire sur un événement bancaire

### Le problème

- Une transaction bancaire sur trois n'aboutissait pas
- Les logs sont silencieux de même coté banque

### Explication

- L'identifiant était générer de maniere aléatoire a taille fixe
- 30% du "stock" de nombres alatoire avait été consommé

### Résolution

- Préfixer chaque transaction avec la date (AAAAMMJJHHMMSS)

## VSFTPd sous LXC

- vsftpd créer par défaut un namespace par connexion
- sous lxc, l'hôte n'est pas capable de supprimer le namespace créer par vsftpd
- ralentissement puis plantage de l'hôte
- config vsftpd

```text
# Compatibilité sous lxc
isolate=NO
isolate_network=NO
```

## Comment rendre inaccessible une machine depuis son terminal

Par exemple un nœud de calcul intermittent

- Tout ce qui est extinction : `shutdown -n`, `poweroff`, ...
- Couper le réseau : `service networking stop`
- Gestion matérielle : `ipmitool` ( si bare-metal )

Les trucs de barbu

- kill init
- linux Magic SysRq key <https://fr.wikipedia.org/wiki/Magic_SysRq_key>

## Modifier les droits d'un fichier avec un chmod qui a perdu ses droits

- mettre le contenu de chmod dans un fichier avec les droits d'éxécution :

```bash
cp /bin/ls new-chmod ; cat /bin/chmod > new-chmod ; ./newchmod +x /bin/chmod
```

- python : `os.chmod`
