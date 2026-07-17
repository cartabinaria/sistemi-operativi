---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 19:49:55
links:
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
  - "[[lecture-11042025104834|Lecture 11042025104834]]"
---
# File
---
## Introduzione
> Il **file** è l'entita' atomica di assegnazione/gestione della memoria secondaria. Nella fattispecie si tratta di una collezioni di informazioni correlate.

## Attributi
Gli attributi dei file sono:
- **nome**
- **tipo**
- **locazione e dimensione**
- **data e ora**
- **proprieta'**
- **protezione**
- altri...

### Tipo
Riguardo al tipo di file, questo e' il riflesso di:
- _struttura interna_
	- senza formato, come i file di testo;
	- con formato, come i file di record, file di database, ecc...;
- _contenuto_
	- [[ascii|ASCII]];
	- sorgente;
	- eseguibile, ecc...;

A seconda del [[sistema-operativo|sistema operativo]] utilizzato, questo puo' _distinguere i tipi di file e quindi aprirli con le applicazioni "giuste" che ne riconoscono il contenuto e sono in grado di visualizzarlo nella maniera corretta_. Altri sistemi, come quelli [[unix|Unix]], _vedono invece ogni file come una sequenza di caratteri_: sta all'utente il "compito" di aprire i file con i programmi giusti.

#### Tecniche
Per identificare i tipi di file i sistemi operativi di solito si affidano a 3 tecniche:
- **[[estensione|estensioni]]**
- **attributo "tipo" associato alla directory**
- **[[magic-number|magic number]]**

#### Ulteriori tipi
Nei sistemi Unix, i tipi di file si estendono anche a:
- _file regolari_ --> sequenze di byte;
- _directory_ --> file di sistema per mantenere la struttura del file system;
- _file speciali_
	- _a blocchi_ --> usati per modellare dispositivi di [[i-o|I-O]] come i dischi;
	- _a caratteri_ --> usati per modellare dispositivi di I-O seriali, come terminali, stampanti e reti;

Nella fattispecie i file speciali contengono una coppia di indici per il [[kernel|kernel]]:
- [[device-driver|device driver]];
- unita' gestita dal device driver.

Di fatto ogni device e' gestito come un file (speciale), perche' in questo modo non c'e' bisogno di accedervi mediante [[system-call|system calls]]! Ci si accede proprio come se fossero file, interagendo con il device driver, scrivendo istruzioni su di esso e prendendo i risultati.

## Struttura
A seconda del tipo di file, questo puo' essere strutturato come:
- _sequenza di byte_;
- _sequenza di record logici_;
- _file indicizzati_ (ad [[albero|albero]]).

La gestione della struttura cambia a seconda del sistema operativo:
- **minimale** --> i file sono semplici stringhe di byte, a parte i file eseguibili cui struttura e' dettata dal sistema operativo (Unix e [[ms-dos|MS-DOS]]);
- **parte strutturata/parte a scelta dell'utente** --> (Macintosh);
- **diverse strutture di file predefinite** --> (VMS, MVS).

La scelta di gestione della struttura e' un _trade-off_:
- _piu' formati_ --> il sistema operativo ha un codice piu' ingombrante, perche' deve gestire tutti i tipi di formati almeno standard; inoltre alcuni programmi potrebbero accedere a file che hanno un formato non "supportato" dal sistema operativo; ma sicuramente la gestione e' piu' efficiente e non duplicata per i formati speciali.
- _meno formati_ --> il sistema operativo e' piu' snello.

## Metodi di accesso
Si accede a un file in modo:
- **sequenziale** (`read`, `write`);
- **ad accesso diretto** (`read pos`, `write pos`, oppure `seek`);
- **indicizzato** (`read key`, `write key`, tipico dei [[database|database]]).

### Indice
I file con metodo di accesso indicizzato, contengono un'_indice_: si tratta di una tabella di corrispondenza chiave-posizione[^1].

Questo indice, puo' essere memorizzato:
- in memoria, efficiente ma dispendioso;
- su disco.

<u>Nota bene</u>: puoi anche avere indici di indici!

## Operazioni
Le operazioni fondamentali sui file sono:
- creazione
- apertura/chiusura
- lettura/scrittura/append
- posizionamento
- cancellazione
- troncamento
- lettura/scrittura attributi

L'[[api|API]] fondamentale relativa alle operazioni sui file e' basata sulle operazioni `open` e `close`. Sulla base di queste due operazioni di base, si strutturano poi tutte le altre!

Infatti, `open` e `close`:
- mantengono l'idea "fisica" dei file (prima di farci qualunque cosa bisogna aprirli, e al termine chiuderli);
- consentono di controllare le modalita' di accesso e gestire gli accessi concorrenti;
- l'operazione `open` restituisce un _file descriptor_, fondamentale per identificare il singolo file aperto.

## Referenze
- [[directory|Directory]]
- [[semantica-della-coerenza|Semantica della coerenza]]

[^1]: una sorta di [[tabella-hash|hashmap]]
