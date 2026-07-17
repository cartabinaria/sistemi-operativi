---
tags:
  - "#category/note"
  - "#status/finished"
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 22-09-2023 19:09:21
links:
  - "[[lecture-20092023151652|Lecture 20092023151652]]"
  - "[[lecture-25092023130405|Lecture 25092023130405]]"
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# I-O
---
## Introduzione
I dispositivi di input e output, anche dette **periferiche**, interagiscono con l'elaboratore per mezzo di speciali _controllori_, che fungono da mediatore per l'invio e/o la ricezione di dati da un senso verso l'altro.

Alcuni controller accedono direttamente alla memoria attraverso il meccanismo [[dma|DMA]] (Direct Memory Access), inviando al termine della scrittura/lettura un _[[interrupt|interrupt]]_ alla [[cpu|CPU]].

![[kernel-i-o.png]]

### Esempi
- tastiera
- mouse
- monitor (richiede scheda video con [[gpu|GPU]])
- stampanti
- schede di rete

## Classificazione
I sistemi di I/O possono essere classificati in base a:
- _modalita' di trasferimento_
	- caratteri (es. tastiera) --> i dati sono letti/scritti un carattere alla volta
	- blocchi (es. disco) --> i dati sono letti/scritti in blocchi di dimensione fissa (512-1024 bytes)
- _modalita' di accesso_
	- sequenziale (es. tastiera) --> i dati sono letti/scritti in sequenza
	- random (es. disco) --> i dati possono essere letti/scritti in modo casuale
- _trasferimento_
	- sincrono --> flusso continuo di dati
	- asincrono --> se non viene usato non c'è flusso di dati, la comunicazione tace
- _condivisione_
	- dedicato --> un dispositivo è dedicato a un solo processo
	- condivisibile --> un dispositivo può essere condiviso tra più processi
- _velocita'_
- _direzione_
	- sola lettura
	- sola scrittura

## Gestione dei dispositivi
La gestione dei dispositivi di I/O è una delle responsabilità principali del [[sistema-operativo|sistema operativo]]. Essa comprende:
- **buffering** --> per dispositivi lenti non si trasmette una cosa alla volta, si bufferizzano le cose e poi si trasferiscono per rendere le cose più veloci
	- questo ha senso quando c'e' una notevole differenza di velocita' tra produttore e consumatore (es. disco e CPU)
- **caching** --> mantenere una copia in memoria primaria di informazioni che si trovano in memoria secondaria
	- e' diverso dal buffering! Il caching e' una copia di dati, mentre nel buffer si trova l'unica istanza di dati
- **spooling** --> memorizzare i dati in un buffer temporaneo prima di inviarli al dispositivo di I/O
	- fondamentalmente è un buffer che mantiene output per un dispositivo che non può accettare flussi di dati distinti, come nel caso delle stampanti[^1]
- **I/O scheduling** --> pianificare l'ordine in cui i processi accedono ai dispositivi di I/O

## Referenze

[^1]: l'abbiamo gia' affrontato nell'ambito del [[deadlock-prevention|deadlock prevention]], in particolare col tentativo di eliminare la [[mutua-esclusione|mutua esclusione]] delle risorse
