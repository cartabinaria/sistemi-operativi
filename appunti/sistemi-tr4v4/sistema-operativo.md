---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 24-11-2023 13:56:16
links:
  - "[[lecture-16112023133640|Lecture 16112023133640]]"
  - "[[lecture-10102024092110|Lecture 10102024092110]]"
  - "[[lecture-20022025151640|Lecture 20022025151640]]"
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
  - "[[lecture-27022025151550|Lecture 27022025151550]]"
  - "[[lecture-28022025091715|Lecture 28022025091715]]"
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
  - "[[lecture-07032025091554|Lecture 07032025091554]]"
  - "[[lecture-13032025151745|Lecture 13032025151745]]"
---
# Sistema operativo
---
## Introduzione
Un computer contiene una _serie di [[architettura-di-von-neumann-introduzione|risorse hardware]] che possono eseguire dei programmi software_. E' possibile, per esempio, caricare manualmente in [[ram|RAM]] un programma, farlo eseguire alla [[cpu|CPU]] e ottenere un risultato salvato in [[memorie-classificazione|memoria di massa]]. Ovviamente è un modo scomodo per eseguire programmi, ed è limitato per esempio nell'esecuzione di un singolo programma alla volta.

La soluzione che si propone è allora quello di _far eseguire al computer un unico generico software che consente di eseguire programmi e che gestisca l'hardware sottostante_: il **sistema operativo**.

Questo farebbe del sistema operativo l'**interfaccia vera e propria tra il calcolatore e i programmi applicativi**: questi, in particolare, interagirebbero con l'hardware attraverso delle [[system-call|system call]]...

Se volessimo dare una descrizione, allora
> Un **sistema operativo** è livello di astrazione, che realizza il concetto di [[processo|processo]], che fornisce come linguaggio ([[api|API]]) le [[system-call|system call]], ed è _implementato tramite un programma che controlla l'esecuzione di programmi applicativi e agisce come interfaccia tra le applicazioni e l'hardware del calcolatore_.

### Struttura
![[struttura-sistema-operativo-unix.png]]

## Compiti
Di fatto il sistema operativo si occupa di:
- _[[gestione-della-memoria|gestire la memoria principale]]_, che viene astratta dal gestore della memoria come un "array" di byte indirizzabili singolarmente
	- tenere traccia di quali parti della memoria sono usate e da chi
	- decidere quali processi caricare quando diventa disponibile spazio in memoria
	- allocare e deallocare lo spazio di memoria quando necessario
	- [[binding|binding]]
	- usare memoria secondaria per ampliare la memoria principale ([[memoria-virtuale|memoria virtuale]])
		- [[paginazione|paginazione]]
		- [[segmentazione|segmentazione]] (ed eventuale [[combinazione-segmentazione-paginazione|combinazione]])
- _gestire la memoria secondaria_ (non e' il file system!)
	- gestione partizionamento
	- gestione dell'accesso efficiente e affidabile ([[raid|RAID]])
	- ordinamento efficiente delle richieste (disk scheduling)
- _gestire i [[processo|processi]]_
	- creazione e terminazione dei processi
	- sospensione e riattivazione dei processi
	- gestione del [[deadlock|deadlock]]
	- comunicazione tra processi ([[message-passing|message passing]])
	- sincronizzazione tra processi ([[concorrenza|concorrenza]])
- _gestire le periferiche [[i-o|I/O]]_
	- attraverso i [[device-controller|device controller]]
	- interfaccia comune per la gestione dei device driver
	- insieme di driver per dispositivi hardware specifici
	- sistema di gestione di buffer per il caching delle informazioni
- _gestione del [[file-system|file system]]_
	- creazione e cancellazione di [[file|file]]
	- creazione e cancellazione di directory
	- manipolazione di file e directory
	- codifica del file system su una sequenza di blocchi
- _supporto multiuser_, in particolare protezione
	- gestire l'identità del proprietario del processo (`uid` e `gid`)
	- gestire chi può fare cosa
	- fornire un meccanismo di attuazione della protezione
- _networking_
	- protocolli di comunicazione a basso livello
		- [[ip|IP]]
		- [[tcp|TCP]], [[udp|UDP]]
	- servizi di comunicazione ad alto livello
		- file system distribuiti (NFS, SMB)
- _gestire gli [[interrupt|interrupt]]_
	- i **sistemi operativi moderni sono detti "interrupt-driven"**: sono gli interrupt (sia hardware che software) che consentono al sistema operativo di entrare in azione per la loro gestione e di creare l'avvicendamento del tempo di esecuzione tra i processi con lo [[scheduler|scheduler]] (mediante l'[[interval-timer|interval timer]])
