---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 06-03-2025 10:36:31
links:
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
---
# Gestione degli interrupt
---
## Gestione
A seguito di un [[interrupt|interrupt]] spedito al [[cpu|processore]], avvengono i seguenti passaggi:
1. il processore
	1. finisce l'esecuzione dell'istruzione corrente[^1];
	2. verifica la presenza di un segnale di interrupt (assumiamo ci sia);
		- ![[cpu-interrupt-handling.png]]
	3. salva il suo stato, per preparasi al [[context-switch|context-switch]]
		- metodo 1: salvataggio dei registri "critici", in particolare [[pc|PC]] + [[psw|PSW]] (registro di stato, ossia i flag della CPU);
		- metodo 2: fa uno [[snapshot|snapshot]] di tutti i registri della CPU[^2];
	4. seleziona l'_[[interrupt-handler|interrupt handler]]_ appropriato (interrogando l'[[interrupt-vector|interrupt vector]]);
	5. carica il PC con l'indirizzo iniziale dell'interrupt handler scelto;
	6. passa dalla modalita' utente alla modalita' kernel;
2. il [[sistema-operativo|sistema operativo]]
	1. salva lo stato del processore (per altre informazioni critiche non salvate lato hardware);
	2. gestisce l'interrupt leggendo le informazioni trasmesse dal dispositivo;
	3. ripristina lo stato del processore oppure chiama lo [[scheduler|scheduler]] (a seconda del tipo di interrupt);

## Interrupt multipli
Se _avviene un interrupt durante la gestione di un altro interrupt_, ci sono due approcci utilizzati:
- **[[disabilitazione-degli-interrupt|disabilitazione degli interrupt]]** --> quando viene eseguito il gestore di un interrupt, gli interrupt vengono disabilitati, e qualora si verificassero degli interrupt nel mentre, questi verrebbero messi in una coda, cosi' che non appena si conclude la gestione del primo interrupt, la CPU viene immediatamente interrotta dagli interrupt in coda
	- ![[interrupt-multipli-disabilitazione.png]]
	- si tratta di un approccio molto semplice, ma che non tiene conto di eventuali gestioni "time-critical" perche' gli interrupt sono sempre gestiti in modo sequenziale
- **interrupt annidati** --> a seconda del proprio valore di priorita', un interrupt puo' interrompere l'esecuzione di un altro interrupt
	- ![[interrupt-multipli-annidati.png]]
	- e' possibile definire priorita' diverse per gli interrupt
	- _bisogna assegnare ad ogni gestore di interrupt un suo stack, separato da quello del processo utente_ (ovvio) _ma anche da quello degli altri interrupt_: questo perche' interrompendosi in momenti casuali potrebbero interrompersi mentre vengono fatti i push dei valori standard delle funzioni, come gli argomenti!

## Referenze

[^1]: ricordiamo che ogni istruzione [[assembly|assembly]] viene eseguita in modo [[azione-atomica|atomico]]
[^2]: e' il metodo usato da $\micro$RISC-V
