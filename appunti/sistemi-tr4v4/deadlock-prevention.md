---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 26-03-2025 10:34:45
links:
  - "[[lecture-13032025151745|Lecture 13032025151745]]"
---
# Deadlock prevention
---
## Introduzione
> Il **deadlock prevention** e' una tecnica di gestione dei [[deadlock|deadlock]] che consiste nell'eliminazione strutturale della possibilita' che questi si verifichino. In particolare si "attacca" una delle 4 condizioni necessarie e sufficienti affinche' si verifichi un deadlock.

## Attacchi
### Mutua esclusione
Se attacchiamo la condizione di [[mutua-esclusione|mutua esclusione]], vuol dire che _ammettiamo la condivisione di risorse che per loro natura non dovrebbero essere condivisibili_ (assegnate piu' processi contemporaneamente).

Quello che di solito avviene, e' che si crea un middleware che astrae la [[risorsa|risorsa]] fisica utilizzata dando l'impressione ai processi di poterla usare contemporaneamente, ma che nella realta' implementa la mutua esclusione per il suo accesso: **spooling**.

Per esempio, il caso della stampante: si potrebbe usare una _spool di stampa_, ossia uno strato software che implementi una versione virtuale della stampante reale sempre disponibile, e che poi gestisca attraverso una coda l'invio dei documenti alla stampante[^1].

#### Problemi
Lo spooling non e' sempre applicabile (si pensi ai [[pcb|PCB]], a tutti gli effetti una risorsa). Inoltre, il problema viene spostato verso le risorse: se nel caso dello spool di stampa, due processi che vogliono stampare contemporaneamente terminano lo spazio su disco, come si gestisce? Il buffer ha una dimensione comunque limitata dalle capacita' fisiche del sistema!

### Richiesta bloccante
Attaccare la condizione di richieste bloccanti, significa far si' che ogni processo che faccia richiesta di una risorsa non immediatamente disponibile, non si blocchi. Ma ovviamente non puo': se ha bisogno della risorsa un motivo c'e', e non puo' continuare la sua esecuzione.

Per cui, l'idea sarebbe quella di determinare tutte le risorse necessarie al programma prima della sua esecuzione, e di allocargliele: **allocazione totale**. In questo modo, quando tutte le risorse necessarie sono disponibili, il processo puo' partire e _sara' garantita l'assenza di richieste bloccanti_.

#### Problemi
Assegnare un'intera gamma di risorse a un processo per tutta la sua esecuzione, significa automaticamente _ridurre il grado di parallelismo del sistema_.

Ma soprattutto, _non sempre e' noto l'insieme delle risorse richieste da un'analisi statica del programma_!

### Assenza di prerilascio
Anche questo caso non e' sempre possibile, e puo' richiedere interventi manuali.

### Attesa circolare
Togliere l'attesa circolare equivale a rompere la simmetria tra assegnazione e richiesta delle risorse.

Si implementa questa rottura della simmetria introducendo una gerarchia delle risorse: **allocazione gerarchica**. In particolare, ad ogni classe di risorse viene associato un valore di priorita', e ogni processo puo' allocare solamente risorse di priorita' superiore a quelle che gia' possiede. Di conseguenza, se un processo vuole allocare una risorsa a priorita' inferiore, deve prima rilasciare tutte le risorse con priorita' uguale o superiore a quella desiderata.

Cosi' facendo, infatti, si rende impossibile la creazione di cicli nel [[grafo-di-holt|grafo di Holt]], e quindi di [[knot|knot]].

#### Problemi
Il problema principale di questa tecnica e' che l'indisponibilità di una risorsa ad alta priorità ritarda processi che già detengono risorse ad alta priorità.

## Referenze

[^1]: alla fine e' un semplice buffer
