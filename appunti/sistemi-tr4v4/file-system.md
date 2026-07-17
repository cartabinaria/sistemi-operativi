---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 17:27:37
links:
  - "[[lecture-27022025151550|Lecture 27022025151550]]"
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
  - "[[lecture-23042025152007|Lecture 23042025152007]]"
---
# File system
---
## Introduzione
> Un **file system** e' un insieme di [[file|file]] e [[directory|directory]], gestito dal [[sistema-operativo|sistema operativo]].

## Tipologie
Ci sono diversi file system: FAT (per le chiavette, efficiente per l'accesso sequenziale), ext4 (Linux, efficiente per accesso diretto), NTFS (Windows), ISO (usato nei CD, per sola lettura).

## Implementazione
Un file system si costruisce implementendo:
- organizzazione del disco
- allocazione dello spazio in blocchi
- gestione spazio libero
- implementazione delle directory
- tecniche per ottimizzare le prestazioni
- tecniche per garantire la coerenza

### Organizzazione del disco
Un disco puo' essere diviso in piu' _[[partizione-di-un-disco|partizioni]]_, porzioni indipendenti del disco che possono anche ospitare file system differenti.

Di solito, il primo settore dei dischi e' il [[mbr|MBR]] (Master Boot Record), oggi sostituito in gran parte da [[gpt|GPT]].

### Allocazione
Come l'[[allocazione|allocazione]] e' un problema per la [[ram|memoria primaria]], lo e' anche per i file system in memoria secondaria, anche se in modo diverso: l'hardware e il driver del disco virtualizzano il disco come un insieme di blocchi di dimensione fissa, **bisogna pero' capire come implementare l'astrazione di file**. Come vengono scelti i blocchi dati da utilizzare per un file? Come vengono collegati insieme questi blocchi per formare una struttura unica?

#### Allocazione contigua
I file sono memorizzati in sequenze contigue di blocchi di dischi.

Vantaggi:
- e' efficiente perche' se l'accesso e' sequenziale i blocchi contigui non necessitano di operazioni di seek (in caso di [[hd|HD]]);
- anche l'accesso diretto e' efficiente.

Svantaggi:
- si ripropongono tutti i problemi dell'[[allocazione-dinamica|allocazione dinamica]] della memoria primaria, quindi _[[frammentazione|frammentazione]] e politiche di scelta dei blocchi liberi_;
- per _aumentare la dimensione di un file devo riallocare l'intero file da un'altra parte_!

Notare come quest'ultimo problema e' proprio la ragione per cui sono nate le [[lista|liste]] come [[struttura-dati|struttura dati]]: in un [[array|array]] se volevo inserire un elemento in mezzo dovevo spostare tutta la parte restante avanti.

Chiaramente, in file system di sola lettura risulta ottimo.

#### Allocazione concatenata
Un file e' visto come una _lista concatenata di blocchi_. Ogni blocco contiene un puntatore al blocco successivo del file. Il _file descriptor_, quindi, contiene solo i puntatori al primo e all'ultimo elemento della lista (posizione nel disco).
![[allocazione-concatenata.png]]


<u>Nota bene</u>: il motivo per cui nel file descriptor si mantiene anche il puntatore all'ultimo blocco del file, e' perche' in questo modo e' piu' veloce scrivere in fondo al file, aumentandone il contenuto (`append`, accedi direttamente all'ultimo blocco). 

Questo tipo di allocazione causa un _tipo di frammentazione differente da quella nota_: **i blocchi di un file si trovano in posizioni disparate del disco, quindi anche un semplice accesso sequenziale diventa lentissimo**.

Per questa ragione, ogni tanto bisogna fare [[defrag|defrag]].

Vantaggi:
- chiaramente risolve il problema della frammentazione esterna;
- l'accesso sequenziale o in `append`-mode e' efficiente;

Svantaggi:
- l'accesso diretto e' inefficiente;
- la degradazione dell'efficienza del file system richiede defrag;
- la dimensione utile di un blocco non e' una potenza di due;
- se il blocco e' piccolo l'overhead per i puntatori puo' essere rilevante;

