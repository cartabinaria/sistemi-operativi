---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 18:42:55
links:
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
---
# Scheduler
---
## Introduzione
> Lo **scheduler** e' il componente piu' importante del [[kernel|kernel]], che _gestisce l'avvicendamento dei [[processo|processi]]_, assegnando la [[cpu|CPU]] di volta in volta a un processo secondo le politiche di [[scheduling|scheduling]] adottate.

## Funzionamento
In particolare, quando viene invocato dal [[sistema-operativo|sistema operativo]], decide quale processo viene mandato in esecuzione. Interviene:
- a seguito di una richiesta di un'operazione di [[i-o|I-O]];
- quando un'operazione di I-O termina (scatenando un [[interrupt|interrupt]]);

<u>Nota bene</u>: in quest'ultimo caso e' incluso quello dell'[[interval-timer|interval timer]], che si comporta come un device di I-O.

## Referenze
- [[context-switch|Context switch]]