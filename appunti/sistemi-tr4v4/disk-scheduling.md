---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 18:33:37
links:
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# Disk scheduling
---
## Introduzione
> Il **disk scheduling** e' una classe di [[algoritmo|algoritmi]] di [[scheduling|scheduling]] utilizzati per gestire le richieste pendenti di un [[hd|HD]] in modo da minimizzare le _seek_, ossia le operazioni che richiedono piu' tempo.

## Algoritmi
Gli algoritmi di disk scheduling piu' comuni sono:
- [[fcfs|FCFS]], non minimizza il numero di seek ma non puo' mai generare [[starvation|starvation]] (e' una politica di gestione fair);
- [[sstf|SSTF]];
- [[look|LOOK]];
- [[c-look|C-LOOK]].

## Referenze