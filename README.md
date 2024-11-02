# Petites phrases +/- amusante autour de l'IT

Anedocte personnelle, ou déjà entendu ailleurs

Ajouter des commentaires selon les cas

Forme final: une présentation, titre + commentaire ?

## Si on se protège soi-même on protège les autres

* on casse les chaines de transmission
* marche dans de nombreux domaines autre que l'IT : transmission virus, escroquerie, ...
* voir esprit critique

## S'il n'y a pas de backup, ça n'éxiste pas

* Il s'agit d'un serveur jetable
* Si vous ete client, n'oubliez pas de réclamez des backups de vos serveurs important

## Il y a deux types de personnes, celles qui ont perdu des données, et celles qui vont en perdre.

* Backup

## Si ce n'est pas monitoré, il n'y a pas de problème

* Si vous ete client, pensez à réclamer le monitoring
* Mettre au point des méthodes, sondes, métrique pour détecter les problèmes

## Tout les actions doivent etre documenté

* todo ...

## Chaque bug, incidents, pénétration dans le SI doit etre documenté

* Pour permettre une réponse rapide
* Pour éviter que ça recommence
* Pour pouvoir le reproduire et améliorer la réponse

## Il y a deux bouts à un cable

* Celle la permet de résoudre 99% des problemes d'IT
* Vérifier toute la chaine de communication, que ça soit matériel, logiciel ou humain

## J'entends ...

* Il a pas entendu et s'en fou
* Il est contre cette idée

## On a pas besoin de documentation

* On a besoin d'une documentation
* Sauf le jour ou le seul qui connais n'est pas dispo

## Ce serveur/application/... est un cas particulier

* Et une seul personne sait comment ça marche
* voir : On a pas besoin de documentation

## Qui a fait ça ?

* voir : On a pas besoin de documentation
* Un type partie il y a 3 ans élever des chêvres dans le Larzak
* git blame

## Pas de mise en prod le vendredi

* On est le matin on a le temps de rollback
* Avec un cycle de production efficace cette peur devrait à terme disparaitre, test => qa => staging => preprod => prod, mais tout le monde n'est pas rigoureux
* ex : Patch CrowdStrike du 19/07

## C'est sur la roadmap

* ... et le client nous a cru

## RTFM

* Read The Fucking Manual

## Etre capable de travailler sans internet (en TT complet)

* par pigeon voyageur

## Sur l'automatisation

* si tu doit le faire une fois : fait le
* si tu dois le faire deux fois : automatise le
* Une tâche qui est faite au moins deux fois doit être automatisée

## Si un ordinateur peu le faire... il doit le faire

* automatisation
* historisation
* ...


## Si on ne peut plus prévoir de période de maintenance, il est déjà trop tard

* Si tu ne prévoit pas de maintenance, la maintenance viendra à toi
* le serveur est critique ne peut etre éteind
* il cumule tellement de retard qu'il ne peut plus etre mis à jour simplement
* le serveur servira dans une attaque de botnet

## Un bon adminsys est invisible

* Personne ne sait quand il fait du bon travail
* Tout le monde sait quand il y a un pépins

## ça marche sur mon poste

* On va mettre ton poste en prod

## Les shell sans set -euo pipefail au début, c'est le MAL.

* https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425?permalink_comment_id=3935570

## On écris du code pour etre lu

* la complexité du code amene des erreurs
* l'élégance d'un code et sa beauté ... n'est pas sa compléxité mais la faculté d'étre compréhensible par un maximum de personne
* Phrase de D.Ritchie (à vérifier) : "Unix est tellment simple qu'il faut etre un génie pour le comprendre"
