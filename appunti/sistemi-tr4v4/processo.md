---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 15-10-2024 16:58:39
links:
  - "[[lecture-10102024092110|Lecture 10102024092110]]"
  - "[[lecture-17102024091631|Lecture 17102024091631]]"
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
---
# Processo
---
## Introduzione
> Per **processo** si intende un'attività controllata da un programma che si svolge su un [[cpu|processore]].

### Processo vs. programma
Un **processo non è un [[programma|programma]]**:
- un programma è un'_entità statica_, che specifica una sequenza di istruzioni (e non la durata nel tempo dell'esecuzione);
- un processo è un'_entità dinamica_, che rappresenta l'attività dell'esecuzione di un programma.

## Caratteristiche
Una delle proprietà fondamentali dei processi è descritta da un'[[assioma|assioma]]: l'[[assioma-di-finite-progress|assioma di finite progress]].

Più processi possono eseguire lo stesso programma: ogni istanza viene considerata un processo separato. Nel dettaglio, si condivide la parte di memoria riservata al codice del programma (`TEXT`), mentre le parti private delle singole istanze non sono condivise (`DATA` e `STACK`).

## Stato
Ad ogni istante un processo è descritto da:
1. _la sua immagine in [[ram|memoria]]_ (la memoria assegnata e le strutture dati del sistema operativo associate al processo);
2. _la sua immagine nel processore_ (contenuto dei [[registro|registri]] [[registro-registri-generali|generali]] e [[registro-registri-speciali|speciali]]);
3. _lo stato di avanzamento_ (il suo stato corrente, se è in esecuzione o in attesa di qualche evento).

Un processo si può trovare in 3 stati:
- **running** - processo in esecuzione;
- **waiting** - processo in attesa di qualche evento esterno;
- **ready** - processo pronto per essere eseguito, in attesa del via dal processore;

![[stati-processo.png]]

<u>Nota bene</u>: per le [[system-call|system call]] non bloccanti (come `getpid()`), il processo va nella _ready queue_, senza doversi necessariamente bloccare in qualche coda in stato di _waiting_.

## Strutture dati
### Code di processi
Per implementare gli stati, si implementano le seguenti code dei processi:
- **ready queue** - [[struttura-dati|struttura dati]] da cui lo [[scheduler|scheduler]] sceglie il processo da eseguire;
- **waiting queue** - sono in realta' implementate dai [[semafori|semafori]] --> per ogni device ci sara' un semaforo con associata una coda di attesa.

![[code-dei-processi.png]]

Piu' precisamente si avra':
![[processo-in-scheduler.png]]

### Gerarchie di processi
Si vuole anche che quando un processo crea un nuovo processo, il creante sia il padre e il creato il figlio: ci dev'essere una struttura dati ([[albero|albero]]) che gestisca questo legame di "parentela" tra i processi.

Questo e' un meccanismo molto comodo: **quando creiamo un processo questo eredita tutti i campi dal genitore**, tranne quelli che vogliamo specificare.

<u>Nota bene</u>: in [[linux|Linux]] il processo "Adamo/Eva" e' `/sbin/init`, che infatti ha `pid` 1. Questo eredita tutti i processi orfani.

## Interazioni
### Processi
I processi si classificano in base a quanto sono consapevoli gli uni degli altri:
- _processi indipendenti_;
- _processi in conoscenza indiretta_;
- _processi in conoscenza diretta_;

#### Processi indipendenti
Sono totalmente ignari gli uni degli altri, per cui _competono per le stesse risorse e devono sincronizzarsi nel loro utilizzo_.

Dev'essere proprio il _[[sistema-operativo|sistema operativo]] ad arbitrare competizione e sincronizzazione_.

#### Processi in conoscenza indiretta
Condividono delle risorse al fine di scambiarsi informazioni, per cui _non si conoscono perfettamente ma interagiscono indirettamente attraverso di esse_. Devono _cooperare per qualche scopo e sincronizzarsi nell'utilizzo delle risorse_.

In questo caso il _sistema operativo deve facilitare la cooperazione fornendo meccanismi di sincronizzazione_.

#### Processi in conoscenza diretta
Questi comunicano uno con l'altro sulla base dei loro _id_, praticamente una comunicazione diretta basata sullo scambio di messaggi. _Cooperano per qualche scopo e comunicare informazioni agli altri processi_.

Qui il _sistema operativo deve facilitare la cooperazione fornendo meccanismi di comunicazione_.

### Modelli
I processi interagiscono su due modelli di utilizzo della memoria:
- **memoria condivisa** - comunicazione tramite sincronizzazione;
- **memoria privata** - sincronizzazione tramite comunicazione;

## Processi vs. thread
Un processo e' singolo, un unita' che esegue una singola sequenza di istruzioni. Questo, poi, puo' prevedere la creazione di tanti [[thread|thread]], delle **sottoattivita' del processo che possono essere eseguite simultaneamente**.

Tutti i sistemi operativi moderni supportano multithreading, ossia la possibilita' di un processo di generare threads.

Di conseguenza, in sistemi del genere (quindi praticamente tutti), **la CPU non esegue processi ma singoli thread**! I processi non diventano altro che i titolari dei thread, ognuno dei quali ha invece informazioni private sul suo stato di esecuzione (su stack, tra l'altro, separati). Lo **[[scheduling|scheduling]], su questi sistemi, viene allora fatto sui thread e non sui processi**.

![[single-threading-vs-multi-threading.png]]

### Motivazioni
E' piu' efficiente sincronizzare i thread che i processi, perche' questi sono raccolti e controllabili dal processo che li ha generati:
- per _far comunicare i processi, che hanno memoria privata, dovremmo adottare [[message-passing|message passing]]_ (poco efficiente);
- invece la _sincronizzazione tra i thread avviene mediante i [[semafori|semafori]] perche' agiscono sulla memoria condivisa del processo_.

Inoltre fare il [[context-switch|context switch]] tra i processi e' piu' costoso che farlo sui thread.

## Referenze