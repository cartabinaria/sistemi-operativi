---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 03-11-2024 12:23:40
links:
  - "[[lecture-24102024091305|Lecture 24102024091305]]"
  - "[[lecture-15112024091205|Lecture 15112024091205]]"
---
# Semafori
---
## Introduzione
> I **semafori** sono un _paradigma per la sincronizzazione di [[processo|processi]] [[concorrenza|concorrenti]], che risolvono il [[problema-della-sezione-critica|problema della sezione critica]] in modo semplice ed elegante_.

L'obiettivo è di descrivere un [[sistema-operativo|SO]] come una collezione di processi sequenziali che cooperano. Il principio alla base dei semafori, descritto da [[edsger-dijkstra|Dijkstra]], consiste in due o più processi che cooperano attraverso segnali, in modo tale che _un processo possa essere bloccato finché non riceve un segnale da un altro processo_.

## Definizione
> Un **semaforo** è un [[struttura-dati|tipo di dato astratto]] per il quale sono definite due operazioni:
> - `V` (dall'olandese _verhogen_) --> invocata per inviare un segnale, quale il verificarsi di un evento o il rilascio di una risorsa;
> - `P` (dall'olandese _proberen_) --> invocata per attendere il segnale (un evento o il rilascio di una risorsa).
> 
> Più informalmente, un semaforo è una variabile intera inizializzata a un valore non negativo, con due metodi `V` e `P` che:
> - `V` --> _incrementa il valore del semaforo_;
> - `P` --> _attende che il valore del semaforo sia positivo, e se lo è lo decrementa_.
> 
> <u>Nota bene</u>: `P` e `V` sono [[azione-atomica|azioni atomiche]].

```C
class Semaphore {
	Semaphore(int v);
	void P(void);
	void V(void);
}
```

### Invariante
La legge fondamentale dei semafori, detta **invariante**, si riassume nella seguente disequazione
$$n_{p} \leq n_{v} + \text{init}$$
dove:
- $n_{p}$ è il numero di operazioni `P` completate;
- $n_{v}$ è il numero di operazioni `V` completate;
- $\text{init}$ è il valore iniziale del semaforo.

Equivalentemente si ha
$$n_{v} + \text{init} - n_{p} \geq 0$$
ovvero _il valore del semaforo deve sempre essere non negativo_.

### Casi d'uso
Il valore iniziale del semaforo $\text{init}$ è estremamente rilevante, perché da esso ne dipende l'utilizzo stesso del semaforo. Per esempio:
- $\text{init} = 0$ - _gestione degli eventi_, infatti è un semaforo che mette in sequenza i processi creando delle dipendenze;
- $\text{init} > 0$ - _gestione delle risorse_, infatti è un semaforo che consente la condivisione sincronizzata di risorse.

## Sezione critica
Come implementare la [[sezione-critica|sezione critica]] con un semaforo? Semplice:
```C
Semaphore s = new Semaphore(1);

process P {
	while (true) {
		s.P();
		[enter cs]
		s.V();
		[exit cs]
	}
}

process Q {
	while (true) {
		s.P();
		[enter cs]
		s.V();
		[exit cs]
	}
}
```

### Dimostrazione
#### Mutua esclusione
Assumiamo [[dimostrazione-per-assurdo|per assurdo]] che `P` e `Q` siano simultaneamente nella CS. Affinché ci siano entrati, vuol dire che è stata eseguita due volte `s.P()`. Ma il valore iniziale di `s` è 1, e il semaforo non può assumere valori negativi, assurdo.

**Qed**.

#### Assenza di deadlock
Assumiamo per assurdo che `P` e `Q` siano in deadlock. Allora significa che entrambi stanno eseguendo `s.P()` e il valore del semaforo è a 0. Ma affinché il valore del semaforo sia a 0, avendo $\text{init} = 1$, significa che almeno un `s.P()` è stato eseguito, e di conseguenza anche un `s.V()`. Ma allora il valore del semaforo dev'essere uguale a 1, assurdo.

**Qed**.

#### Assenza di starvation
Assumiamo che i processi che richiamano `s.P()` siano messi in una [[coda|coda]], tale che venga rispettato l'ordine di chiamata della funzione. Allora se per assurdo `P` non entra mai nella CS, vorrebbe dire che `Q` richiama sempre `s.P()` prima di `P`, impossibile in quanto dev'essere rispettata la politica [[fifo|FIFO]].

**Qed**.

#### Assenza di delay non necessari
Se per assurdo né `P` né `Q` sono nella CS, significa che entrambi stanno eseguendo `s.P()`. Ma avendo $\text{init = 1}$, per forza uno dei due processi entrerà nella CS, assurdo.

**Qed**.

## Gestione dei processi
In realtà, come già anticipato nella dimostrazione precedente, è **necessario introdurre delle politiche di gestione dei processi bloccati** (che richiamano `P`). In modo particolare occorre mantenere una _struttura dati che mantenga i processi sospesi_ (in attesa). Se questa struttura dati è di tipo FIFO (come una coda), allora si dice che il semaforo implementato è di tipo **FIFO/fair**, ed è ciò che garantisce assenza di [[starvation|starvation]].

## Implementazione
Assumendo di star lavorando con semafori FIFO/fair, in un sistema operativo questi si implementano nel seguente modo:
```C
void P() {
	[enter cs]
	if (value > 0)
		value--;
	else {
		pid = </*id del processo*/>;
		queue.add(pid);
		suspend(pid);
	}
	[exit cs]
}

void V() {
	[enter cs]
	if (queue.empty())
		value++;
	else {
		pid = queue.remove();
		wakeup(pid);
	}
	[exit cs]
}
```

Come già detto, le due operazioni devono essere eseguite come azioni atomiche, per questo sono a loro volta racchiuse in una sezione critica. Ma **se i semafori implementano le sezioni critiche, la sezione critica dei semafori come dev'essere fatta**? Bisognerà usare una tecnica di più basso livello per implementare i semafori:
- _tecniche software_ ([[algoritmo-di-dekker|Algoritmo di Dekker]], [[algoritmo-di-peterson|Algoritmo di Peterson]]);
- _tecniche hardware_ ([[disabilitazione-degli-interrupt|Disabilitazione degli interrupt]], [[spinlock|Spinlock]]).

Quindi se si usano queste tecniche per implementare i semafori, non si elimina il _busy waiting_. Ma abbiamo limitato formalmente le CS alle sole operazioni `P` e `V`, che sono molto brevi: **la sezione critica non è quasi mai occupata, per cui il busy waiting avviene raramente**.
![[semafori-vantaggi.png]]

## Difetti
Con i semafori si possono fare tante cose, ma sono costrutti di basso livello[^1]. Si possono commettere errori banali:
- _omettere `P` o `V`_;
- _scambiare l'ordine delle operazioni_;
- _fare operazioni `P` e `V` su semafori sbagliati_.

Inoltre, è responsabilità del programmatore accedere ai dati condivisi in modo corretto, e vi sono forti problemi di leggibilità.

## Referenze
- [[semafori-binari|Semafori binari]]

[^1]: un equivalente dell'[[assembly|assembly]] nei [[linguaggio-di-programmazione|linguaggi di programmazione]]