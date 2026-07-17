---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 03-05-2025 15:54:24
links:
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# Allocazione
---
## Introduzione
> L'**allocazione** e' una delle funzioni principali del [[gestione-della-memoria|gestore della memoria]], e consiste fondamentalmente nel _reperire e assegnare uno spazio di memoria fisica a un [[programma|programma]] che viene attivato, o a un [[processo|processo]] che richiede memoria_.

## Tipologie
L'allocazione puo' essere:
- **contigua** --> tutto lo spazio assegnato a un processo deve essere formato da _celle consecutive_;
- **non contigua** --> lo spazio assegnato a un processo puo' essere formato da _aree di memoria separate_;
- **statica** --> il processo mantiene la propria _area di memoria dal caricamento alla terminazione_;
- **dinamica** --> durante l'esecuzione il processo puo' essere _spostato all'interno della memoria_;

<u>Nota bene</u>: la [[mmu|MMU]] con _registro di rilocazione_ e' in grado di implementare solo l'allocazione contigua!

<u>Nota bene</u>: l'allocazione statica si sposa bene con il [[binding|binding]] a _compile-time_ o _load-time_.

### Memoria virtuale
Nell'ambito della [[memoria-virtuale|memoria virtuale]], inoltre, l'allocazione si spartisce in:
- **locale** --> ogni processo ha un _insieme proprio di frame_;
- **globale** --> ogni processo puo' _allocare tutti i frame presenti nel sistema_ (sono in competizione).

Nella pratica significa che in caso di [[page-fault|page fault]]:
- locale --> il sistema cerca il frame tra quelli assegnati al processo;
- globale --> il sistema cerca il frame tra tutti quelli disponibili, potenzialmente sfrattando pagine di altri processi.

Intuitivamente la memoria locale e' piu' veloce, ma meno flessibile. La memoria globale e' piu' lenta, ma piu' flessibile. Quest'ultima, in particolare, puo' portare al fenomeno detto [[trashing|trashing]].

## Metodi
L'allocazione puo' essere implementata in diversi modi:
- allocazione a partizioni fisse;
- allocazione a partizioni dinamiche.

### Allocazione a partizioni fisse
In questo caso la memoria (primaria) viene divisa in **partizioni di dimensioni fisse**, e _ogni processo viene caricato in una delle partizioni libere con dimensione sufficiente a contenerlo_.
![[allocazione-partizioni-fisse.png]]

E' di tipo statica e contigua, molto semplice da implementare. Tuttavia _spreca memoria_ e _limita il parallelismo al numero di partizioni_. Diciamo che e' un tipo di allocazione _comoda per sistemi embedded e/o monoprogrammati_, in cui esiste una sola partizione dove viene caricato un unico programma utente.

A livello di gestione della memoria si puo' implementare:
- usando una coda di processi per partizione;
- una coda di processi comune a tutte le partizioni.

### Allocazione a partizioni dinamiche
Invece qui viene _assegnata la giusta quantita' di memoria disponibile ai processi che ne fanno richiesta_. In tal caso la memoria puo' avere diverse zone inutilizzate, non contigue, per effetto della terminazione di processi[^2] oppure perche' non sono stati caricati processi di dimensioni multiple della partizione[^1].

Anche questa e' un'allocazione di tipo statica e contigua, ed esistono diverse politiche di assegnamento della memoria: si parla di [[allocazione-dinamica|allocazione dinamica]].

## Problemi
I principali problemi che si presentano con l'allocazione della memoria sono legati al fenomeno della [[frammentazione|frammentazione]], in particolare:
- [[frammentazione-interna|frammentazione interna]];
- [[frammentazione-esterna|frammentazione esterna]].

## Referenze
- [[allocazione-dinamica|Allocazione dinamica]]
- [[trashing|Trashing]], [[working-set|Working set]]

[^1]: [[frammentazione-interna|frammentazione interna]]!
[^2]: [[frammentazione-esterna|frammentazione esterna]]!
