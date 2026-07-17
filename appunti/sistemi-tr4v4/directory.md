---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 18-06-2025 19:24:48
links:
  - "[[lecture-11042025104834|Lecture 11042025104834]]"
  - "[[lecture-23042025152007|Lecture 23042025152007]]"
---
# Directory
---
## Introduzione
> Le **directory** rappresentano un'_astrazione di un insieme di [[file|file]]_.

## Operazioni
Sulle directory si possono fare le seguenti operazioni:
- creazione
- cancellazione
- apertura di una directory
- chiusura di una directory
- lettura di una directory
- rinominazione
- link/unlink

## Struttura
Una directory puo' essere strutturata:
- a livello singolo
- a due livelli
- ad albero
- a [[grafo-aciclico|grafo aciclico]]
- a [[grafo|grafo]]

Di solito, le directory si strutturano sempre ad albero:
![[directory-ad-albero.png]]

Tuttavia, ci sono sistemi operativi che supportano una struttura a grafo aciclico. In tal caso, **uno stesso file puo' essere contenuto in due o piu' directory**. Ovviamente il file e' sempre uno, per cui ogni modifica al file e' visibile in tutte le directory a cui appartiene.
![[directory-a-grafo-aciclico.png]]

## Implementazione
Una directory e' un file speciale contenente informazioni sui file contenuti nella directory. Ogni directory e' suddivisa in un certo numero di _directory entry_. Ogni direcctory entry deve consentire di accedere a tutte le informazioni necessarie per gestire il file:
- nome
- attributi
- informazioni di allocazione

Si possono implementare le directory come:
- _attributi dei file all'interno delle directory entry_ o nell'_i-node_;
- _lista lineare_ (array) o _hashtable_.

#### Informazioni nelle directory entry
La directory entry contiene tutte le informazioni necessarie associate a un file (i suoi attributi).

Usato in MS-DOS.

#### Informazioni negli i-node
La directory entry contiene solo nome e i-node associato: le informazioni sono contenute negli i-node.

Utilizzata in Unix.

#### Problema dei nomi
Sia che tu salvi le informazioni direttamente nelle directory entry, sia che tu lo faccia negli i-node, _gestire file con nomi a lunghezza variabile non e' semplice_, e se si sceglie di memorizzare una lunghezza fissa per ogni file si rischia di sprecare memoria o di avere nomi troppo piccoli.

![[directory-nomi-dinamici.png]]

#### Lista lineare
E' semplice da implementare, ma inefficiente nel caso di directory di grandi dimensioni.

#### Hashtable
Bisogna fare i conti con tutti i problemi legati al mondo delle [[funzione-hash|funzioni hash]], come le [[collisione-hash|collisioni]]!

#### A grafo aciclico
In file system che lo supportano, le directory possono anche essere implementate come grafo aciclico, mediante:
- **[[link-simbolico|link simbolici]]**
- **[[link-fisico|link fisici]]**

<u>Nota bene</u>: una struttura del genere e' di certo piu' flessibile di un albero, ma introduce una serie di problematiche nuove. Per questo molti sistemi non supportano file system DAG.

## Referenze