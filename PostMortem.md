# PostMortem

Ensemble de trucs qui m'ont pété à la tronche et leurs résolutions

## vsftpd sous lxc
- vsftpd créer par defaut un namespace par connection
- sous lxc, l'hote n'est pas capable de supprimer le namespace créer par vsftpd
- ralentissement puis plantage de l'hôte
- config vsftpd
```
# Compatibilité sous lxc
isolate=NO
isolate_network=NO
```

## Comment rendre inaccessible une machine depuis son terminal 
(genre un nœud de calcul qui deviens fou)

* tout ce qui est extinction : shutdown -n, poweroff, ...
* couper le réseaux : service networking stop, ...
* gestion matériel : ipmitool ( si bare-metal )

Ensuite on a les trucs de barbu
* kill init
* linux Magic SysRq key <https://fr.wikipedia.org/wiki/Magic_SysRq_key>

## Modifier les droits d'un fichier avec un chmod qui à perdu ses droits

* mettre le contenu de chmod dans un fichier avec les droits d'éxécution ; `cp /bin/ls chmodbis ; cat /bin/chmod > chmodbis ; ./chmodbis +x /bin/chmod`
* python : `os.chmod`
