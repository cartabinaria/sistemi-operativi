---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 24-10-2024 00:27:43
links:
  - "[[lecture-17102024091631|Lecture 17102024091631]]"
---
# Algoritmo di Dekker
---
## Introduzione
> L'**algoritmo di Dekker** è un [[algoritmo|algoritmo]] che principalmente garantisce la [[mutua-esclusione|mutua esclusione]] nella [[concorrenza|programmazione concorrente]], ma che è in grado di _risolvere del tutto il [[problema-della-sezione-critica|problema della sezione critica]]_ (lato software).

E' stato pubblicato da [[edsger-dijkstra|Edsger Dijkstra]].

## Algoritmo
La soluzione viene presentata in 4 fasi, ognuna delle quali presenterà soluzioni a determinate proprietà (di [[proprieta-safety|safety]] e [[proprieta-liveness|liveness]]), ma genererà altri problemi.

### Tentativo 1
```C
shared int turn = P;

process P {
	while (true) {
		while (turn == Q);
		[enter cs]
		turn = Q;
		[exit cs]
	}
}

process Q {
	while (true) {
		while (turn == P);
		[enter cs]
		turn = P;
		[exit cs]
	}
}
```

Questa soluzione garantisce mutua esclusione, assenza di deadlock e assenza di starvation. Tuttavia **impone un'esecuzione sincronizzata dei processi** `P` e `Q`, del solo tipo `P, Q, P, Q, P, ...`. Questo causa un grande problema: se `P` vuole entrare nella CS, deve per forza aspettare che `Q` entra ed esca; ma `Q` potrebbe essere estremamente lento o addirittura potrebbe bloccarsi (per una qualunque ragione). Questo bloccherebbe anche `P`, causando **delay non necessari**.

Vogliamo infatti _garantire che lo stop di uno dei due processi non rallenti l'entrata dell'altro nella CS_.

### Tentativo 2
```C
shared boolean in_q = false;
shared boolean in_p = false;

process P {
	while (true) {
		while (in_q);
		in_p = true;
		[enter cs]
		in_p = false;
		[exit cs]
	}
}

process Q {
	while (true) {
		while (in_p);
		in_q = true;
		[enter cs]
		in_q = false;
		[exit cs]
	}
}
```

Questa soluzione consiste nel dividere la variabile `turn` in due booleani `in_q`, `in_p`. Così facendo viene **completamente risolto il problema dei delay non necessari**. Infatti, se mentre `Q` è nella CS, `P` si arresta nel `while`, quando `Q` uscirà non rimarrà bloccato nel `while` perché `in_p` sarà rimasto `false`! Per cui potrà rientrare nella CS, fino a quando `P` non torna in esecuzione.

Il problema però è che può **facilmente essere violata la mutua esclusione**. Infatti se consideriamo il caso in cui `Q` esce dalla CS, quindi `P` esce dal `while` (in quanto `in_q = false`) e `Q` è così veloce[^1] da eseguire la condizione del `while` prima che `P` imposti `in_p = true`, _sia `P` che `Q` entrano nella CS_!

### Tentativo 3
```C
shared boolean in_q = false;
shared boolean in_p = false;

process P {
	while (true) {
		in_p = true;
		while (in_q);
		[enter cs]
		in_p = false;
		[exit cs]
	}
}

process Q {
	while (true) {
		in_q = true;
		while (in_p);
		[enter cs]
		in_q = false;
		[exit cs]
	}
}
```

Questa soluzione risolve **rispetta le proprietà safety e in particolare la mutua esclusione**. Ma **genera deadlock**: se consideriamo il caso in cui `Q` esce dalla CS, ed è più veloce di `P` tale che assegna subito `in_q = true` senza lasciare tempo a `P` di leggere `in_q = false`, avviene che sia `in_p` che `in_q` sono `true` $\implies$ _i processi `P` e `Q` sono in deadlock_.

### Tentativo 4
```C
shared boolean in_q = false;
shared boolean in_p = false;

process P {
	while (true) {
		in_p = true;
		while (in_q) {
			in_p = false;
			// random delay
			in_p = true;
		}
		[enter cs]
		in_p = false;
		[exit cs]
	}
}

process Q {
	while (true) {
		in_q = true;
		while (in_p) {
			in_q = false;
			// random delay
			in_q = true;
		}
		[enter cs]
		in_q = false;
		[exit cs]
	}
}
```

