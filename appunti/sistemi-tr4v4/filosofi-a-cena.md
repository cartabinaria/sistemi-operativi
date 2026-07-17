---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 02-12-2024 10:30:35
links:
  - "[[lecture-15112024091205|Lecture 15112024091205]]"
  - "[[lecture-22112024091729|Lecture 22112024091729]]"
  - "[[lecture-29112024093415|Lecture 29112024093415]]"
---
# Filosofi a cena
---
## Introduzione
> Il problema dei **filosofi a cena** è un altro dei [[problemi-classici-della-programmazione-concorrente|problemi classici della programmazione concorrente]], che a differenza del [[produttore-e-consumatore|produttore/consumatore]] e [[buffer-limitato|buffer limitato]], che mostrano come risolvere l'accesso esclusivo a una o più risorse, questo fa capire _come gestire situazioni in cui i processi entrano in competizione per accedere a insiemi di risorse con [[definizione-di-intersezione|intersezione]] non nulla_. In questo caso, i processi (i filosofi) hanno interferenze per accedere alle risorse (le bacchette).

## Teoria
![[filosofi-a-cena.png]]

Il problema consiste in 5 filosofi che siedono a un tavolo a cena. La loro vita consiste nel:
1. _pensare_;
2. _prendere le bacchette_;
3. _mangiare_;
4. _rilasciare le bacchette_.

```C
process Philo[i]] {
  while (true) {
    think();
    take_forks(i);
    eat();
    put_forks(i);
  }
}
```

Le **bacchette sono condivise**, tali che se un filosofo mangia, quelli ai lati non possono mangiare: _servono entrambe le bacchette per mangiare_. Formalmente si esprime questo concetto con l'invariante
$$down_{i} \leq up_{i} \leq down_{i} + 1$$
dove:
- $up_{i}$ è il numero di volte che la bacchetta $i$ viene presa;
- $down_{i}$ è il numero di volte che la bacchetta $i$ viene rilasciata.

L'invariante ci sta dicendo che per ogni bacchetta $i$, _il numero di volte in cui questa viene presa sarà maggiore o uguale al numero di volte in cui viene rilasciata al massimo di 1 unità_. Di conseguenza, se una bacchetta viene presa, non può essere ripresa finché non viene rilasciata. In altre parole ancora, le bacchette "_non si creano dal nulla_".

Per comodità scriveremo che
$$chopstick[i] = 1 - (up_{i} - down_{i})$$
per cui:
- se $up_{i} = down_{i}$ allora $chopstick[i] = 1$, infatti la bacchetta è disponibile;
- se $up_{i} = down_{i} + 1$ allora $chopstick[i] = 0$, infatti la bacchetta è occupata.

### Numero di filosofi
Il problema si risolve su 5 filosofi perché:
- se il _numero di filosofi è pari allora esiste una soluzione simmetrica_, poco interessante;
- il _caso con 3 filosofi è un caso particolare_, perché può mangiare solo uno alla volta.

## Implementazione
### Semafori
#### Idea
Potremmo pensare alle bacchette come a dei [[semafori|semafori]], inizializzati a 1 perché all'inizio tutte le bacchette sono disponibili. Quindi, ogni filosofo dovrebbe:
1. _pensare_;
2. _prendere la bacchetta di sinistra_;
3. _prendere la bacchetta di destra_;
4. _mangiare_;
5. _rilasciare le bacchette_.

Con i semafori una prima implementazione sarebbe allora la seguente:
```C
Semaphore chopstick[5] = {new Semaphore(1), new Semaphore(1), new Semaphore(1), new Semaphore(1), new Semaphore(1)};};

process Philo[i] {
  while (true) {
    think();
	chopstick[i].P();            // prendi la bacchetta di sinistra
    chopstick[(i + 1) % 5].P();  // prendi la bacchetta di destra
    eat();
    chopstick[i].V();
    chopstick[(i + 1) % 5].V();
  }
}
```

Tuttavia questo non garantirebbe l'assenza di [[deadlock|deadlock]]: per l'[[assioma-di-finite-progress|assioma di finite progress]], può capitare che _se tutti i filosofi prendono la bacchetta di sinistra, nessuno potrà prendere la bacchetta di destra_. La radice del problema sta nel fatto che _la presa delle bacchette è circolare_.

#### Soluzione
Per rompere la circolarità ci sono una serie di stratagemmi:
1. _un filosofo mancino_ che prende le bacchette in ordine inverso;
2. _filosofi pari mancini_ e _filosofi dispari destri_;
3. _al più quattro filosofi possono sedersi a tavola_ (con lo stesso numero di posate);
4. _le bacchette sono prese insieme_;

