---
tags:
  - category/note
  - status/finished
  - topic/tecnologie-web
  - topic/sistemi-operativi
date: 24-09-2024 18:00:04
links:
  - "[[lecture-19092024151357|Lecture 19092024151357]]"
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
---
# Risorsa
---
## Introduzione
> Una **risorsa**, in ambito informatico e in particolare nel mondo [[web|web]], è un qualunque oggetto di interesse del web, ossia una struttura scambiata tra applicazioni all'interno del WWW. Ognuna di essa è indissolubilmente legata a un [[uri|URI]], che la identifica in maniera globale.
> Nell'ambito dei [[sistema-operativo|sistemi operativi]], una risorsa e' una qualunque componente hardware/software assegnabile a dei [[processo|processi]], i quali competono nell'accesso alle risorse.

Per esempio:
- HW --> [[memorie|memoria]], stampanti, [[cpu|processore]], [[hd|dischi]], interfaccia di [[rete|rete]]
- SW --> [[sezione-critica|sezioni critiche]], [[pcb|descrittori di processo]]

## Caratteristiche
### Classi
Di solito, per comodita', le **risorse sono divise in classi**. Risorse appartenenti alla stessa classe sono equivalenti, e vengono dette istanze di tale classe. Il numero di risorse assegnabili di una stessa classe viene detto _molteplicita'_ del tipo di risorsa.

<u>Nota bene</u>: un processo quindi non richiede una risorsa, ma una risorsa-istanza di una classe.

### Assegnazione
Il modo in cui avviene l'assegnamento di una risorsa a un processo puo' essere:
- _statica_ --> avviene al momento della creazione del processo e rimane valida fino alla terminazione;
- _dinamica_ --> le risorse sono richieste dal processo durante la sua esecuzione, e possono essere assegnate e rilasciate quando non più necessarie.

### Richieste
La richiesta di un processo per una risorsa puo' essere:
- _singola_ --> si richiede una sola istanza;
- _multipla_ --> si richiedono piu' istanze e talvolta anche di classi diverse.

E talvolta anche:
- _bloccanti_ --> il processo si sospende se non ottiene immediatamente l'assegnazione;
- _non bloccanti_ --> la mancata assegnazione non provoca la sospensione del processo richiedente.

### Tipologie
Le risorse stesse possono essere:
- _condivisibili_ --> assegnabili a piu' processi contemporaneamente;
- _non condivisibili_ --> il contrario;

E anche e soprattutto _preemptable_ e _non preemptable_.

#### Preemptable
La funzione di gestione della risorsa puo' rilasciarla a un processo prima che questo l'abbia rilasciata volontariamente. Di base e' lo stesso principio degli [[scheduling|scheduling]] preemptive ma esteso a tutte le risorse.

Si gestisce sospendendo il processo che subisce il prerilascio, mettendolo in attesa di tale risorsa. Affinche' una risorsa sia prerilasciabile, pero', deve verificarsi che:
- il suo stato non si modifichi durante l'utilizzo;
- oppure il suo stato può essere facilmente salvato e ripristinato[^1];

Per esempio, il processore e i blocchi/partizioni di memoria (nel caso di assegnazione dinamica) sono prerilasciabili.

#### Non preemptable
La funzione di gestione della risorsa non puo' sottrarla al processo al quale e' stata assegnata.

Per esempio, le stampanti, le sezioni critiche, i blocchi/partizioni di memoria (nel caso di assegnazione statica) non sono prerilasciabili.

## Referenze

[^1]: nel caso della risorsa [[cpu|CPU]] avviene proprio questo, attraverso il meccanismo del [[context-switch|context switch]]!
