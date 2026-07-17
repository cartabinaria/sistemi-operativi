---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 25-03-2025 18:26:30
links:
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
---
# Deadlock detection
---
## Introduzione
> Il **deadlock detection** consiste in una serie di politiche volte ad identificare casi di [[deadlock|deadlock]] nei [[sistema-operativo|sistemi operativi]]. In particolare, consiste nel mantenere aggiornato il [[grafo-di-holt|grafo di Holt]], registrando su di esso tutte le assegnazioni e le richieste di [[risorsa|risorse]].

Infatti, sfruttando il grafo di Holt siamo in grado di riconoscere stati di deadlock!

## Casi
### Una risorsa per classe
> Se le risorse sono a richiesta bloccante, non condivisibili e non prerilasciabili, allora lo stato e' di deadlock $\iff$ il grafo di Holt contiene un ciclo.

#### Dimostrazione
Per dimostrare il teorema trasformiamo i grafi di Holt in [[grafo-wait-for|grafi wait-for]], eliminando ogni risorsa e collassando gli archi associati. In questo modo il grafo di Holt contiene un ciclo $\iff$ lo contiene il grafo wait-for associato, e se quest'ultimo contiene un ciclo allora abbiamo attesa circolare. Questa era l'ultima condizione sufficiente e necessaria rimanente per il deadlock.

### Piu' risorse per classe
In questo caso non basta avere cicli nel grafo di Holt. Bisogna usare la [[grafo-di-holt-riducibilita|riducibilita' dei grafi di Holt]].

> Lo stato non e' di deadlock $\iff$ il grafo di Holt e' completamente riducibile, o usando la contronominale, lo stato e' di deadlock $\iff$ il grafo di Holt non e' completamente riducibile.

### Knot
Un altro strumento per identificare casi di deadlock, puramente matematico, si basa sulla nozione di [[knot|knot]].

> Dato un grafo di Holt con una sola richiesta sospesa per processo, se le risorse sono a richiesta bloccante, non condivisibili e non prerilasciabili, allora il grafo rappresenta uno stato di deadlock $\iff$ esiste un knot.

## Referenze