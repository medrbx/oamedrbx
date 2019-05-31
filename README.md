# Alimentation d'un agenda OpenAgenda via webservices pour la Médiathèque

## Objectif :
On souhaite que les événements présents sur le sute web de la Médiathèque soient également visibles sur OpenAgenda.
Pour cela, on va mettre en place un processus permettant d'alimenter OpenAgenda à partir d'un fichier csv.

## Documentation de l'API d'OpenAgenda :

### Création d'un événement :
https://openagenda.zendesk.com/hc/fr/articles/115004460013--v2-agendas-agendaUid-events-post-Cr%C3%A9er-un-%C3%A9v%C3%A9nement

### Structure d'un événement :
https://openagenda.zendesk.com/hc/fr/articles/115003266734

## Avancement

### Fait
- on dispose d'une classe OpenAgenda permettant de pousser un événement dans un agenda

### À faire
- documenter précisément les champs nécessaires pour la Médiathèque et la manière dont on les remplit au sein du fichier csv
- mettre en place la lecture du fichier csv et la création d'événements dans OA à partir de celui-ci.