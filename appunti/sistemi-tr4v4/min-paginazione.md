---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 13:36:23
links:
  - "[[lecture-21032025091929|Lecture 21032025091929]]"
---
# MIN paginazione
---
## Introduzione
> Il **MIN paginazione** e' un [[algoritmi-di-paginazione|algoritmo di paginazione]] che _seleziona come pagina vittima quella che non verra' piu' acceduta o che verra' acceduta nel futuro piu' lontano_.

## Osservazioni
Si dimostra che questo algoritmo e' ottimale, perche' minimizza il numero di [[page-fault|page fault]]. Tuttavia e' irrealizzabile: _dovremmo prevedere la stringa di riferimenti dei [[processo|processi]]_.

Ma non e' da scartare completamente! Infatti _ci fornisce un bound minimo per il numero di page fault che possiamo ottenere con gli altri algoritmi_.

## Referenze