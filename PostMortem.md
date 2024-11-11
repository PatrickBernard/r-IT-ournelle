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
