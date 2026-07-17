---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 18:27:13
links:
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
---
# Scheduling
---
## Introduzione
> Lo **scheduling** e' l'azione di fare uno _schedule_, ossia una sequenza temporale di assegnazioni delle risorse da gestire ai richiedenti. Viene realizzato dallo [[scheduler|scheduler]].

Per rappresentare ogni schedule si utilizza un [[diagramma-di-gantt|diagramma di Gantt]].
![[scheduling-diagramma-di-gantt.png]]

## Tipologie
Per poter parlare delle varie tipologie di scheduling, e' necessario riassumere in quali casi viene scatenato un [[context-switch|context switch]]:
1. quando un processo passa _da stato running a waiting_;
2. quando un processo passa _dallo stato running allo stato ready_;
3. quando un processo passa _dallo stato waiting allo stato ready_;
4. quando un processo _termina_.

Allora, uno scheduler si dice:
- **cooperativo** se i context switch avvengono solo nelle condizioni 1 e 4 --> _il controllo della risorsa viene trasferito solo se l'assegnatario attuale lo cede volontariamente_, o chiedendo un'operazione di [[i-o|I-O]], o terminando;
- **preemptive** se i context switch avvengono in ogni condizione --> _il controllo della risorsa puo' essere tolto all'assegnatario attuale a causa di un evento esterno_, senza la sua cooperazione.

Tutti gli scheduler moderni sono di tipo preemptive! Questo perche' permette di usare al meglio le risorse.

### Criteri di scelta
Scegliere uno scheduler piuttosto che un altro dipende da una serie di criteri:
- _utilizzo della risorsa CPU_ --> dev'essere massimizzato;
- _throughput_ --> numero di processi completati per unità di tempo (dipende dalla lunghezza dei processi), dev'essere massimizzato;
- _tempo di turnaround_ --> tempo che intercorre dalla sottomissione di un processo alla sua terminazione, dev'essere minimizzato;
- _tempo di attesa_ --> tempo trascorso da un processo nella ready queue, dev'essere minimizzato;
- _tempo di prima risposta_ --> tempo che intercorre tra la sottomissione di un processo e il tempo di prima risposta, significativo nei programmi interattivi, dev'essere minimizzato;

## Algoritmo
### Nozioni
Per poter analizzare gli algoritmi di scheduling, e' prima necessario dare alcune definizioni sulle caratteristiche dei processi:
- **CPU burst**, periodi di attività della [[cpu|CPU]];
- **I/O burst**, periodi di attività di I/O;
- **CPU bound**, processi caratterizzati da tempi di CPU burst molto lunghi;
- **I/O bound**, processi caratterizzati da tempi di I/O burst molto lunghi;

### Algoritmi
Gli algoritmi di scheduling principali sono:
- [[fcfs|FCFS]]
- [[sjf|SJF]]
- [[round-robin|Round-Robin]]

## Categorie
Delle categorie di scheduling sono:
- [[scheduling-a-priorita|Scheduling a priorita']]
- [[scheduling-a-classi-di-priorita|Scheduling a classi di priorita']]
- [[scheduling-multilivello|Scheduling multilivello]]
- [[scheduling-real-time|Scheduling real-time]]

## Referenze