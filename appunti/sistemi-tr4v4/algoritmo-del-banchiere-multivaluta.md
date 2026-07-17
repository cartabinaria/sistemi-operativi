---
tags:
  - category/note
  - status/ongoing
  - topic/sistemi-operativi
date: 26-03-2025 13:47:52
links:
  - "[[lecture-13032025151745|Lecture 13032025151745]]"
---
# Algoritmo del banchiere multivaluta
---
## Introduzione
> L'**algoritmo del banchiere multivaluta** e' l'evoluzione dell'[[algoritmo-del-banchiere|algoritmo del banchiere]] che prende in considerazione piu' valute, ovvero piu' classi di [[risorsa|risorse]].

## Idea
### Parametri
I parametri sono estensioni [[vettore|vettoriali]] di quelli dell'algoritmo base:
- $N$ numero di clienti
- $\underline{IC}$ capitale iniziale (vettore, uno per ogni valuta)
- $\underline{c_{i}}$ limite di credito del cliente $i$ ($\underline{c_{i}} \leq \underline{IC}$)
- $\underline{p_{i}}$ denaro prestato al cliente $i$ ($\underline{p_{i}} \leq \underline{c_{i}}$)
- $\underline{n_{i}} = \underline{c_{i}} - \underline{p_{i}}$ credito residuo del cliente $i$
- $\underline{COH} = \underline{IC} - \sum\limits_{i=1}^{n} \underline{p_{i}}$ (saldo di cassa)

### Stato
Definiamo $s$ una sequenza ([[permutazione|permutazione]]) degli $N$ indici, e i vettori $\underline{avail}$ come segue:
- $\underline{avail[1]} = \underline{COH}$;
- $\underline{avail[i+1]} = \underline{avail[i]} + \underline{p_{s[i]}} \ \ \ \forall i = 1, \cdots, N-1$;

#### Safe
> Definiamo lo stato **safe** se esiste una sequenza $s$ tale che
> $$\underline{n_{s[i]}} \leq \underline{avail[i]} \ \ \ i=1, \cdots, N$$
> Tale stato e' sufficiente a garantire l'assenza di deadlock.

#### Unsafe
> Lo stato **unsafe** e' condizione invece necessaria ma non sufficiente per avere deadlock, ovvero non e' detto ma e' possibile che ci sia deadlock.

## Algoritmo
Questa volta, per scegliere la sequenza $s$, non possiamo semplicemente ordinare i clienti in ordine crescente per $\underline{n_{i}}$ (perche' e' un vettore).

Possiamo pero' procedere scegliendo passo passo il cliente ([[processo|processo]]) a caso tra quelli completamente soddisfacibili, ossia al passo $i$ scegliere un cliente per cui vale
$$\underline{n_{s[i]}} \leq \underline{avail[i]}$$

Infatti c'e' un _teorema che ci garantisce che questa sequenza si trova se e solo se lo stato e' safe_.

### Teorema
> Se durante la costruzione della sequenza $s$ si giunge ad un punto in cui nessun processo risulta soddisfacibile, allora l'intero stato non è safe.

In poche parole non serve testare tutte le possibili sequenze: _se costruendo la sequenza nel modo descritto in precedenza si giunge a un processo non soddisfacibile, allora non esiste alcuna sequenza che soddisfi tutti i processi_.

#### Dimostrazione
Assumiamo di aver costruito una sequenza $s$ di lunghezza $k < N$ non soddisfacibile, ossia che $$\underline{n_{s[i]}} \leq \underline{avail[i]} \ \ \ i=1, \cdots, k \ \ \ \land \ \ \ \underline{n_{s[k+1]}} > \underline{avail[k+1]}$$.
Supponiamo ora l'esistenza di una sequenza $s'$ di lunghezza $N$ soddisfacibile, per cui
$$\underline{n_{s'[i]}} \leq \underline{avail[i]} \ \ \ i=1, \cdots, N$$

Notiamo che sicuramente tra i primi $k$ elementi di $s'$ ce ne dev'essere sicuramente qualcuno che non e' in $s$. Formalmente
$$\exists z \in \{s'[i] | i = 1, \cdots, k\} \ \ : \ \ z \notin s$$

Potremmo quindi dire che fino a $z$ le due sequenze abbiano gli stessi elementi, e che da $z$ in poi si separino. Supponendo che l'indice di $z$ sia $j \in \{1, \cdots, k\}$, allora vale
$$\{s[i] | i = 1, \cdots, j-1\} = \{s'[i] | i = 1, \cdots, j-1\}$$

Notiamo che $\underline{avail[j-1]} = \underline{avail'[j-1]}$, perche' sono sugli stessi elementi (magari permutati).

%% Completare %%

## Problemi
L'algoritmo del banchiere funziona ed e' ottimale, ma **bisognerebbe conoscere per ogni processo tutte le risorse che vorrà usare, e non è banale**.

## Referenze