---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/linguaggi-di-programmazione
  - topic/sistemi-operativi
date: 24-11-2023 16:52:55
links:
  - "[[lecture-20112023130829|Lecture 20112023130829]]"
  - "[[lecture-26022025111603|Lecture 26022025111603]]"
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# Frammentazione interna
---
## Introduzione
> La **frammentazione interna** è una [[frammentazione|frammentazione]] della [[ram|RAM]], causata dalla [[gestione-della-memoria|gestione della memoria]] e in particolare dai meccanismi di [[allocazione|allocazione]].

Se un programma necessita di una _quantità di memoria che non è un multiplo della dimensione delle pagine_, una di queste verrà usata solo in parte, _lasciando "sprecata" una certa porzione di memoria_.

Formalmente, se lo spazio richiesto e' `X`, e gli si assegna un blocco di dimensione `Y > X`, allora si spreca `Y - X` spazio.

<u>Nota bene</u>: questo fenomeno si verifica al livello del [[sistema-operativo|sistema operativo]] ma anche a livello di [[linguaggio-di-programmazione|linguaggio di programmazione]].

## Referenze