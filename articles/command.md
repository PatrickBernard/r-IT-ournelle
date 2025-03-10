# Command

La commande `command` dans Bash est utilisée pour exécuter des commandes et vérifier leur disponibilité. Elle est plus simple que certaines alternatives comme `type` ou `which`, et elle est intégrée directement dans Bash, ce qui la rend plus rapide et fiable pour certains usages.

## Fonctionnalités principales de `command`

1. **Vérifier si une commande est disponible**  
   La syntaxe `command -v <nom_de_la_commande>` vérifie si une commande ou un programme est présent dans le chemin système (`PATH`).  
   - Si la commande est disponible, elle affiche son chemin d'accès (ou son nom s'il s'agit d'une commande intégrée).  
   - Si la commande n'existe pas, elle ne renvoie rien et retourne un code de sortie non nul.

   Exemple :

   ```bash
   command -v ls  # Affiche "/bin/ls" ou une autre localisation
   command -v commande_inexistante  # Ne renvoie rien
   ```

2. **Exécuter une commande, même si elle est masquée par une fonction ou un alias**  
   La commande `command` peut être utilisée pour exécuter une commande externe sans être affectée par un alias ou une fonction du même nom.  

   Exemple :
  
   ```bash
   alias ls="echo 'alias utilisé'"
   ls  # Affiche "alias utilisé"
   command ls  # Exécute la vraie commande 'ls'
   ```

3. **Vérifier des commandes intégrées au shell**  
   `command -v` fonctionne également pour les commandes intégrées de Bash, comme `cd`, `echo`, ou `alias`.  

   Exemple :

   ```bash
   command -v cd  # Affiche "cd"
   ```

## Options utiles

- **`-v`** : Vérifie si la commande est disponible et affiche son emplacement ou nom (utile pour des vérifications rapides).
- **`-p`** : Ignore les alias et fonctions pour utiliser uniquement la version native ou externe de la commande.
- **`-V`** : Donne plus de détails sur la commande, en précisant si elle est intégrée, un alias, une fonction, etc.

## Exemple pratique

```bash
#!/bin/bash

# Vérifier si une commande intégrée ou un programme existe
if command -v git > /dev/null; then
    echo "Git est installé."
else
    echo "Git n'est pas installé."
fi
```
