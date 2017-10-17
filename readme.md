# Création de nouvelles instances
Permet de créer une version d'un site d'après un repository

## Installation

- Récupérer les fichiers avec `git clone git@github.com:canal-web/sites-factory.git` ou en téléchargeant le zip.
- Copier les fichiers se situant dans le dossier `variables` et les renommer en les préfixant de `local.`, modifier le contenu en conséquence.
- Créer un fichier `htpasswd.template` dans le dossier `templates` contenant les identifiants de l'htpasswd des sites

## Utilisation
```
sudo ./magic.sh -g repository -f files -d database -u user nom_du_nouveau_site
```

### Paramètres

`-g` : Facultatif. Fait un git clone du repository passé s'il existe. Sinon, crée le repository avec ce nom. Si non renseigné, pas de versionning.
`-f` : Facultatif. Copie les fichiers et fait un commit initial.  
`-d` : Facultatif. Copie la base de données donnée.  
`-u` : Facultatif. Installation une instance au nom de l'utilisateur passé. Crée le script de récupération de la BDD mère pour les synchronisations.

### Exemples

Créer une instance principale dépendant d'un repository

```
./magic.sh -g site_principal_repo -d site_principal_db nom_du_nouveau_site
```

Créer un site Magento avec les modules de base

```
./magic.sh -g nom_du_nouveau_site -f starter193 -d starter193 nom_du_nouveau_site
```

Créer une instance pour l'utilisateur review

```
./magic.sh -g instance_mere -d instance_mere -u review instance_mere
```

Créer une instance mère vide, sans CMS (attention manips supplémentaires nécessaires)

```
./magic.sh -g nom_du_nouveau_site nom_du_nouveau_site
cd /dosier/du/nom_du_nouveau_site/httpdocs/
git init
git add unfichier
git commit
git remote add origin /var/git/nom_du_nouveau_site/
git push --set-upstream origin master
```

**ATTENTION : le nom du nouveau site doit toujours être le dernier paramètre passé**

## Ajout d'un CMS

- Ajouter un fichier appelé `nomducms.sh` dans le dossier `cms` et mettre dedans tout ce qui est spécifique au cms (comme la création du fichier de connexion à la BDD).
- Mettre le gabarit du fichier de connexion à la BDD du cms dans `templates/nomducms`
- Pour ajouter des fonctionnalités spécifiques au CMS lors de la création du fichier de récupération de la BDD, ajouter un fichier `specific.sh` dans `templates/nomducms`

## TODO

- Rajouter une commande qui permettrait de spécifier le type de cms/framework qui sera utilisé, dans les cas où on ne part pas d'un starter (wordpress, laravel…), histoire de générer au moins un gitignore adapté (et comme ça on pourrait aussi automatiser les manips supplémentaires demandées quand on part sans base : git init, commit dans le vide, add remote, set upstream)
- Automatiser la création d'instances Laravel :P
