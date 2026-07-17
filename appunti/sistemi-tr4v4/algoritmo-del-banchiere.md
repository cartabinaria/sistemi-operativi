---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 26-03-2025 12:21:32
links:
  - "[[lecture-13032025151745|Lecture 13032025151745]]"
---
# Algoritmo del banchiere
---
## Introduzione
> L'**algoritmo del banchiere** e' un [[algoritmo|algoritmo]] ideato da [[edsger-dijkstra|Dijkstra]] per implementare il [[deadlock-avoidance|deadlock avoidance]].

## Idea
### Parametri
Definiamo i parametri seguenti:
- $N$ numero di clienti
- $IC$ capitale iniziale
- $c_{i}$ limite di credito del cliente $i$ ($c_{i} \leq IC$)
- $p_{i}$ denaro prestato al cliente $i$ ($p_{i} \leq c_{i}$)
- $n_{i} = c_{i} - p_{i}$ credito residuo del cliente $i$
- $COH = IC - \sum\limits_{i=1}^{n} p_{i}$ (saldo di cassa)

### Stato
Definiamo $s$ una sequenza ([[permutazione|permutazione]]) degli $N$ indici, e il vettore $avail$ come segue:
- $avail[1] = COH$;
- $avail[i+1] = avail[i] + p_{s[i]} \ \ \ \forall i = 1, \cdots, N-1$;

#### Safe
> Definiamo lo stato **safe** se esiste una sequenza $s$ tale che
> $$n_{s[i]} \leq avail[i] \ \ \ i=1, \cdots, N$$
> Tale stato e' sufficiente a garantire l'assenza di deadlock.

#### Unsafe
> Lo stato **unsafe** e' condizione invece necessaria ma non sufficiente per avere deadlock, ovvero non e' detto ma e' possibile che ci sia deadlock.

## Algoritmo
Consideriamo come esempio il seguente stato iniziale:
![[algoritmo-del-banchiere-1.png]]

Sono stati definiti tutti i parametri, e per ora nessun cliente ha richiesto alcun prestito.

Supponiamo che dopo un certo numero di richieste si arrivi a questa situazione:
![[algoritmo-del-banchiere-2.png]]
e supponiamo che l'ultima operazione fatta sia stata la richiesta di credito pari a 30 del cliente 3. **Prima di poter assegnare effettivamente questo credito al cliente, il banchiere si deve assicurare che lo stato sia safe**. Per farlo quindi cerca una sequenza per cui vale la safeness, in questo caso $3, 2, 1, 4, 5$.

Costruiamo $avail$:
$$avail = [0, 30, 40, 110, 120]$$
e notiamo che:
- $n_{s[1]} = n_{3} \leq avail[1]$ --> SI';
- $n_{s[2]} = n_{2} \leq avail[2]$ --> SI';
- ...
- $n_{s[N]} = n_{5} \leq avail[5]$ --> SI';

allora _lo stato e' safe_!

Nella pratica, **lo state safe puo' essere verificato usando come sequenza $s$ quella che ordina $n_{i}$ in modo crescente**. Se infatti esiste una sequenza safe, allora anche questa lo dev'essere. Di conseguenza, **se questa sequenza non e' safe, allora non esiste alcuna sequenza safe**!

## Realta'
Nella realta', pero', non esiste una sola valuta: non esiste una sola classe di risorse. Per questo si fa riferimento all'[[algoritmo-del-banchiere-multivaluta|algoritmo del banchiere multivaluta]].

## Referenze