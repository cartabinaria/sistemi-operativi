---
tags:
  - category/note
  - status/finished
  - topic/linguaggi-di-programmazione
  - topic/sistemi-operativi
  - topic/ingegneria-del-software
date: 20-02-2025 09:55:09
links:
  - "[[lecture-19022025111150|Lecture 19022025111150]]"
  - "[[lecture-13032025151745|Lecture 13032025151745]]"
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
  - "[[lecture-22092025100902|Lecture 22092025100902]]"
---
# Binding
---
## Introduzione
> Il **binding** (o **legame**), nell'ambito dei [[linguaggio-di-programmazione|linguaggi di programmazione]], e' l'_associazione tra [[nome|nome]] e [[oggetto-denotabile|oggetto denotabile]]_.

## Binding time
Il binding puo' fondamentalmente essere:
- _statico_ --> a compile-time
	- per la struttura del linguaggio (es. i tipi primitivi)
	- per la struttura del programma (es. i nomi delle variabili globali)
- _dinamico_ --> a run-time
	- durante l'esecuzione si legano tutti i nomi non ancora legati (es. le variabili locali ai [[blocco|blocchi]])

Inoltre, per la valutazione delle funzioni da eseguire in [[linguaggio-di-programmazione-orientato-a-oggetti|linguaggio di programmazione orientato a oggetti]], esistono:
- [[early-binding|early binding]]
- [[late-binding|late binding]]

## Basso livello
A piu' basso livello non ci interessa il modo in cui viene risolto un nome non appartenente all'[[ambiente|ambiente]] locale, ma _a quale indirizzo fisico viene associato ogni indirizzo logico_ (nome). Anche in questo caso si tratta comunque di binding.

Le associazioni tra indirizzi logici e fisici puo' avvenire:
- a **compile-time**
- a **load-time**
- a **run-time**

### Compile-time
In questo caso gli indirizzi sono calcolato al momento della [[compilazione|compilazione]], e _resteranno gli stessi per ogni esecuzione del programma_. Il codice generato, infatti, si dice **assoluto**.

E' molto facile e veloce, ma banalmente _non puo' funzionare con la [[multiprogramming|multiprogrammazione]]_: due processi non possono eseguire contemporaneamente lo stesso programma!

L'unico codice sensato il cui binding sia risolto a compile-time, e' quello del [[kernel|kernel]].

### Load-time
In questo caso ogni indirizzo durante il caricamento viene traslato sulla base dell'indirizzo di partenza su cui viene allocato. In particolare, il [[loader|loader]] si occupa di _tradurre ogni indirizzo logico del programma nell'indirizzo fisico sommandoci l'offset iniziale della porzione di [[ram|RAM]] su cui sara' caricato_. Il codice generato si dice **rilocabile**.

Permette di gestire la multiprogrammazione e non richiede dell'hardware specifico, ma tutti gli indirizzi devono essere tradotti dal loader.

### Run-time
In questo ultimo caso, il [[compilatore|compilatore]] compila in _codice assoluto_, e il loader non aggiunge alcun offset agli indirizzi: _ogni volta che il processo genera un indirizzo, questo viene tradotto a run-time dalla [[mmu|MMU]], che trasforma l'indirizzo logico in fisico_.

<u>Nota bene</u>: gli [[indirizzo-fisico|indirizzi fisici]] sono quelli in [[ram|RAM]], quelli [[indirizzo-logico|logici]] sono quelli gestiti dalla MMU. _Ogni processo e' associato a uno spazio di indirizzamento logico, e gli indirizzi usati da un processo sono tutti logici_.

## Referenze