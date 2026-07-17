---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 22-10-2023 20:50:57
links:
  - "[[lecture-19102023130600|Lecture 19102023130600]]"
  - "[[lecture-21032025091929|Lecture 21032025091929]]"
---
# Memoria virtuale
---
## Introduzione
> La **memoria virtuale** è la tecnica che attraverso algoritmi di [[paginazione|paginazione]] consente di utilizzare parte della _memoria di massa_ ([[hd|HD]] o [[ssd|SSD]] che sia) come estensione della [[ram|RAM]], eseguendo [[processo|processi]] salvati parzialmente in memoria.

Il motivo per cui funziona è che i processi non utilizzano sempre tutta la memoria a loro disposizione, vale a dire che non accedono al loro spazio di indirizzamento in [[distribuzione-uniforme-discreta|modo uniforme]], ma tendono a farlo in _modo contiguo_.

### Motivazioni
Ciò risulta particolarmente utile nel momento in cui la memoria risulta non sufficientemente grande per le operazioni richieste. Ma nella pratica, **serve per risparmiare memoria primaria**: per esempio, la _routine di gestione degli errori potrebbe non essere mai chiamata da un programma_, e quindi si puo' benissimo mantenere in memoria secondaria; lo stesso vale per i [[compilatore|compilatori]], che usano [[struttura-dati|strutture dati]] differenti a seconda delle fasi.

## Implementazione
Si assegna ad ogni processo uno **spazio di indirizzamento virtuale** che puo' essere piu' grande di quello fisico. Gli indirizzi virtuali, quindi, saranno mappati:
- _su indirizzi fisici della memoria principale_;
- _su indirizzi fisici della memoria secondaria_.

In caso di accesso a indirizzi virtuali mappati in memoria secondaria, si ha che:
1. si arresta il processo;
2. i dati sono trasferiti nella memoria principale;
3. se la memoria principale è piena si spostano in memoria secondaria i dati considerati meno utili;
4. si riprende il processo.

### Demand paging
Per fare tutto cio', si usa la [[paginazione|paginazione]], ammettendo che alcune pagine possano essere memorizzate in memoria secondaria. Questo si chiama **demand paging**.

In particolare nella _tabella delle pagine_ si usa un bit $v$ che indica se la pagina e' presente nella memoria primaria (in un qualche frame) oppure no. Nel caso in cui il processo tenti di accedere a una pagina non in memoria:
1. il TLB miss (nel caso ci sia [[tlb|TLB]]) fa cercare la pagina nella tabella delle pagine, che non trovandola scatena un _[[page-fault|page fault]]_;
2. un componente del [[sistema-operativo|sistema operativo]], chiamato _pager_, si occupa di caricare la pagina mancante in memoria, e di aggiornare di conseguenza la tabella delle pagine.

![[memoria-virtuale.png]]

<u>Ricorda</u>: la paginazione nasce come metodo per limitare la [[frammentazione|frammentazione]], poi puo' essere usata per fare memoria virtuale comodamente.

### Algoritmo di demand paging
Nel caso in cui nella tabella delle pagine venga fatto riferimento a una pagina non presente in memoria, l'algoritmo di demand paging funziona come segue:
1. la [[mmu|MMU]] si accorge che la pagina non e' in memoria (bit $v = 0$), e genera un _page fault_;
2. il _pager_ cerca la pagina in memoria secondaria;
3. il pager carica la pagina in un frame libero in memoria primaria;
4. se tale frame libero non esiste (sono tutti occupati), il pager
	1. richiama [[algoritmi-di-paginazione|algoritmo di rimpiazzamento]];
	2. aggiorna la tabella delle pagine, invalidando la pagina "vittima" (bit $v = 0$);
	3. se la pagina "vittima" è stata modificata, scrive la pagina sul disco (per salvare le modifiche);
	4. aggiorna la tabella dei frame (per indicare il nuovo frame libero);
5. il pager aggiorna la tabella dei frame (per indicare il nuovo frame occupato);
6. il pager aggiorna la tabella delle pagine (bit $v = 1$, caricato il TLB);
7. il pager riattiva il processo.

## Osservazioni
### Swap vs. demand paging
Lo **swap** era la tecnica precedente al demand paging, che consisteva nel _prendere l'intera memoria del processo e metterlo su memoria secondaria, per riattivarlo in un secondo momento_.

Il demand paging invece potrebbe essere pensato come una _tecnica di swap lazy_: vengono caricate solo le pagine del processo che servono (non l'intero processo).

Ma attenzione: la **swap area** è _dove il pager fa lo scambio tra dati in memoria primaria e secondaria_. Di fatto dovrebbe essere chiamata _paging area_, ma il nome e' rimasto così.

## Referenze