Questa soluzione possiamo considerarla come un'ottimizzazione del tentativo precedente. Infatti switchando i valori dei rispettivi `in_` all'interno del `while`, e inserendo un delay randomico tra lo switch, **si garantisce lo sblocco della situazione di deadlock** causata da `in_p = true` e contemporaneamente `in_q = true`. Rispetto all'esempio precedente, si dà l'opportunità a `P` di leggere `in_q = false`, e quindi di entrare nella CS.

Tuttavia, **un caso sfortunato potrebbe provocare starvation**: se `Q` entra ed esce dalla CS, è più veloce di `P` e quindi esegue `in_q = true` subito dopo, sia `Q` che `P` si trovano nel loro rispettivo `while`; assumendo sempre che `Q` sia più veloce di `P`, quando `P` assegna `in_p = false`, `Q` coglie l'opportunità ed esce dal ciclo, entrando nuovamente nella CS. Se questo capita ad ogni iterazione, _`P` è in starvation_.

### Soluzione
I 4 precedenti tentativi ci suggeriscono come procedere verso la soluzione corretta: _il 1°, infatti, è ideale per rompere la simmetria che causa deadlock e starvation nel 3° e nel 4°_; _il 3° consente di superare la stretta alternanza dei turni del 1°_; _il meccanismo di mutua cortesia (lasciare il passo) del 4° è ideale per evitare il deadlock del 3°_.
Allora uniamo le cose!
```C
shared int turn = P;
shared boolean need_p = false;
shared boolean need_q = false;

process P {
	while (true) {
		need_p = true;
		while (need_q) {
			if (turn == Q) {
				need_p = false;
				while (turn == Q);
				need_p = true;
			}
		}
		[enter cs]
		need_p = false;
		turn = Q;
		[exit cs]
	}
}

process Q {
	while (true) {
		need_q = true;
		while (need_p) {
			if (turn == P) {
				need_q = false;
				while (turn == P);
				need_q = true;
			}
		}
		[enter cs]
		need_q = false;
		turn = P;
		[exit cs]
	}
}
```

#### Dimostrazione
##### Mutua esclusione
Dimostriamo che `P` e `Q` non possono trovarsi nella CS simultaneamente. Procediamo [[dimostrazione-per-assurdo|per assurdo]], assumendo che `P` e `Q` siano entrambi nella CS. Se questo è vero, allora `need_q = true` e `need_p = true` (dall'uscita del `while`). Supponiamo `Q` sia entrato per primo nella CS, allora `need_q = true` fino a quando non esce dalla CS; ma affinché `P` entri nella CS, deve essere `need_q = false`. Questo significa che c'è un istante temporale in cui, mentre `Q` è nella CS, `need_q = false`: assurdo perché `need_q = true` finché `Q` non esce per ipotesi.

**Qed**.

##### Assenza di deadlock
Assumiamo, per assurdo, che `P` e `Q` siano in deadlock, ovvero che non possano entrare nella CS. Questo significa che `need_q = true` e `need_p = true` contemporaneamente. Ora, la variabile `turn` supponiamo abbia valore `P`, allora nel `while` di `Q` avviene che `need_q = false` e tale valore non torna a `true` fino a che `turn` rimane `P`. Ma `turn = Q` solo se `P` entra/esce nella CS. Per ipotesi `P` non è nella CS, per cui `turn` rimane a `P`. Questo implica che `need_q` rimane `false`, contraddicendo l'ipotesi che `need_q = true`.

**Qed**.

##### Assenza di starvation
Supponiamo, per assurdo, che `P` sia in starvation, ovvero che non possa entrare mai nella CS. Affinché `P` rimanga nel `while` deve succedere che:
- o `need_q = true` sempre;
- o `turn = Q` sempre.

Se suppongo che `need_q = true` per sempre, allora per l'assenza di deadlock avviene che `Q` prima o poi entra nella CS. Ma all'uscita setta `need_q = false`, assurdo.

Se suppongo `turn = Q` per sempre, allora per l'assenza di deadlock avviene che `Q` prima o poi entra nella CS. Ma all'uscita setta `turn = P`, assurdo.

**Qed**.

##### Assenza di delay non necessari
Supponiamo, per assurdo, che né `P` né `Q` siano nella CS. Se per ipotesi `turn = P`, allora `need_q` viene impostato a `false` e `P` entra nella CS, assurdo.

**Qed**.

## Referenze
- [articolo](https://www.cs.utexas.edu/~EWD/transcriptions/EWD01xx/EWD123.html#2.1.%20A%20Simple%20Example.)

[^1]: ricordiamo di non poter conoscere la velocità di esecuzione dei processi per l'[[assioma-di-finite-progress|assioma di finite progress]]