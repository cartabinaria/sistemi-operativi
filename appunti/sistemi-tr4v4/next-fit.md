---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 03-05-2025 17:06:59
links:
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# Next fit
---
## Introduzione
> Il **next fit** e' una variante del [[first-fit|first fit]] che consiste nella ricerca della prima area libera di memoria disponibile inizia _dalla posizione in cui l'allocazione precedente ha avuto luogo_, e non dall'inizio della lista delle aree libere.

Era stato ideato con lo scopo di ridurre la [[frammentazione-esterna|frammentazione esterna]] all'inizio della memoria, ma ha performance peggiori del first fit.

## Referenze