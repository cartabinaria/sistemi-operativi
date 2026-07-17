---
tags:
  - "#category/note"
  - "#status/finished"
  - topic/programmazione
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 18-09-2023 22:06:44
links:
  - "[[lecture-18092023150410|Lecture 18092023150410]]"
  - "[[lecture-20092023091613|Lecture 20092023091613]]"
  - "[[lecture-20092023151652|Lecture 20092023151652]]"
  - "[[lecture-16102023125805|Lecture 16102023125805]]"
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
---
# RAM
---
## Definizione
> La **RAM** (_Random Access Memory_) è quella componente hardware di un elaboratore che ha il compito di _memorizzare i programmi in esecuzione_.

La RAM è una **sequenza di locazioni**, cui ognuna:
- è di 1 byte
- è identificata da un _indirizzo_

Per uno stesso dato possono quindi servire più indirizzi, più blocchi di byte (_contigui_), e per riferirci a quel dato faremo riferimento al primo indirizzo di memoria.

La RAM alla fine è solo un contenitore di byte, che di per sé non hanno significato: **ciò che interpreta nella maniera corretta i dati in memoria è l'istruzione**, e quindi nel suo complesso il **programma**.

Infatti una locazione di RAM può significare:
- interi
- decimali
- ecc...

ed è l'istruzione che ne interpreta il significato voluto.

## Composizione
La RAM si compone di _celle_, solitamente oggigiorno a **32** o a **64 bit**. In entrambi i casi, il numero di bit di ogni cella di RAM corrisponderà con il numero di dati trasportabili sui rispettivi bus (_indirizzo_, _dati_).

A queste celle, o meglio _locazioni_ (a seconda del [[tipi-di-dato|tipo di dato]]), vengono assegnati **valori che possono essere principalmente dati o istruzioni**. Nello specifico, ogni programma in esecuzione in RAM sarà diviso in una sezione dedicata alle istruzioni (_TEXT_) e in un'altra sezione dedicata ai dati (_DATA_), in questo modo:
![[ram-sezioni.png]]

## Implementazione
Nel dettaglio la RAM si compone di:
- [[w-bit-register|w-bit register]], in accordo quindi con la [[circuiti-sequenziali-schema-realizzativo|struttura standard dei circuiti sequenziali]]
- **Direct Access Logic**, una componente che
	- se `load=1` allora fa puntare il valore di `in` solo al _w-bit register_ a cui punta `address`[^1]
	- se `load=0` allora mette in `out` solo il valore del _w-bit register_ a cui punta `address`[^2]

![[implementazione-ram.png]]

## Accesso
L'accesso alla RAM avviene mediante le istruzioni `LOAD` e `STORE`. Nei sistemi moderni, inoltre, ci si accede tramite [[mmu|MMU]].

## Referenze
[^1]: userà un [[demultiplexer|Demultiplexer]]
[^2]: userà un [[multiplexer|Multiplexer]]