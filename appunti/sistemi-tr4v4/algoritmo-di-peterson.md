---
tags:
  - category/note
  - status/ongoing
  - topic/sistemi-operativi
date: 02-11-2024 17:45:39
links:
  - "[[lecture-17102024091631|Lecture 17102024091631]]"
  - "[[lecture-24102024091305|Lecture 24102024091305]]"
---
# Algoritmo di Peterson
---
## Introduzione
> L'**algoritmo di Peterson** è un [[algoritmo|algoritmo]] che semplifica e linearizza l'[[algoritmo-di-dekker|algoritmo di Dekker]] per risolvere il [[problema-della-sezione-critica|problema della sezione critica]] considerando $N$ [[processo|processi]].

Dekker generalizzato a $N$ processi è difficilissimo, invece Peterson no.

## Algoritmo
### 2 processi
```C
shared boolean need_p = false;
shared boolean need_q = false;
shared int turn;

process P {
	need_p = true;
	turn = Q;
	while (need_q && turn == Q);
	[enter cs]
	need_p = false;
	[exit cs]
}

process Q {
	need_q = true;
	turn = P;
	while (need_p && turn == P);
	[enter cs]
	need_q = false;
	[exit cs]
}
```

#### Dimostrazione
##### Mutua esclusione
Supponiamo [[dimostrazione-per-assurdo|per assurdo]] che `P` e `Q` si trovino contemporaneamente nella CS. Quindi `need_p = true` e `need_q = true`, che significa che la seconda condizione dei due `while` dev'essere `false`: `turn = P` e `turn = Q`, il che è impossibile, assurdo.

**Qed**.

##### Assenza di deadlock
Supponiamo per assurdo che `P` e `Q` non possano entrare nella CS. Entrambi devono quindi ciclare nel `while`, ma questo può essere vero se e solo se valgono entrambe le condizioni per i `while`: `need_q = true` e `need_p = true` va bene, ma `turn = P` e `turn = Q` è impossibile, assurdo.

**Qed**.

##### Assenza di starvation
Supponiamo che `P` non sia mai nella CS. Questo avviene se e solo se rimane bloccato nel suo `while`, per cui `need_q = true` e `turn = Q`. Quindi `Q` entra nella CS, e uscendo imposta `need_q = false`, assurdo.

**Qed**.

##### Assenza di delay non necessari
Se `Q` ha `needq = false` (non esegue codice critico), allora $P$ può uscire dal `while` ed entrare nella CS.

### $N$ processi
```C
shared int[] stage = new int[N];
shared int[] last = new int[N];

process P_i {
	while (true) {
		for (int j=0; j < N; j++) {
			stage[i] = j;
			last[j] = i;
			for (int k=0; k < N; k++) {
				if (i != k) {
					while (stage[k] >= stage[i] && last[j] == i);
				}
			}
		}
		[enter cs]
		stage[i] = 0;
		[exit cs]
	}
}
```

## Referenze