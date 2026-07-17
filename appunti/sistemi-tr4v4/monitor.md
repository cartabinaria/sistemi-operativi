---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 05-12-2024 19:40:56
links:
  - "[[lecture-22112024091729|Lecture 22112024091729]]"
  - "[[lecture-29112024093415|Lecture 29112024093415]]"
---
# Monitor
---
## Introduzione
> I **monitor** sono un _paradigma per la sincronizzazione di [[processo|processi]] [[concorrenza|concorrenti]], che forniscono un approccio più strutturato alla programmazione concorrente_.

Furono introdotti nel 1974 da [[tony-hoare|Hoare]], e oggigiorno sono implementati in un certo numero di [[linguaggio-di-programmazione|linguaggi di programmazione]] (tra cui [[java|Java]]).

### Idea
I [[semafori|semafori]] servivano per proteggere dati condivisi da accessi concorrenti. Se riuscissimo a trovare un **meccanismo per nascondere tali dati**, _potremmo evitare l'uso di semafori con tutte le problematiche che ne conseguono_.

L'idea è allora quella di _mettere i dati in una sorta di [[classe|classe]] con metodi per accederci_, e implementare un _meccanismo che consenta a un solo [[thread|thread]] alla volta di accederci_.

## Architettura
Un monitor è costituito da:
- **dati locali**;
- **sequenza di inizializzazione**;
- **una o più procedure**.

Sintatticamente possiamo descrivere un monitor seguendo la struttura della [[oop|programmazione a oggetti]]:
```C
monitor name {
	// Variabili private al monitor
	variable declarations...

	// Inizializzazione
	name(args...) {
	}

	// Procedure visibili all'esterno
	procedure entry type procedurename1(args...) {
	}

	// Procedure private
	type procedurename2(args...) {
	}
}
```

### Caratteristiche
Le caratteristiche principali sono:
- _località_ - i dati locali sono accessibili solo alle procedure del modulo stesso;
- _entrata_ - un processo entra in un monitor invocando una delle sue procedure;
- _[[mutua-esclusione|mutua esclusione]]_ - solo un processo alla volta può essere all'interno del monitor; gli altri processi che invocano il monitor sono sospesi, in attesa che questo diventi disponibile.

### Variabili condizione
La mutua esclusione però non basta: per poter essere utile alla programmazione concorrente _si vuole poter sospendere processi in attesa di qualche condizione, facendoli uscire dalla mutua esclusione, per poi risvegliarli quando la condizione è soddisfatta_.

Per fare ciò sono introdotte le **variabili condizione** (_CV_). Queste sono il cuore dei monitor, e sono variabili di tipo `condition` su cui è possibile invocare due operazioni:
- `wait` - _sospende il processo e lo mette in attesa del verificarsi della condizione_;
- `signal` - _risveglia un processo in attesa della condizione verificata_.

In particolare `wait` rilascia la mutua esclusione (libero il monitor), ma mette in il processo in una [[coda|coda]] di attesa sulla `condition`; `signal` causa la riattivazione immediata di un (eventuale) processo in attesa su quella condizione, secondo politica [[fifo|FIFO]], ponendo il chiamante in attesa sulla _urgent stack_ (politica [[lifo|LIFO]]).

### Schema logico
![[monitor.png]]

### Differenze con semafori
E' fondamentale chiarire che `wait/signal` $\neq$ `P/V`:
- `wait` è _sempre bloccante_ a differenza di `P`;
- `signal` _non ha alcun effetto se nessun processo sta attendendo la condizione_, `V` invece "memorizza" il verificarsi degli eventi anche per il futuro.

### Politiche di `signal`
In letteratura ci sono tante politiche usate per i processi che invocando una `signal` su una `condition` risvegliano un processo in attesa:
- **SU** (_Signal Urgent_) - il processo chiamante viene messo in attesa sulla _urgent stack_;
- **SW** (_Signal Wait_) - il processo chiamante viene inserito nella _entry queue_ "al contrario", come se fosse uno stack;
- **SR** (_Signal and Return_) - dopo la `signal` il processo chiamante esce subito dal monitor.
- **SC** (_Signal and Continue_) - dopo la `signal` il chiamante continua, e solo dopo essere uscito dal monitor il processo in attesa viene risvegliato --> è l'unica politica che _non garantisce che il processo in attesa venga risvegliato con la condizione soddisfatta_.

## Implementazioni
### Semafori con monitor
```C
monitor Semaphore {
	condition moreThanZero;
	int value;

	Semaphore(v) {
		value = v;
	}

	procedure entry void P() {
		if (value == 0) {
			moreThanZero.wait();
		value--;
	}

	procedure entry void V() {
		value++;
		moreThanZero.signal();
	}
}
```

### Monitor con semafori
Nella realtà dei fatti, **i monitor sono di fatto implementati tramite semafori**.
#### Ingredienti
Abbiamo fondamentalmente bisogno di solo alcune cose:
- _modulo di gestione code_ - per la waiting queue sulle condizioni;
- _modulo di gestione pila_ - per la _urgent stack_;
- _semaforo `mutex`_.

```C
interface Stack {
	void push(Object val);
	Object pop(void);
	boolean empty(void);
}

interface Queue {
	void enqueue(Object val);
	Object dequeue(void);
	boolean empty(void);
}
```

Il motivo per cui non è necessaria l'implementazione di un modulo a parte per la _entry queue_, è perché usiamo il `mutex` stesso per formare la coda di input (assumendo che i _semafori siano FIFO_). Per consentire ciò, sarà necessario il **passaggio del testimone** nel momento in cui viene attivato un processo in attesa con una `signal` o riattivato un processo dalla _urgent stack_.

#### Implementazione
Le parti da implementare del monitor sono:
1. _inizializzazione_;
2. _entrata nel monitor_;
3. _`wait` su condizione_;
4. _`signal` su condizione_;
5. _uscita dal monitor_.

##### Inizializzazione
```C
Semaphore mutex(1);
StackOfSem urgent;
QueueOfSem waiting[NCOND];
```

##### Entrata nel monitor
```C
mutex.P();    // sufficiente per gestire la coda di input
```

##### `wait` su condizione `i`
```C
Semaphore semQ = new Semaphore(0);
waiting[i].enqueue(semQ);
if (!urgent.empty()) {
	Semaphore semS = urgent.pop();
	semS.V();    // passaggio del testimone!
} else {
	mutex.V();
}
semQ.P();
free(semQ);
```

##### `signal` su condizione `i`
```C
if (!waiting[i].empty()) {
	Semaphore semQ = waiting[i].dequeue();
	Semaphore semS = new Semaphore(0);
	urgent.push(semS);
	semQ.V();    // passaggio del testimone!
	semS.P();
	free(semS);
}
```

##### Uscita dal monitor
```C
if (!urgent.empty()) {
	Semaphore semS = urgent.pop();
	semS.V();    // passaggio del testimone!
} else {
	mutex.V();
}
```

### Conseguenze
La conseguenza di queste due implementazioni ci sta ad indicare che monitor e semafori hanno lo stesso [[potere-espressivo|potere espressivo]].

## Referenze