---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 23-10-2024 22:02:30
links:
  - "[[lecture-11102024092906|Lecture 11102024092906]]"
  - "[[lecture-16102024132343|Lecture 16102024132343]]"
---
# C
---
## Caratteristiche
Le caratteristiche di C sono:
- dev'essere efficientissimo, conciso (non prolisso come Pascal)
- delega tutto il possibile alla _libreria standard C_
- non ha bisogno di software di supporto (senza nessuna libreria)
- il `;` trasforma le espressioni in istruzioni
- gli argomenti delle funzioni sono sempre passati per valore (ma si può passare per valore l'indirizzo di una variabile, ossia il suo [[puntatore|puntatore]])
- quando si nomina un vettore `T` si ottiene l'indirizzo di partenza del vettore (puntatore `T*`) e si alloca memoria per la sua lunghezza

### Conversione dei tipi
Un'operazione tra due operandi di tipo diverso _provoca la conversione del tipo meno importante nel tipo dell'altro operando_, a seconda di una classifica d'importanza dei tipi:
1. char
2. short unsigned short
3. int
4. unsigned
5. long
6. unsigned long
7. float
8. double
9. long double

Al momento dell'assegnamento del valore di un'espressione a una variabile, se necessario viene convertito il tipo, secondo le seguenti meccaniche:
- `int` -> `int più ampio`, semplice
- `int` -> `int meno ampio`, controintuitivo perché viene presa la parte meno significativa del numero
	- comodissimo: modulo 256 gratuito! infatti quando un `char` arriva 255 e si somma 1 (overflow) questo torna a 0 automaticamente, senza fare il modulo
- `int` -> `float`, conversione semplice
- `float` -> `int`, con approssimazione
- `float` -> `float`, adattamento della mantissa (con arrotondamento)

### Operatori booleani
Si distinguono in:
- _generali_ - `&&`, `||`, `!`;
- _bit a bit_ - `&`, `|`, `~`;

### Potenzialità
Con C si può lavorare sia ad alto che a basso livello. Per esempio si possono con estrema facilità manipolare i bit:
-  `if (r & 0x8)` o `if (r & (1 << 3))` controllano se il 4° bit da dx di `r` è a 1
- `r |= 1 << 4` o `r |= 0x10` per accendere il 5° bit da dx di `r`
- `r &= ~(1 << 5)` o `r &= ~(0x20)` spengono il 6° bit da dx di `r`
- `y = x << 2` per la moltiplicazione per 4

## Referenze
- [[gcc|GCC]]