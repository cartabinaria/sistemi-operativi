---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 25-03-2025 16:45:46
links:
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
---
# Scheduling multilivello
---
## Introduzione
> Lo **scheduling multilivello** e' l'evoluzione dello [[scheduling-a-classi-di-priorita|scheduling a classi di priorita']], in cui _ogni classe prevede un algoritmo di scheduling diverso_.

Per esempio, per le 4 classi di priorita' seguenti, in ordine decrescente di priorita', associamo degli algoritmi specifici:
- _processi server_ --> priorità statica;
- _processi utente interattivi_ --> [[round-robin|round-robin]];
- _altri processi utente_ --> FIFO ([[fcfs|FCFS]]);
- _processo vuoto_ --> FIFO banale;

In tali sistemi, ogni sottocoda (classe) vuota crea un processo vuoto che serve a mettere in `WAIT` lo scheduler.

## Referenze