Nel primo caso il codice diventerebbe:
```C
Semaphore chopstick[5] = {new Semaphore(1), new Semaphore(1), new Semaphore(1), new Semaphore(1), new Semaphore(1)};};

process Philo[i] {
  while (true) {
    think();
    chopstick[i].P();
    chopstick[(i + 1) % 5].P();
    eat();
    chopstick[i].V();
    chopstick[(i + 1) % 5].V();
  }
}

# Il quarto filosofo è mancino
process Philo[4] {
  while (true) {
    think();
    chopstick[(i + 1) % 5].P();
    chopstick[i].P();
    eat();
    chopstick[(i + 1) % 5].V();
    chopstick[i].V();
  }
}
```

Nell'ultimo caso, invece, è _necessaria un'ulteriore [[sezione-critica|sezione critica]] per garantire che le bacchette vengano prese insieme_. Inoltre si tratta dell'unico caso che provoca [[starvation|starvation]]: **i filosofi possono infatti mettersi d'accordo per far sì che uno di loro non mangi mai**. Questo, una causa dell'assioma di finite progress, avviene per esempio se i filosofi 0 e 2 sono così veloci da riuscire a prendere sempre le bacchette prima che lo facciano i filosofi 1, 3 e 4.

##### Starvation
Presentiamo, giusto per completezza, una soluzione con _starvation_:
```Python
sem mutex(1)
bool eating[5]
bool waiting[5]
sem ok2eat[5]{0,...,0}

# + - --> somma/differenza con modulo 5

process philo[i  i=0...4]:
    while True:
        # starteat
        mutex.P()
        if eating[i+1] or eating[i-1]:
	        waiting[i] = True
	        mutex.V()
	        ok2eat[i].P()
        else:
	        eating[i] = True
	        mutex.V()
        [eat]
        # endeat
        
        mutex.P()
        eating[i] = False
        if not eating[i+2] and waiting[i+1]:
	        eating[i+1] = True
            waiting[i+1] = False
            ok2eat[i+1].V()
		if not eating[i-2] and waiting[i-1]:
			eating[i-1] = True
			waiting[i-1] = False
			ok2eat[i-1].V()
        mutex.V()
        [think]
```

Può esserci la congiura dei filosofi, per l'assioma di finite progress.

### Monitor
La soluzione attraverso i [[monitor|monitor]], assumendo che un filosofo si comporti come
```C
process Philo[i] {    // i = 0...4
	while (true) {
		think();
		pController.startEating(i);
		eat();
		pController.finishEating(i);
	}
}
```
è la seguente:
```C
monitor PController {
	condition chopsticks[5];
	bool isFree[5];

	PController() {
		isFree[0..5] = true;
	}

	procedure startEating(i) {
		if (!isFree[i])
			chopsticks[i].wait();
		isFree[i] = false;
		if (!isFree[(i+1)%5])
			chopsticks[(i+1)%5].wait();
		isFree[(i+1)%5] = false;
	}

	procedure finishEating(i) {
		isFree[i] = true;
		isFree[(i+1)%5] = true;
		chopsticks[i].signal();
		chopsticks[(i+1)%5].signal();
	}
}
```

<u>Nota bene</u>: anche senza filosofo mancino, non si ha deadlock. Questo perché le procedure dentro il monitor sono eseguite in modo atomico, per cui _l'operazione `startEating` prende entrambe le bacchette "contemporaneamente"_.

### Message passing
Infine, la soluzione tramite [[message-passing|message passing]] (con modello di MP asincrono) è la seguente:
```C
process Philo[i] {
	while (true) {
		[think]
		asend(<"PICKUP", i>, chopstick[MIN(i, (i+1)%5)]);
		msg = areceive(chopstick[MIN(i, (i+1)%5)]);
		asend(<"PICKUP", i>, chopstick[MAX(i, (i+1)%5)]);
		msg = areceive(chopstick[MAX(i, (i+1)%5)]);
		[eat]
		asend(<"PUTDOWN", i>, chopstick[MIN(i, (i+1)%5)]);
		asend(<"PUTDOWN", i>, chopstick[MAX(i, (i+1)%5)]);
	}
}

process chopstick[i] {
	bool free = true;
	Queue queue = new Queue();

	while (true) {
		handleRequests();
	}
}

void handleRequests() {
	msg = areceive(ANY);
	if (msg == <"PICKUP", j>) {
		if (free) {
			free = false;
			asend("ACK", philo[j]);
		} else {
			queue.add(j);
		}
	} else if (msg == <"PUTDOWN", j>) {
		if (queue.isEmpty()) {
		    free = true;
	    } else {
		    k = queue.remove();
		    asend("ACK", philo[k]);
	    }
	}
}
```

## Referenze