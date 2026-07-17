---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 20-11-2024 23:06:10
links:
  - "[[lecture-07112024092537|Lecture 07112024092537]]"
  - "[[lecture-15112024091205|Lecture 15112024091205]]"
  - "[[lecture-22112024091729|Lecture 22112024091729]]"
  - "[[lecture-29112024093415|Lecture 29112024093415]]"
---
# Produttore e consumatore
---
## Introduzione
> Il problema del **produttore e consumatore** è uno dei [[problemi-classici-della-programmazione-concorrente|problemi classici della programmazione concorrente]]. Consiste nell'interazione tra due processi, un _produttore_ e un _consumatore_, che devono condividere una variabile tale che il primo la modifica e il secondo la legge rispettando le seguenti proprietà:
> - il _producer non deve scrivere nuovamente l'area di memoria condivisa prima che consumer abbia effettivamente utilizzato il valore precedente_[^1];
> - il _consumer non deve leggere due volte lo stesso valore, ma attendere che il producer abbia generato il successivo_[^1];
> - assenza di [[deadlock|deadlock]];
> - assenza di [[starvation|starvation]].

## Implementazione
### Semafori
Il problema si può facilmente risolvere attraverso l'impiego di [[semafori|semafori]]:
```C
shared Object buffer;
Semaphore empty = new Semaphore(1);
Semaphore full = new Semaphore(0);

process Producer {
  while (true) {
	Object val = produce();
    empty.P();
    buffer = val;
    full.V();
  }
}

process Consumer {
  while (true) {
    full.P();
    Object val = buffer;
    empty.V();
    consume(val);
  }
}
```

<u>Nota bene</u>: _anche se ci fossero più produttori e più consumatori funzionerebbe ugualmente_, semplicemente solo un produttore o un consumatore accederebbe al `buffer` alla volta, e gli altri sarebbero in attesa rispettivamente nella coda di `empty` (`P`) e nella coda di `full` (`P`).

Infatti, se consideriamo un solo produttore e un solo consumatore, ha poco senso usare i semafori: _si tratta di una stretta alternanza tra i due processi_. I semafori hanno senso dal momento in cui entrano in gioco più produttori e più consumatori, perché è necessario garantire che un solo produttore o consumatore acceda al `buffer` alla volta, e allo stesso tempo assenza di starvation (semafori [[fifo|FIFO]]!).

<u>Nota bene</u>: la sezione critica sul `buffer` viene implementata senza alcun semaforo `mutex`, perché è garantita dal fatto che i produttori sono bloccati dai consumatori (`empty.P()`) e viceversa (`full.P()`). Questo meccanismo si chiama **passaggio del testimone**.

### Monitor
La soluzione tramite [[monitor|monitor]] è lineare tanto quanto quella con semafori. Supponiamo sempre che `Producer` e `Consumer` si comportino come segue:
```C
process Producer {
	while (true) {
		Object val = produce();
		pcController.write(val);
	}
}

process Consumer {
	while (true) {
		Object val = pcController.read();
		consume(val);
	}
}
```

Il monitor `PCController` che implementa tali funzioni è:
```C
monitor PCController {
	Object buffer;
	condition empty;
	condition full;
	bool isFull;

	PCController() {
		isFull = false;
	}

	procedure write(val) {
		if (isFull) {
			empty.wait();
		}
		buffer = val;
		isFull = true;
		full.signal();
	}

	procedure read() {
		if (!isFull) {
			full.wait();
		}
		Object val = buffer;
		isFull = false;
		empty.signal();
		return val;
	}
}
```

### Message passing
Infine, la soluzione tramite [[message-passing|message passing]] (con modello di MP sincrono) è la seguente:
```C
process Producer {
	Object buffer;
	while (true) {
		buffer = produce();
		ssend(buffer, Manager);
	}
}

process Consumer {
	Object buffer;
	while (true) {
		buffer = sreceive(Manager);
		consume(buffer);
	}
}

process Manager {
	Object buffer;
	while (true) {
		buffer = sreceive(Produce);
		ssend(buffer, Consumer);
	}
}
```

Si nota come `Producer` e `Consumer` non si scambino direttamente i messaggi, ma utilizzino un processo intermediario, `Manager`. Questo viene usato per garantire che il Producer, usando MP sincrono, non debba aspettare che il Consumer abbia ricevuto il messaggio per poter continuare a produrre, e viceversa.

## Referenze
[^1]: delle sorte di [[race-condition|race condition]]