Per diminuire l'overhead dei puntatori, infatti, si possono riunire i blocchi in _cluster_, ossia 4, 8 o 16 blocchi _allocati in modo sequenziale e indivisibile_. In questo modo ci sono meno puntatori, ma si rischia di sprecare piu' spazio per la frammentazione interna (sui blocchi dell'ultimo cluster).

#### Allocazione basata su FAT
E' una versione dell'allocazione concatenata ma piu' furba: invece che usare i blocchi stessi per contenere il puntatore al blocco successivo, **si crea una tabella unica con un elemento per blocco, ossia il puntatore a quello successivo**.

Vantaggi:
- i blocchi sono interamente dedicati ai dati;

Svantaggi:
- la scansione richiede anche la lettura della FAT --> risolvibile con [[cache|caching]] dei blocchi FAT, che anzi rende anche piu' efficiente l'accesso diretto in quanto si scorre la memoria primaria!

Questo tipo di allocazione e' quella usata dalle chiavette USB.

#### Allocazione indicizzata
L'**elenco dei blocchi che compongono un file viene memorizzato in un blocco** (o area) **indice**. Per accedere al file si carica in memoria la sua area indice e si utilizzano i puntatori in essa contenuti.
![[allocazione-indicizzata.png]]

Vantaggi:
- risolve la frammentazione esterna;
- e' efficiente per l'accesso diretto;
- il blocco indice e' caricato in memoria solo quando il file e' aperto;

Svantaggi:
- _la dimensione del blocco indice determina l'ampiezza massima del file_, e _usare blocchi indice troppo grandi comporta un notevole spreco di spazio_;

Quest'unico svantaggio si puo' pensare di risolverlo facendo **concatenazione di blocchi indice**: in particolare _l'ultimo elemento di un blocco indice punta al blocco indice successivo_. Il problema di questo approccio e' che ritorna il problema dell'accesso diretto per file di grandi dimensioni.

Un altro sistema puo' essere quello degli **indici multilivello**: si usa un _blocco indice dei blocchi indice_. Il problema e' che degradano le prestazioni, perche' un singolo accesso puo' richiedere piu' accessi ai blocchi indice.

#### Caso Unix
In Unix si usano gli indici multilivello ma in modo intelligente. In particolare ogni file e' associato a un **i-node** (_index node_), una struttura contenente gli attributi dei file, ma soprattutto un _indice di blocchi diretti e indiretti_:
![[i-node.png]]

Questo schema garantisce buone performance nel caso sequenziale, e i file brevi sono acceduti piu' velocemente e occupano meno memoria.

Per migliorare ulteriormente le prestazioni si puo' fare:
- pre-caricamento (caching come per l'allocazione FAT);
- combinazione dell'allocazione contigua e indicizzata (contigua per piccoli file, indicizzata per grandi file, indicizzata di chunk contigue come in `ext4`).

### Gestione spazio libero
Anche nei file system, come per la memoria primaria, e' necessario avere una struttura dati che tenga conto di quali blocchi siano liberi.

#### Bitmap
Ad ogni blocco corrisponde un bit in una _bitmap_: 0 se libero, 1 se occupato.

Vantaggi:
- e' semplice selezionare aree contigue;

Svantaggi:
- la memorizzazione del vettore puo' richiedere molto spazio (a seconda della dimensione dei blocchi);

#### Lista concatenata
I blocchi liberi sono mantenuti in una lista concatenata. E' perfettamente integrabile in un sistema di tipo [[fat|FAT]]: nella tabella i blocchi liberi contengono dei puntatori ad altri blocchi liberi, e c'e' un puntatore al primo blocco libero.

Vantaggi:
- richiede poco spazio in memoria centrale;

Svantaggi:
- l'allocazione di un'area di ampie dimensioni e' costosa;
- l'allocazione di aree libere contigue e' molto difficoltosa;

#### Lista concatenata a cluster
E' una lista concatenata di blocchi che contengono puntatori a blocchi liberi:
![[lista-concatenata-a-cluster.png]]

Vantaggi:
- ad ogni istante si puo' mantenere in memoria anche solo un blocco di blocchi liberi;
- non e' necessaria una struttura dati esterna, i blocchi liberi possono contenere i puntatori agli altri blocchi liberi e al blocco di blocchi liberi successivo;

Svantaggi:
- l'allocazione di un'area di ampie dimensioni e' costosa;
- l'allocazione di aree libere contigue e' molto difficoltosa;

### Dimensione dei cluster
Sia per quanto riguarda l'allocazione che la gestione dei blocchi liberi, si possono raccogliere gruppi di blocchi in cluster per minimizzare l'overhead dei puntatori.

Tuttavia:
- cluster grandi --> velocita' di lettura alta, maggiore frammentazione interna;
- cluster piccoli --> velocita' di lettura piu' bassa, minore frammentazione interna.

### Tecniche per migliorare le performance
![[file-system-migliorare-performance.png]]

### Tecniche per garantire la coerenza
I meccanismi di caching sopra citati possono causa inconsistenze nel file system, per esempio a seguito dell'interruzione di corrente. Il problema si pone nelle zone critiche quali:
- FAT (per gestione dei blocchi occupati)
- bitmap (per gestione dei blocchi liberi)
- i-node (per memorizzare le informazioni sui file)
- directory (per memorizzare gli i-node)

Le possibili soluzioni sono:
- _curare_ --> attraverso _file system checkers_
- _prevenire_ --> attraverso _file system journaling_

#### `fsck`
Si tratta di un file system checkers, che:
1. scandisce la tabella degli i-node e controlla le incoerenze
2. controlla dir, affinché puntino a i-node legali
3. scandisce l'albero per vedere se tutti i file sono raggiungibili
4. verifica il numero di riferimenti di ogni file
5. verifica gli i-node e blocchi liberi-occupati
6. aggiorna le tabelle per salvare i cambiamenti

#### `log`
I file system basati su log vedono ogni aggiornamento come una _transazione_, ossia un'operazione [[azione-atomica|atomica]]. Questo, seppur inficiando sulle performance, consente di ripristinare rapidamente il sistema a uno stato coerente.

Nella fattispecie tutte le transazioni sono memorizzate in un log. Una transazione e' considerata completata solo dopo che e' stata salvata nel log, _pur non avendo toccato ancora il file system_. Periodicamente, le transazioni nel log vengono effettuate nel file system, e quindi le transazioni sono rimosse dal log.

In caso di errore, tutte le transazioni nel log vengono ripetute (perche' sono quelle che non sono state registrate ancora nel file system).

## Referenze