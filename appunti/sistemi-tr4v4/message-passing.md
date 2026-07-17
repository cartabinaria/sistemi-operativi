---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 13-01-2025 16:14:13
links:
  - "[[lecture-29112024093415|Lecture 29112024093415]]"
---
# Message passing
---
## Introduzione
> Il **message passing** è un paradigma che consente a _[[processo|processi]] [[concorrenza|concorrenti]]_ a _memoria privata_[^1] di _comunicare tra di loro attraverso l'invio e la ricezione di messaggi_.

### Idea
Se i [[semafori|semafori]] e i [[monitor|monitor]] mediano tramite dei meccanismi di sincronizzazione l'accesso a risorse condivise (memoria condivisa), il _message passing permette ai processi di comunicare tra di loro senza condividere la memoria_.

Il message passing si basa sul concetto di messaggio: un insieme di informazioni formattate da un processo mittente e interpretate da un processo destinatario. Per poter funzionare, è necessario un **meccanismo supportato dal [[sistema-operativo|sistema operativo]] che si occupi di copiare le informazioni di un messaggio da uno spazio di indirizzamento di un processo a un altro**.

## Operazioni
Le operazioni principali del message passing sono:
- `send` - utilizzata dal mittente per spedire un messaggio ad un processo destinatario, che dev'essere specificato;
- `receive` - utilizzata dal processo destinatario per ricevere un messaggio da parte di un mittente, che può essere specificato o può essere uno qualsiasi (`ANY`).

Queste due operazioni, come già detto, sono implementate dal sistema operativo, per cui devono essere trattate come [[system-call|system calls]].

## Modelli
Esistono diversi modelli di message passing, a seconda del grado di sincronicità tra mittente e destinatario:
- **MP sincrono** - `send` e `receive` sono entrambe _bloccanti_ (sincrone);
- **MP asincrono** (più comune) - `send` è _asincrona_, mentre `receive` è _bloccante_;
- **MP completamente asincrono** (meno usata) - sia `send` che `receive` sono _asincrone_.

### MP sincrono
Nel dettaglio, nel message passing sincrono, quando un processo fa la `send` si blocca finché il destinatario non fa la `receive`; e viceversa, ossia quando un processo fa la `receive` si blocca finché il mittente non fa la `send`.
Viene anche detto message passing _senza memoria_: infatti **non c'è bisogno di mantenere una coda dei messaggi**.

_Sintassi `send`_: `void ssend(msg_t msg, pid_t dst)`;
_Sintassi `receive`_: `msg_t sreceive(pid_t snd)`.

<u>Attenzione</u>: se non si vuole specificare il mittente (`pid_t snd`) possiamo mettere la costante `ANY`.

### MP asincrono
Nel message passing asincrono, invece, la `send` non blocca il processo mittente, mentre la `receive` sì.
Questo **impone l'utilizzo di una [[struttura-dati|struttura dati]] per mantenere in memoria tutti i messaggi inviati ma non ancora ricevuti**.

_Sintassi `send`_: `void asend(msg_t msg, pid_t dst)`;
_Sintassi `receive`_: `msg_t sreceive(pid_t snd)`.

Anche in questo caso si può specificare `ANY` come mittente.

