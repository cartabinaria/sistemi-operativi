---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 20-11-2024 23:24:17
links:
  - "[[lecture-07112024092537|Lecture 07112024092537]]"
  - "[[lecture-22112024091729|Lecture 22112024091729]]"
---
# Buffer limitato
---
## Introduzione
> Il **buffer limitato** è una variante del [[produttore-e-consumatore|problema del produttore e consumatore]], uno dei [[problemi-classici-della-programmazione-concorrente|problemi classici della programmazione concorrente]], in cui la variabile condivisa è un buffer di _capacità massima_ (un [[array|array]] di elementi). Anche in questo caso bisogna garantire le seguenti proprietà:
> - il _producer non deve sovrascrivere elementi del buffer prima che il consumer abbia effettivamente utilizzato i relativi valori_;
> - il _consumer non deve leggere due volte lo stesso valore, ma attendere che il producer abbia generato il successivo_;
> - assenza di [[deadlock|deadlock]];
> - assenza di [[starvation|starvation]].

## Implementazione
### Semafori
Ancora possiamo usare i [[semafori|semafori]] per risolvere il problema:
```C
Queue q(maxsize = SIZE);
Semaphore empty = new Semaphore(SIZE);
Semaphore full = new Semaphore(0);
Semaphore mutex = new Semaphore(1);

process Producer {
  while (true) {
    Object val = produce();
    empty.P();
    mutex.P();
    q.enqueue(val);
    mutex.V();
    full.V();
  }
}

process Consumer {
  while (true) {
    full.P();
    mutex.P();
    Object val = q.dequeue();
    mutex.V();
    empty.V();
    consume(val);
  }
}
```

<u>Nota bene</u>: in questo caso, è necessario un semaforo `mutex` perché il buffer è una variabile condivisa con una grandezza limitata, e _`empty.P()` (per i produttori) e `full.P()` (per i consumatori) non sono per forza bloccanti_. Per esempio, se `empty` ha valore 3, due produttori possono tranquillamente fare `empty.P()` e accedere al buffer simultaneamente, ma ciò non va bene perché il buffer `q` è condiviso. Quindi serve un semaforo `mutex` per garantire la mutua esclusione. Lo stesso ragionamento vale per i consumatori nel caso di `full.P()`.

### Monitor
La soluzione tramite [[monitor|monitor]], assumendo che i processi `Producer` e `Consumer` siano del tipo
```C
process Producer_i {
	while (true) {
		Object val = produce();
		prController.write(val);
	}
}

process Consumer_i {
	while (true) {
		Object val = pcController.read();
		consume(val);
	}
}
```
, è la seguente:
```C
monitor PCController {
	Queue buffer[MAXSIZE];
	int n;
	condition existsSpace;
	condition existsElement;

	PCController() {
		n = 0;
	}

	procedure write(val) {
		if (n == MAXSIZE) {
			existsSpace.wait();
		}
		buffer.enqueue(val);
		n++;
		existsElement.signal();
	}

	procedure read() {
		if (n == 0) {
			existsElement.wait();
		}
		Object val = buffer.dequeue();
		n--;
		existsSpace.signal();
		return val;
	}
}
```

## Referenze