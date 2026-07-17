---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 02-11-2024 18:21:27
links:
  - "[[lecture-24102024091305|Lecture 24102024091305]]"
---
# Disabilitazione degli interrupt
---
## Introduzione
> La **disabilitazione degli interrupt** è una tecnica hardware usata per risolvere il [[problema-della-sezione-critica|problema della sezione critica]].

## Idea
Nei [[cpu|processori]] single-core, i [[processo|processi]] [[esecuzione-concorrente|concorrenti]] vengono "alternati" tramite il meccanismo degli [[interrupt|interrupt]]. Allora possiamo _realizzare le [[sezione-critica|sezioni critiche]] disabilitando gli interrupt e riattivandoli subito dopo_. In questo modo un processo nella CS non potrà essere interrotto da altri processi.

## Algoritmo
```C
process P {
	while (true) {
		[disable interrupt]
		[enter cs]
		[enable interrupt]
		[exit cs]
	}
}
```

## Problemi
I problemi di questa tecnica sono i seguenti:
- _funziona solo su macchine single-core_ (non è possibile disabilitare gli interrupt di più core);
- _riduce il grado di parallelismo del processore_;
- _il [[sistema-operativo|SO]] deve lasciare ai processi la responsabilità di riattivare gli interrupt_ (pericoloso).

## Referenze