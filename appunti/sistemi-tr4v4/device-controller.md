---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 06-03-2025 10:33:14
links:
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
---
# Device controller
---
## Introduzione
> Un **device controller** e' una scheda elettronica di controllo di un [[device|dispositivo]] (device).

## Comunicazione con processore
Il _[[cpu|processore]] accede ai controller dei dispositivi usando indirizzi opportuni_, come se accedesse in [[memorie|memoria]] (molti degli indirizzi indirizzabili non sono in [[ram|RAM]]!).

Ci sono due principali approcci per gestire questa comunicazione:
- _programmed I/O_;
- _interrupt-driven I/O_;

Entrambi questi approcci **prevedono comunque che sia il processore a mediare lo spostamento dei dati tra i device controller e la memoria**. L'alternativa e' il [[dma|DMA]].

### Programmed I/O
Considerando per esempio l'operazione di input (verso il dispositivo), avviene che:
1. il processore carica (tramite [[bus|bus]]) i parametri della richiesta di input in appositi registri del controller (registri di comando);
2. il dispositivo esegue la richiesta, salvando il risultato in un apposito buffer locale sul controller e segnalando il completamento dell'operazione attraverso appositi registri di stato;
3. il [[sistema-operativo|SO]] attende (_busy waiting / polling_) che il comando sia completato verificando periodicamente il registro di stato del controller;
4. una volta che l'operazione e' stata completata, la CPU copia i dati dal buffer del controller alla memoria;

Si tratta di un approccio obsoleto.

### Interrupt-driven I/O
Considerando l'operazione di input, si ha in questo caso che:
1. la CPU carica (tramite il bus) i parametri della richiesta di input in appositi registri del controller (registri dei comandi);
2. il SO sospende l'esecuzione del [[processo|processo]] che ha eseguito l'operazione di input ed esegue un altro processo;
3. il dispositivo
	1. esegue la richiesta;
	2. il risultato dell'operazione viene memorizzato in un apposito buffer locale sul controller;
	3. il completamento dell'operazione viene segnalato attraverso [[interrupt|interrupt]];
4. al ricevimento dell'interrupt, la CPU copia i dati dal buffer locale del controller alla memoria;

Per l'operazione di output il procedimento e' similare a quello dell'input.

## Referenze