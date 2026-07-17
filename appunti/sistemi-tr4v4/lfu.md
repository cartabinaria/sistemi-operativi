---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 16:52:21
links:
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# LFU
---
## Introduzione
> L'**LFU** (_Least Frequently Used_) è un [[algoritmi-di-paginazione|algoritmo di paginazione]] che _sceglie come pagina vittima quella con minor frequenza di accesso_.

## Implementazione
Si implementa mantenendo un contatore del numero di accessi, e dividendo questo per il tempo di permanenza in memoria: cosi' si ottiene una frequenza media di accesso.

Ha senso: _una pagina utilizzata spesso dovrebbe avere un contatore molto alto_; viene quindi scelta come vittima una pagina con frequenza di accesso bassa.

Nella pratica si puo' approssimare implementandolo con un _reference bit_ (come avviene per l'[[lru|LRU]]).

## Referenze