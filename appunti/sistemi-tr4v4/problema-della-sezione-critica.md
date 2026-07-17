---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 24-10-2024 00:17:37
links:
  - "[[lecture-17102024091631|Lecture 17102024091631]]"
  - "[[lecture-24102024091305|Lecture 24102024091305]]"
---
# Problema della sezione critica
---
## Introduzione
> Il **problema della [[sezione-critica|sezione critica]]** (o **CSP**) consiste nel realizzare $N$ [[processo|processi]] della forma
> ```R
> process P_i {
> 	while (true) {
> 		[enter cs]
> 		# critical section
> 		[exit cs]
> 		# non-critical section
> 	}
> }
> ```
> tale che valga:
> 1. _[[mutua-esclusione|mutua esclusione]]_ - solo un processo alla volta dev'essere dentro la CS fra tutti quelli che hanno una CS per la stessa risorsa condivisa;
> 2. _assenza di [[deadlock|deadlock]]_;
> 3. _assenza di [[starvation|starvation]]_ - ogni processo che lo richiede, prima o poi entra nella CS;
> 4. _assenza di delay non necessari_ - un processo fuori dalla CS non deve ritardare l'ingresso della CS da parte di un altro processo.

## Soluzioni
Il problema della sezione critica si può risolvere:
- via _software_
- via _hardware_

### Software
Lato software viene implementato il blocco `[enter cs]` ed `[exit cs]` con una libreria. Nonostante l'interesse didattico, queste soluzioni sono soggette ad errori e costose in termini di esecuzione (_busy waiting_).

Gli [[algoritmo|algoritmi]] in questione sono:
- [[algoritmo-di-dekker|algoritmo di Dekker]]
- [[algoritmo-di-peterson|algoritmo di Peterson]]

### Hardware
Lato hardware vengono fornite istruzioni hardware speciali per semplificare la realizzazione delle sezioni critiche. Nonostante la loro _efficienza_, in quanto _legate all'hardware su cui sono implementate non sono soluzioni general-purpose_. Inoltre non garantiscono l'assenza di starvation né eliminano il busy waiting, e sono complesse da programmare.

Le tecniche in questione sono:
- [[disabilitazione-degli-interrupt|disabilitazione degli interrupt]]
- [[spinlock|spinlock]]

### Realtà
Nella realtà dei fatti, esistono dei paradigmi che risolvono in modo elegante ed estremamente semplice il problema della sezione critica:
- [[semafori|semafori]]
- [[monitor|monitor]]
- [[message-passing|message passing]]

## Referenze