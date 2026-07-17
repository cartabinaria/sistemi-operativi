---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 19-03-2025 19:10:17
links:
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
---
# Scheduling a priorita'
---
## Introduzione
Abbiamo visto con l'[[algoritmo|algoritmo]] di [[scheduling|scheduling]] [[round-robin|Round-Robin]] che sorge una sorta di **democrazia tra i processi**: _a tutti quanti viene assegnato uno stesso quanto di tempo massimo di CPU burst_. Ma la realta' dei fatti e' che **non tutti i processi sono uguali**. In particolare, alcuni sono piu' importanti di altri.

Esistono quindi degli algoritmi di scheduling che supportano priorita':
- _definite dal sistema_ --> sono usate quantita' misurabili per calcolare la priorita' di un processo (un po' come nell'[[sjf|SJF]], in cui la priorita' e' il CPU burst);
- _definite esternamente_ --> sono usate quantita' imposte dal livello utente (per esempio con la [[system-call|system call]] `NICE`); [[unix|Unix]] di base da' priorita' massima ai processi utente.

## Tipologie
La definizione della priorita' per ogni processo puo' essere:
- **statica** --> potrebbe causare [[starvation|starvation]] per i processi a bassa priorità;
- **dinamica** --> si possono sfruttare metodologie di priorità dinamica per evitare starvation.

In particolare quest'ultima si puo' implementare mediante _aging_: si incrementa gradualmente la priorita' dei processi in attesa. Se si assume che la variazione delle priorità sia limitata, nessun processo rimarrà in attesa per un tempo indefinito perché prima o poi raggiungerà la priorità massima (no starvation!).

Di solito, pero', si tendono a privilegiare tecniche piu' sofisticate, come:
- [[scheduling-a-classi-di-priorita|Scheduling a classi di priorita']];
- [[scheduling-multilivello|Scheduling multilivello]].

## Referenze