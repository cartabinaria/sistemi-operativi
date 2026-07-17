---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 20:24:01
links:
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
---
# Round-Robin
---
## Introduzione
> Il **Round-Robin** e' un [[algoritmo|algoritmo]] di [[scheduling|scheduling]] _preemptive_, che prevede che _ogni processo non possa rimanere in esecuzione per un tempo superiore alla durata di un quanto di tempo prestabilito_.

Si tratta di un algoritmo di scheduling **democratico**: tutti i processi sono visti allo stesso modo, e ad ognuno e' assegnato uno stesso quanto di tempo massimo di CPU burst consecutivo.

## Funzionamento
I processi in esecuzione:
- posso lasciare il processore volontariamente, in seguito ad un'operazione di [[i-o|I-O]] o per terminazione;
- possono esaurire il quanto di tempo senza completare il CPU burst, nel qual caso viene rimesso in fondo alla _ready queue_;

## Quanto di tempo
Il quanto di tempo (o _quantum slice_) e' un parametro "hardware": sara' scandito dall'[[interval-timer|interval timer]], che agisce come "sveglia" del processore. E' critico:
- se è troppo basso faccio troppi [[context-switch|context switch]] di seguito (che occupano del tempo);
- se è troppo alto si paga in responsività dei programmi;

## Referenze