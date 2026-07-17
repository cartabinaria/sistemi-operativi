---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 24-11-2023 17:11:15
links:
  - "[[lecture-20112023130829|Lecture 20112023130829]]"
  - "[[lecture-22112023151203|Lecture 22112023151203]]"
  - "[[lecture-21032025091929|Lecture 21032025091929]]"
---
# Combinazione segmentazione-paginazione
---
## Introduzione
> La **combinazione tra [[segmentazione|segmentazione]] e [[paginazione|paginazione]]** costituisce il rimedio principale al problema della [[frammentazione-esterna|frammentazione esterna]], nonché il meccanismo standard di [[gestione-della-memoria|gestione della memoria]] (e quindi implementato dal [[sistema-operativo|sistema operativo]]) utilizzato oggiogiorno.

## Principio di implementazione
Fondamentalmente **ogni segmento viene suddiviso in pagine**, e **ogni segmento ha una sua tabella delle pagine**. Un indirizzo virtuale, ora, dovrà contenere:
- bit per il _numero di segmento_
- bit per il _numero di pagina_
- bit per l'_offset_

In questo modo dal numero di segmento sapremo a quale segmento vogliamo accedere; dal numero di pagina sapremo, di quel segmento, a quale pagina vogliamo accedere; e infine dall'offset sapremo di quella pagina di quel segmento a quale indirizzo specifico vogliamo accedere:
![[combinazione-segmentazione-paginazione.png]]

<u>Nota bene</u>: sarà necessaria una _tabella che identifica per ogni segmento l'indirizzo alla sua tabella delle pagine_.

La gestione delle pagine in memoria sarà gestita dai già noti [[algoritmi-di-paginazione|algoritmi di paginazione]], a prescindere dal segmento a cui una pagina appartiene!

<u>Osservazione</u>: il _side-effect_ di questa combinazione sta nel maggiore lavoro da parte dell'[[mmu|MMU]]. Infatti questa deve supportare sia la segmentazione che la paginazione.

## Osservazione
C'è un rapporto ortogonale che lega la paginazione con la segmentazione:
- la _paginazione illude di avere più memoria_
- la _segmentazione illude di avere più aree/tipi di memorie_

E' come se la paginazione si sviluppasse verticalmente, in profondità; mentre la segmentazione orizzontalmente, in larghezza.

## Referenze