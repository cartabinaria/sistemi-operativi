---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-10-2024 16:48:14
links:
  - "[[lecture-10102024092110|Lecture 10102024092110]]"
  - "[[lecture-07112024092537|Lecture 07112024092537]]"
---
# Concorrenza
---
## Introduzione
Un [[sistema-operativo|sistema operativo]] deve poter gestire più attività che sono eseguite _più o meno contemporaneamente_ dal [[cpu|processore]] e dai dispositivi presenti in un elaboratore.

E' necessario definire un _modello matematico_, basato sul concetto astratto di [[processo|processo]], che consenta di descrivere e realizzare la concorrenza tra di essi in modo coeso e rigoroso: si chiamerà **modello concorrente**.

## Definizione
> L'_insieme delle notazioni e delle tecniche per descrivere e risolvere i problemi associati all'[[esecuzione-concorrente|esecuzione concorrente]]_ di due o più programmi viene chiamata **concorrenza**.

I problemi fondamentalmente si riassumono in:
- _comunicazione_ --> passaggio di informazione da un processo all'altro;
- _sincronizzazione_ --> gestione delle dipendenze tra i processi.

La _concorrenza si trova ovunque_: in applicazioni multiple, in applicazioni strutturate su processi e nella struttura del sistema operativo stesso (come già detto in precedenza).

## Paradigmi
La concorrenza può avvenire in più connotazioni diverse:
- [[multiprogramming|Multiprogramming]]
- [[multiprocessing|Multiprocessing]]
- [[distributed-processing|Distributed processing]]

### Differenze
Tralasciando il _distributed processing_, le principali differenze tra multiprogramming e multiprocessing sono:
- _multiprogramming_
	- i processi sono alternati nel tempo (_parallelismo apparente_);
	- ad ogni istante al massimo un solo processo è in esecuzione;
	- si parla di **interleaving**;
- _multiprocessing_
	- più processi sono eseguiti simultaneamente su processori diversi (_parallelismo reale_);
	- i processi sono "alternati nello spazio";
	- si parla di **overlapping**;

Nonostante le differenze, **i due paradigmi presentano gli stessi identici problemi di concorrenza**, causati dal fatto che _non è possibile predire la velocità relativa dei processi_.

Questa serie di problematiche causate dalla concorrenza prende il nome di [[race-condition|race condition]].

## Referenze
- [[problemi-classici-della-programmazione-concorrente|Problemi classici della programmazione concorrente]]