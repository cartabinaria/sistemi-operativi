---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 02-12-2024 11:07:15
links:
  - "[[lecture-15112024091205|Lecture 15112024091205]]"
  - "[[lecture-22112024091729|Lecture 22112024091729]]"
---
# Lettori e scrittori
---
## Introduzione
> Il problema dei **lettori e scrittori** è un altro dei [[problemi-classici-della-programmazione-concorrente|problemi classici della programmazione concorrente]]. Si tratta di un problema in cui più [[processo|processi]], i _lettori_ e gli _scrittori_, accedono a una _variabile condivisa_ (tipo un [[database|database]]), in modo [[concorrenza|concorrente]]. I lettori possono accedere alla variabile simultaneamente, mentre gli scrittori devono accedere in modo esclusivo.

A differenza degli altri problemi classici, questo problema ha una vasta applicazione nella realtà, come ad esempio la gestione di un database. Mostra che _la competizione per le risorse avviene anche a livello di classi di processi_ (e non solo di processi), e che [[mutua-esclusione|mutua esclusione]] e mutua condivisione possono coesistere.

## Teoria
Si vuole che:
- _uno scrittore acceda alla risorsa in mutua esclusione, e che nel mentre nessun altro scrittore/lettore possa accederci_;
- _più lettori, quando la risorsa non è occupata da uno scrittore, possono accederci simultaneamente_.

Formalmente, si può esprimere con l'invariante
$$(nr \geq 0 \land nw = 0) \lor (nr = 0 \land nw = 1)$$
dove:
- $nr$ è il numero di lettori che stanno leggendo;
- $nw$ è il numero di scrittori che stanno scrivendo.

La vita di lettori e scrittori può essere rappresentata come segue:
```C
process Reader {
  while (true) {
    startRead();
    [read the database]
    endRead();
  }
}

process Writer {
  while (true) {
    startWrite();
    [write the database]
    endWrite();
  }
}
```

dove `startRead()` e `endRead()` contengono le operazioni necessarie affinché un lettore ottenga accesso al database, e `startWrite()` e `endWrite()` contengono le operazioni necessarie affinché uno scrittore ottenga accesso al database.

Le soluzioni si possono dividere in due categorie:
- **priorità ai lettori**, quindi se un lettore vuole accedere al database potrà farlo senza attesa a meno che non ci sia uno scrittore che non ne abbia già acquisito l'accesso --> _possibilità di [[starvation|starvation]] per gli scrittori_;
- **priorità agli scrittori**, quindi se uno scrittore vuole accedere al database potrà farlo senza attesa a meno che non ci siano lettori che non ne abbiano già acquisito l'accesso --> _possibilità di starvation per i lettori_.

## Implementazione
### Semafori
#### Idea
Una prima soluzione _naive_ con priorità ai lettori utilizza i [[semafori|semafori]] nel seguente modo:
```C
int nr = 0;
Semaphore rw = new Semaphore(1);
Semaphore mutex = new Semaphore(1);

void startRead() {
	mutex.P();
	if (nr == 0) rw.P();
	nr++;
	mutex.V();
}

void startWrite() {
	rw.P();
}

void endRead() {
	mutex.P();
	nr--;
	if (nr == 0) rw.V();
	mutex.V();
}

void endWrite() {
	rw.V();
}
```

Fondamentalmente:
- il primo lettore che arriva blocca l'accesso agli scrittori (`rw.P()`), o rimane bloccato se uno scrittore ha già acquisito l'accesso;
- l'ultimo lettore che esce sblocca l'accesso agli scrittori (`rw.V()`).

Dando priorità ai lettori, gli scrittori possono accusare starvation se ci sono lettori che leggono continuamente (`nr > 0` che blocca `rw.V()`).

Il problema di questa soluzione è che è _limitata alla priorità per i lettori_, ma soprattutto che _seppur corretta non è di facile comprensione_, e il semaforo `rw` è usato in modo "non convenzionale".

#### Soluzione Andrews
Andrews fornisce una soluzione a partire dalle seguenti definizioni:
- `B` condizione booleana;
- `S` statement (possibilmente composto);
- `<S>` esegue `S` in modo [[azione-atomica|atomico]];
- `<await(B) -> S>` esegue `S` solo dopo che `B` è diventata vera.

Supponendo che esista un meccanismo che implementi tali definizioni, la soluzione al problema dei lettori e scrittori è la seguente:
```C
process Reader {
  <await (nw == 0) -> nr++>
  [read the database]
  <nr-->
}

process Writer {
  <await (nr == 0 && nw == 0) -> nw++>
  [write the database]
  <nw-->
}
```

