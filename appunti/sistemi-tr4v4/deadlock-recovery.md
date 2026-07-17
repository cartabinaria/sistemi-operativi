---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 26-03-2025 10:20:30
links:
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
  - "[[lecture-13032025151745|Lecture 13032025151745]]"
---
# Deadlock recovery
---
## Introduzione
> Il **deadlock recovery** consiste in una serie di politiche implementate dai [[sistema-operativo|sistemi operativi]] a seguito di [[deadlock-detection|deadlock detection]] per risolvere il [[deadlock|deadlock]].

## Casi
Il recovery puo' essere fatto in modo:
- _manuale_ --> deve intervenire un essere umano;
- _automatico_ --> interviene automaticamente il sistema operativo.

Inoltre, per ognuno di questi modi, la terminazione dei processi in gioco puo' essere:
- _terminazione parziale_ --> viene eliminato un processo alla volta finche' non si risolve il deadlock;
- _terminazione totale_ --> vengono eliminati tutti i processi coinvolti nel deadlock.

La soluzione drastica della terminazione, pero', puo' essere in alcuni casi sostituita da metodologie di _checkpoint/rollback_: lo _stato dei processi viene periodicamente salvato sul disco, e in caso di deadlock si ripristina a uno stato precedente_. Non sempre fare cio' e' possibile, infatti i programmi possono avere effetti esterni, e ripristinarli provocherebbe discrepanze con l'esterno.

## Svantaggi
In generale il deadlock recovery non e' il massimo:
- terminare un processo puo' essere costoso;
- terminare processi può lasciare le risorse in uno stato incoerente (per esempio se viene terminato un processo nel mezzo di una [[sezione-critica|sezione critica]]).

## Referenze