### MP completamente asincrono
Quest'ultimo modello è spesso considerato fine a se stesso, perché _non c'è nulla di bloccante_: né quando si invia un messaggio né quando lo si riceve.
Se si ha a disposizione sono questo modello di message passing, per creare soluzioni che prevedano attesa (nell'invio come nella ricezione), è per forza necessario fare **busy waiting**: si fa _`receive` finché non si riceve_, ma è una soluzione terribile.

_Sintassi `send`_: `void asend(msg_t msg, pid_t dst)`;
_Sintassi `receive`_: `msg_t areceive(pid_t snd)`.

### Equivalenze
Esploriamo le possibilità di costruire un modello a partire dall'altro.

#### MP sincrono da MP asincrono
Abbiamo a disposizione la `send` asincrona (`asend`) e la `receive` sincrona (`sreceive`). Per fare il message passing sincrono, allora, ci è sufficiente costruire la `send` sincrona (`ssend`).
Per farlo dobbiamo sfruttare l'unica arma sincrona a nostra disposizione: la `sreceive`. In particolare _sviluppiamo la `ssend` tale che invii un messaggio in modo asincrono con `asend` e poi si blocchi su una `receive` sincrona_, in _attesa di un messaggio di conferma di ricezione del destinatario_: una sorta di **ack**.
La `sreceive`, di conseguenza, dovrà essere adattata tale da _garantire che dopo aver ricevuto il messaggio venga inviato l'ack al mittente_ (in modo asincrono, con  `asend`).

```C
void ssend(msg_t msg, pid_t dst) {
	asend(<getpid(), msg>, dst);
	sreceive(dst);                        // ci si aspetta l'ACK
}

msg_t sreceive(pid_t snd) {               // `snd` potrebbe essere `ANY`!
	<pid, msg> = sreceive(snd);
	asend("ACK", pid);
	return msg;
}
```

<u>Nota bene</u>: è di fondamentale importanza [[incapsulamento|incapsulare]] nel messaggio `msg` anche il mittente (`getpid()`) per poter _garantire l'invio dell'ack anche nel caso in cui la `sreceive` sia chiamata con `ANY`_ (altrimenti non potremmo risalire al `pid` del mittente).

#### MP completamente asincrono da MP asincrono
In questo caso abbiamo sempre a disposizione la `send` asincrona (`asend`) e la `receive` sincrona (`sreceive`). Si vuole quindi implementare la `receive` asincrona (`areceive`).
Per farlo si deve trovare un meccanismo per sbloccare sempre la `sreceive`: ci si invia un **automessaggio**. In particolare, prima di fare effettivamente la `receive`, il processo invia un messaggio a se stesso. Quindi, _in caso in cui la `receive` sia su `ANY` questa viene sbloccata perché almeno un messaggio in coda è presente_; _nel caso in cui la `receive` sia su uno specifico `snd`, allora si scorrono tutti i messaggi in coda fino ad arrivare all'automessaggio (per eliminarlo), e a prescindere dal fatto che si trovi il messaggio di `snd` o meno, si va avanti_.

```C
void asend(msg_t msg, pid_t dst) {
	asend(<getpid(), msg>, dst);
}

msg_t areceive(pid_t snd) {
	asend(<getpid(), "AUTO">, getpid());
	while (true) {
		<pid, msg> = sreceive(ANY);
		if (pid == getpid() && msg == "AUTO")
			break;
		db.add(<pid, msg>);
	}
	<pid, msg> = db.get(snd);
	if (pid == NULL) return NULL;
	else return msg;
}
```

#### MP asincrono da MP sincrono
In quest'ultimo caso, il message passing sincrono ha solo "armi" sincrone per costruire il message passing asincrono: _non c'è nessun metodo asincrono a disposizione, che consenta di "sbloccare" la `ssend`_. L'unico stratagemma è quello di barare, adottando una soluzione che prevede l'utilizzo di un **server che funge da ufficio postale**.
Il server è un processo terzo che si occupa di ricevere i messaggi da parte dei mittenti e di inoltrarli ai destinatari. Questo, chiaramente, ha il compito di "sbloccare" le `ssend` (per renderle `asend`) inviando dei messaggi _ack_ ai mittenti.

```C
void asend(msg_t msg, pid_t dst) {
	ssend("SND(msg, getpid(), dst)", server);
}

msg_t sreceive(pid_t snd) {
	ssend("RCV(getpid(), snd)", server);
	msg_t msg = sreceive(server);
	return msg;
}

process server {
	int[][] waiting;
	Queue[][] queue;
	while (true) {
		handleMessage();
	}
}

void handleMessage() {
	msg = sreceive(ANY);
	if (msg == SND(m, s, d)) {
		if (waiting[s][d] > 0) {
			ssend(m, d);
			waiting[s][d]--;
		} else {
			queue[s][d].add(m);
		}
	} else if (msg == RCV(d, s)) {
		if (queue[s][d].isEmpty()) {
			waiting[s][d]++;
		} else {
			m = queue[s][d].get();
			ssend(m, d);
		}
	}
}
```

<u>Nota bene</u>: questa soluzione non gestisce il caso `ANY`.

<u>Nota bene</u>: il fatto che per realizzare il message passing asincrono con quello sincrono sia necessario un processo in più che gestisca la comunicazione, ci dice che l'**MP sincrono ha meno [[potere-espressivo|potere espressivo]] del MP asincrono**.

## Referenze
[^1]: vedere [[processo-modelli|Processo#Modelli]]