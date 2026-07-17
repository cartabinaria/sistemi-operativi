---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 19:08:56
links:
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# RAID 0
---
## Introduzione
> Il **RAID 0** è una configurazione di [[raid|RAID]] che utilizza la _striping_ per _distribuire i dati su più dischi_, senza alcuna ridondanza. Nella fattispecie, i _dati vengono suddivisi in blocchi e distribuiti uniformemente tra i dischi, migliorando le prestazioni di lettura e scrittura_.

Questo e' vantaggioso per sistemi che non richiedono affidabilita', e per richieste che riguardano blocchi indipendenti di dati (che possano quindi essere gestite in parallelo).

![[raid-0.png]]

## Referenze