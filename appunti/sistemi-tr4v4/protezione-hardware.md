---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-03-2025 16:30:26
links:
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
---
# Protezione hardware
---
## Introduzione
> I [[sistema-operativo|sistemi operativi]] [[multiprogramming|multiprogrammati]] e multiutente richiedono la presenza di meccanismi di **protezione hardware**. In particolare, _bisogna evitare che i processi utente interferiscano con il sistema operativo_.

Meccanismi di questo tipo non possono essere realizzati con il solo software: **serve l'hardware**.

## Modalita'
Solitamente le due modalita' previste sono _utente_ e _kernel_.

### Modalita' utente
I [[processo|processi]] eseguiti in modalita' utente non hanno accesso alle istruzioni privilegiate, come per esempio quella per [[disabilitazione-degli-interrupt|disabilitare gli interrupt]].

### Modalita' kernel / supervisore / privilegiata / ring 0
I processi in modalita' kernel hanno accesso a tutte le istruzioni, incluse quelle privilegiate che gli consentono di gestire totalmente il sistema.

Tutte le istruzioni di [[i-o|I-O]] sono da considerarsi privilegiate. Di fatto, il [[sistema-operativo|sistema operativo]] dovra' fornire agli utenti delle primitive ([[system-call|system call]]) per accedere all'I-O.

<u>Nota bene</u>: infatti **le system call NON sono istruzioni privilegiate**! Ogni processo puo' chiamarle, e questo generera' una [[trap|trap]] che da' il via al codice del sistema operativo che e' in modalita' kernel, per cui puo' eseguire le istruzioni di I-O.

## Implementazione
Le due modalita' sono segnalate dal valore del **mode bit**, _1 singolo bit che indica la modalita' corrente della CPU_ (nel [[psw|PSW]], [[registro|registro]] di stato).

La protezione deve avvenire anche a lato [[memorie|memoria]]: attraverso la [[mmu|MMU]]. Altrimenti i processi utente potrebbero:
- modificare il codice o i dati di altri processi utenti;
- modificare il codice o i dati del sistema operativo;
- modificare l'[[interrupt-vector|interrupt vector]], inserendo i propri [[interrupt-handler|gestori degli interrupt]].

## Funzionamento
Come funziona il passaggio tra queste modalita'?

Si seguono i seguenti passaggi:
- alla partenza il processore e' in modalita' kernel;
- viene caricato il sistema operativo ([[bootstrap|bootstrap]]) e si inizia ad eseguirlo;
- quando questo cede il controllo a un processo utente, prima di farlo cambia il valore del _mode bit_ ponendo il processore in modalita' utente;
- tutte le volte che avviene un [[interrupt|interrupt]] (sia hardware che software), si passa alla modalita' kernel --> [[mode-switch|mode switch]];

## Referenze