E' estremamente intuitiva, perché rispetta la coerenza con l'invariante. Non resta che implementarla effettivamente, codificando `await` e `<S>` (le operazioni atomiche). Per farlo ci avvaliamo di:
- _semaforo `mutex`_, per garantire la mutua esclusione su `nr` e `nw`;
- _array di semafori `sem[]` associato alle condizioni `B_j`_ (ossia `nw == 0` e `nr == 0 && nw == 0`) --> su questi semafori sono posti i processi in attesa del verificarsi della condizione `B_j`, per cui sono tutti inizializzati a 0;
- _array di interi `waiting[]` associato alle condizioni `B_j`_ --> serve per sapere quanti processi sono in attesa su una certa condizione (basterebbe contare la lunghezza della coda del semaforo `j`-esimo).

La codifica delle definizioni di Andrews diventa la seguente:
![[andrews-soluzione.png]]

In particolare:
- la `<S>` viene implementata attraverso `mutex`, che garantisce l'atomicità dell'operazione;
- la `<await(B_j) -> S_j>` viene implementata verificando se la condizione `B_j` è vera --> se non lo è il processo `j`-esimo viene messo in attesa sul semaforo `sem[j]` (`sem[j].P()`, dopo aver rilasciato la mutua esclusione) e viene incrementato `waiting[j]`; altrimenti, o subito dopo il verificarsi della condizione, viene eseguito `S_j`;
- la `SIGNAL()` è l'operazione fondamentale eseguita sempre dopo aver eseguito un'istruzione `S`, ed è quella che **non-deterministicamente** risveglia un processo in attesa su un semaforo se è verificata la condizione `B_j` e c'è effettivamente un processo in attesa su `sem[j]` (guardando `waiting[j]`); se non ci sono processi in attesa, la `SIGNAL()` semplicemente rilascia la mutua esclusione con `mutex.V()`.

La cosa più importante da notare è proprio il fatto che _`SIGNAL()` lavori in modo non-deterministico_. Questo è _necessario affinché non ci sia starvation sui processi_: infatti _se le condizioni degli `if` fossero valutate in modo deterministico, potrebbe accadere che un processo `j` in attesa non venga mai risvegliato anche se la condizione `B_j` è verificata_.

<u>Nota bene</u>: quello che fa la `SIGNAL()` è il **passaggio del testimone**, infatti rilascia `mutex.V()` solo se non c'è nessun processo in attesa o se non si verifica nessuna condizione, altrimenti rilasciando il semaforo `sem[j]` la mutua esclusione sarà rilasciata automaticamente dal processo che viene risvegliato (dal codice dell'`await`).

Una volta definita la struttura della soluzione di Andrews, possiamo applicarla al problema dei lettori e scrittori, tenendo conto che le condizioni sono solo 2:
```C
Semaphore mutex = new Semaphore(1);
Semaphore semRead = new Semaphore(0);
Semaphore semWrite = new Semaphore(0);
int waitingr = 0;
int waitingw = 0;

int nr = 0;
int nw = 0;

process Reader {
	while (true) {
		mutex.P();
		if (nw > 0) {
			waitingr++;
			mutex.V();
			semRead.P();
			waitingr--;
		}
		nr++;
		SIGNAL();
		[read the database]
		mutex.P();
		nr--;
		SIGNAL();
	}
}

process Writer {
  while (true) {
    mutex.P();
    if (nr > 0 || nw > 0) {
      waitingw++;
      mutex.V();
      semWrite.P();
      waitingw--;
    }
    nw++;
    SIGNAL();
    [write the database]
    mutex.P();
    nw--;
    SIGNAL();
  }
}

void SIGNAL() {
	nd-if (nw == 0 && waitingr > 0) {
		semRead.V();
	} nd-else if ((nw == 0 && nr == 0) && waitingw > 0) {
		semWrite.V();
	} nd-else if (!((nw == 0) && waitingr > 0) &&
					!((nw == 0 && nr == 0) && waitingw > 0)) {
		mutex.V();
	}
}
```

Ci sono una serie di semplificazioni che si possono fare su `SIGNAL()`, che consentono di eliminarne direttamente il non-determinismo:
```C
process Reader {
	while (true) {
		mutex.P();
		if (nw > 0) {
			waitingr++;
			mutex.V();
			semRead.P();
			waitingr--;
		}
		nr++;
		if (waitingr > 0)
			semRead.V();
		else
			mutex.V();
		[read the database]
		mutex.P();
		nr--;
		if (nr == 0 && waitingw > 0)
	      semWrite.V();
	    else
	      mutex.V();
	}
}

process Writer {
  while (true) {
    mutex.P();
    if (nr > 0 || nw > 0) {
      waitingw++;
      mutex.V();
      semWrite.P();
      waitingw--;
    }
    nw++;
    mutex.V();
    [write the database]
    mutex.P();
    nw--;
    if (waitingr > 0)
		semRead.V();
    else if (waitingw > 0)
		semWrite.V();
    else
		mutex.V();
  }
}
```

