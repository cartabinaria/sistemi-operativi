---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 17:47:40
links:
  - "[[lecture-27022025151550|Lecture 27022025151550]]"
---
# Kernel monolitico
---
## Introduzione
E' un aggregato unico (e ricco) di procedure di gestione mutuamente coordinate e astrazioni dell’hardware.

La modularita' e' interna al codice, per cui il processo in se' e' visto come un corpo unico in esecuzione. Questo causa problemi non indifferenti: **se va in crash un modulo interno al kernel, va in crash l'intero kernel**!

Il kernel [[linux|Linux]] e' monolitico.

## Referenze