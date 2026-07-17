---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 03-05-2025 16:34:41
links:
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# Compattazione
---
## Introduzione
> La **compattazione** è una tecnica di [[gestione-della-memoria|gestione della memoria]] che consiste nel _riordinare i processi in memoria per eliminare gli spazi vuoti e migliorare l'[[allocazione|allocazione]] della memoria_. E' un metodo per mitigare il problema della [[frammentazione-esterna|frammentazione esterna]].

## Funzionamento
Se si ha [[binding|binding]] a _run-time_ possiamo fare compattazone, shiftando tutti i processi per riunire le aree inutilizzate (un [[defrag|defrag]] in [[ram|RAM]]).

Si tratta di un'operazione onerosa: non puo' essere usata in sistemi interattivi (i [[processo|processi]] devono essere fermi durante la compattazione).

## Referenze