---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 18:51:18
links:
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
---
# Context switch
---
## Introduzione
A seguito di un [[interrupt|interrupt]], il [[sistema-operativo|sistema operativo]] invoca lo [[scheduler|scheduler]], e se questo decide di eseguire un altro processo, allora il processore e' soggetto al **context switch**: deve cambiare il suo stato sulla base di quello del nuovo [[pcb|PCB]].

Le operazioni da fare sono:
1. lo stato del processo attuale viene salvato nel PCB corrispondente;
2. lo stato del processo selezionato viene caricato nel PCB del processore (`LDST`);

## Referenze