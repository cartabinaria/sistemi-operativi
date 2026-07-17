---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 03-11-2024 13:28:02
links:
  - "[[lecture-24102024091305|Lecture 24102024091305]]"
  - "[[lecture-07112024092537|Lecture 07112024092537]]"
---
# Semafori binari
---
## Introduzione
> I **semafori binari** sono una _variante dei [[semafori|semafori generali]] in cui il valore del semaforo può assumere solo i valori 0 e 1_.

### Invariante
Chiaramente l'invariante del semaforo binario è più vincolante di quella del semaforo generale:
$$0 \leq n_{v} + \text{init} - n_{p} \leq 1$$
o equivalentemente
$$0 \leq \text{s.value} \leq 1$$

Si nota quindi come la prima parte della disequazione vincola `P` (come per i semafori generali), mentre la seconda aggiunge il vincolo su `V` (non può essere fatta se il valore del semaforo è già a 1).

## Implementazione
Nei [[sistema-operativo|sistemi operativi]], questi semafori si implementano nel seguente modo:
```C
class BinarySemaphore {
	private int value;
	Queue queueP = new Queue();
	Queue queueV = new Queue();

	BinarySemaphore() {
		value = 1;
	}

	void P() {
		[enter cs]
		int pid = </*process id*/>;
		if (value == 0) {
			queueP.enqueue(pid);
			suspend(pid);
		} else if (queueV.size() > 0) {
			int pid = queueV.dequeue();
			wakeup(pid);
		} else {
			value--;
		}
		[exit cs]
	}
	
	void V() {
		[enter cs]
		int pid = </*process id*/>;
		if (value == 1) {
			queueV.enqueue(pid);
			suspend(pid);
		} else if (queueP.size() > 0) {
			int pid = queueP.dequeue();
			wakeup(pid);
		} else {
			value++;
		}
		[exit cs]
	}
}
```

## Equivalenze
La **potenza espressiva dei semafori binari è la stessa dei semafori generali**, e per dimostrarlo è sufficiente implementare questi ultimi con i primi e viceversa.

### Semafori generali (con binari)
```C
class Semaphore {
	private BinarySemaphore mutex(1);
	int value;
	QueueOfBinSem queue = new QueueOfBinSem();

	Semaphore(int v) {
		value = v;
	}

	void P() {
		mutex.P();
		if (value > 0) {
			value--;
			mutex.V();
		} else {
			S = new BinarySemaphore(0);
			queue.enqueue(S);
			mutex.V();
			S.P();
			free(S);
		}
	}
	
	void V() {
		mutex.P();
		if (queue.empty()) {
			value++;
		} else {
			BinarySemaphore s = queue.dequeue();
			S.V();
		}
		mutex.V();
	}
}
```

<u>Nota bene</u>: il `mutex.V()` messo prima di `S.P()` è necessario per liberare la [[sezione-critica|sezione critica]] prima che `S` venga messo in attesa (con `P`). Se fosse messo dopo, creerebbe [[deadlock|deadlock]].

### Semafori binari (con generali)
```C
class BinarySemaphore {
	private Semaphore s0, s1;

	BinarySemaphore(int v) {
		s0 = new Semaphore(v);
		s1 = new Semaphore(1-v);
	}

	void P() {
		s0.P();
		s1.V();
	}

	void V() {
		s1.P();
		s0.V();
	}
}
```

<u>Nota bene</u>: il motivo per cui in questo caso non viene utilizzato un semaforo `mutex` è che non ci sono variabili condivise tra i due semafori binari, per cui _non c'è bisogno di "proteggere" alcuna sezione critica_.

## Referenze