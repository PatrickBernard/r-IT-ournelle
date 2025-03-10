# Emulation

## Préparation des kit de rom

- download des sets (emplacement sécurisé pour la "préservation vidéoludique")
- download des dat (dat-o-matic) décrivant les set de roms
- retool pour filtrer le dat en "1 game 1 rom" (supprimer les clones, demo, beta, non licencié, ...)
- romcenter (ou autre) pour nettoyer("fix") le set des roms non voulu
- scraper le résultat avec skraper
- poser les rom sur le partage de la recalbox, batocera, …

## Download

- L'une des meilleurs ressources est : <https://archive.org/developers/internetarchive/>

- Downloader avec Python :

```python
from internetarchive import download
download('nointro.n64', verbose=True)
```