- _gestire le [[risorsa|risorse]]_

Sono compiti estremamente complessi... Soprattutto perché il tutto dev'essere fatto con criteri di:
- **efficienza**
- **semplicità**
- **portabilità**

E' interessante notare come il sistema operativo sia un qualcosa di strano. Il sistema controllato e quello controllante, di fatto, hanno la stessa natura: il SO è un programma che controlla altri programmi, per cui di fatto deve autogestirsi.
Di solito avviene che _il sistema operativo lascia il controllo a un processo, e quando questo non fa operazioni aritmetico-logiche ma chiama per esempio una system call, o termina, allora rimanda in esecuzione il sistema operativo_.

### Strutture dati
Per svolgere i suoi compiti, il sistema operativo si serve delle seguenti strutture dati principali:
- _tabelle di memoria_;
- _tabelle di I-O_;
- _tabelle del file system_;
- _tabelle dei processi_ (contenente i [[pcb|PCB]]).

![[tabelle-sistema-operativo.png]]

## Storia
Possiamo dividere i sistemi operativi in 4 grandi generazioni:
1. generazione 0: Babbage! Ha progettato la prima macchina (meccanica) analitica programmabile; ci ha programmato per la prima volta Lady Ada Lovelace
2. generazione 1: 1945-1955, valvole e tavole di commutazione
	- usavano le valvole termoioniche
	- poi i relé, che però erano più lenti perché meccanici
	- grossi problemi di affidabilità
3. generazione 2: 1955-1965, transistor e sistemi batch
	- basata sui transistors
	- si programmavano con linguaggi ad "alto livello", come Assembly e Fortran, trasmessi su schede perforate
	- nasce il concetto di _job_, ossia un programma
	- nascono i primi sistemi operativi, piccoli programmi per serializzare la sequenza di job
		- viene caricato il monitor
		- questo cede il controllo al job corrente
		- terminato il job riprende il controllo il monitor
		- nota bene: è esattamente lo stesso sistema usato da Arduino!
	- problemi:
		- molte risorse restavano inutilizzate
4. generazione 3: 1965-1980, circuiti integrati, multiprogrammazione e time-sharing
	- nasce la multiprogrammazione, ossia se c'è un I/O il processore esegue un altro job (sempre uno alla volta)
	- si evolverà poi in time-sharing, che aggiunge alla multiprogrammazione una regola in più: il controllo passa a un altro processo non solo quando c'è una richiesta di I/O, ma anche quando scade il tempo assegnato in CPU (per evitare che un processo ci stia troppo, così crea parallelismo apparente)
		- è necessario un interval timer, dispositivo hardware che manda un interrupt ogni tot.
		- questo scatena un context-switch
		- caratteristiche:
			- gestione della memoria, nasce la memoria virtuale
			- CPU scheduling, lo scheduling dev'essere preemptive o time-sliced, ossia deve poter interrompere un processo in esecuzione a favore di un altro
			- meccanismi di protezione, la presenza di più utenti rende necessari meccanismi di protezione
5. generazione 4: 1980-oggi, personal computer
	- non si pensava alla possibilità che qualcuno volesse, o potesse volere un computer a casa sua

## Tipologie
I sistemi operativi possono avere:
- **struttura semplice** --> non hanno una struttura progettata a priori, sono semplicemente una collezione di procedure; risultano in SO semplici e limitati
	- [[ms-dos|MS-DOS]] e [[unix|Unix]] appartengono a questa categoria
	- anche UNIX è poco strutturato, in gergo ha un kernel monolitico --> se si blocca una parte si blocca tutto
	- sistemi di questo tipo sono **poco modulari ma estremamente efficienti**
- **struttura a strati**, secondo il _modello a cipolla_
	- [[the-o-s.|The O.S.]] (di [[edsger-dijkstra|Dijkstra]]) e [[venus-os|Venus OS]] appartengono a questa categoria
	- sistemi di questo tipo sono **poco efficienti ma estremamente modulari**

## Progettazione
Quando si progetta un sistema operativo bisogna prevedere la sua installazione su architetture hardware differenti. Si fa definendo dei parametri che saranno definiti al momento dell'installazione, oppure usando dei moduli aggiuntivi.

## Referenze
- [[sistema-parallelo|Sistema parallelo]]
- [[sistema-distribuito|Sistema distribuito]]
- [[sistema-real-time|Sistema real-time]]
- [[kernel|Kernel]]

- il ristorante di Brachetti riflette quasi tutte le peculiarità di un sistema operativo