<u>Nota bene</u>: _il lettore_, una volta che non c'è alcuno scrittore nella sezione critica, _rilascia a catena tutti i lettori in attesa_ (`semRead.V()`), e se non ce n'è nessuno _consente ad eventuali futuri lettori di entrare rilasciando la mutua esclusione_ (`mutex.V()`); invece, lo scrittore rilascia a catena prima i lettori e poi gli scrittori in attesa (`semRead.V()` e `semWrite.V()`).

Proprio per quest'ultima ragione, _rimane la priorità ai lettori_, a cui viene data precedenza da parte degli scrittori. E' possibile invertire la priorità? Sì, perché ora siamo a conoscenza del numero di scrittori in attesa con `waitingw`. Per cui se un lettore nota che ci sono scrittori in attesa, semplicemente si mette in attesa: **abbiamo invertito la starvation**, e a seconda delle stime di letture e scritture sul database possiamo scegliere quale approccio usare.

E' possibile adottare una soluzione che invece elimini totalmente la starvation, per mezzo della **mutua cortesia**: _se un lettore nota che ci sono scrittori in attesa dà priorità a loro, e viceversa_. In questo modo, ovviamente, si avrà una stretta alternanza tra lettori e scrittori.
```C
process Reader {
	while (true) {
		mutex.P();
		if (nw > 0 || waitingw > 0) {
			waitingr++;
			mutex.V();
			semRead.P();
			waitingr--;
		}
		nr++;
		if (waitingr > 0)
			semRead.V();
		else
			mutex.V();
		[read the database]
		mutex.P();
		nr--;
		if (nr == 0 && waitingw > 0)
	      semWrite.V();
	    else
	      mutex.V();
	}
}

process Writer {
  while (true) {
    mutex.P();
    if (nr > 0 || nw > 0) {
      waitingw++;
      mutex.V();
      semWrite.P();
      waitingw--;
    }
    nw++;
    mutex.V();
    [write the database]
    mutex.P();
    nw--;
    if (waitingr > 0)
		semRead.V();
    else if (waitingw > 0)
		semWrite.V();
    else
		mutex.V();
  }
}
```

### Monitor
La soluzione presentata di seguito con i [[monitor|monitor]] è l'emblema della "superiorità" di questi rispetto ai semafori. In particolare la soluzione adottata da Andrews con i semafori è l'implementazione di una sorta di proto-monitor, necessaria per gestire il problema dell'operazione `V` rispetto a `signal`.
Consideriamo sempre i due processi `Reader` e `Writer` come segue:
```C
process Reader {
	while (true) {
		rwController.startRead()
		[read]
		rwController.endRead()
	}
}

process Writer {
	while (true) {
		rwController.startWrite()
		[write]
		rwController.endWrite()
	}
}
```

La soluzione allora prevede un monitor che implementa tali metodi:
```C
monitor RWController {
	condition ok2read;
	condition ok2write;
	int nr;
	int nw;

	RWController() {
		nr = 0;
		nw = 0;
	}

	procedure startRead() {
		if (nw > 0) {
			ok2read.wait();
		}
		nr++;
		ok2read.signal();
	}
	
	procedure endRead() {
		nr--;
		if (nr == 0) {
			ok2write.signal();
		}
	}
	
	procedure startWrite() {
		if (nr > 0 || nw == 1) {
			ok2write.wait();
		}
		nw++;
	}
	
	procedure endWrite() {
		nw--;
		ok2read.signal();
		if (nr == 0) {
			ok2write.signal();
		}
	}
}
```

<u>Nota bene</u>: anche in questo caso, con la `ok2read.signal()` tutti i lettori vengono sbloccati a catena e leggono contemporaneamente. L'ultimo lettore dà il via libera agli scrittori.

Questa soluzione dà priorità ai lettori, provocando eventualmente _starvation per gli scrittori_. Come prima, _possiamo adottare la mutua cortesia per poter risolvere la situazione_. E' necessario, però, essere a conoscenza del numero di scrittori in attesa (`ww`):
```C
monitor RWController {
	condition ok2read;
	condition ok2write;
	int nr;
	int nw;
	int ww;

	RWController() {
		nr = 0;
		nw = 0;
	}

	procedure startRead() {
		if (nw > 0 || ww > 0) {
			ok2read.wait();
		}
		nr++;
		ok2read.signal();
	}
	
	procedure endRead() {
		nr--;
		if (nr == 0) {
			ok2write.signal();
		}
	}
	
	procedure startWrite() {
		if (nr > 0 || nw == 1) {
			ww++;
			ok2write.wait();
			ww--;
		}
		nw++;
	}
	
	procedure endWrite() {
		nw--;
		ok2read.signal();
		if (nr == 0) {
			ok2write.signal();
		}
	}
}
```

## Referenze