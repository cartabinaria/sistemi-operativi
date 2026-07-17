---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 13:52:41
links:
  - "[[lecture-21032025091929|Lecture 21032025091929]]"
---
# Algoritmo a stack
---
## Introduzione
> Un **algoritmo a stack** e' un [[algoritmi-di-paginazione|algoritmo di paginazione]] $A$ tale per cui, data una _stringa di riferimenti_ $s$, e definito $S_{t}(s, A, m)$ come l'insieme delle pagine mantenute in [[ram|memoria primaria]] al tempo $t$ data una memoria di $m$ frame relativamente alla stringa $s$, vale che
> $$\forall t, s \ \ \ S_{t}(s, A, m) \subseteq S_{t}(s, A, m+1)$$
> In altre parole, un algoritmo e' a stack, se in qualunque istante e per qualunque stringa di riferimenti, **l'insieme delle pagine in memoria primaria e' un sottoinsieme dell'insieme delle pagine in memoria primaria con un frame in piu'**.

## Teorema
> Un algoritmo a stack non genera casi di [[anomalia-di-belady|anomalia di Belady]], e quindi se aumento i frame non puo' aumentare il numero di page fault.

### Dimostrazione
Fissiamo $A, s, t, m$ e assumiamo $A$ sia a stack, ovvero $S_{t}(s, A, m) \subseteq S_{t}(s, A, m+1)$. Assumiamo  che $S_{t}(s, A, m+1)$ contenga un elemento in piu' rispetto a $S_{t}(s, A, m)$ (dopo un certo $t$ tale che si sia verificato un page fault su $S_{t}(s, A, m)$).

Il riferimento in $s$ per l'istante $t+1$, che chiamiamo $p$, puo' essere:
- $p \in S_{t}(s, A, m)$ --> non c'e' page fault, ne' con $m$ ne' con $m+1$;
- $p \notin S_{t}(s, A, m)$ --> c'e' page fault con $m$, e
	- $p \in S_{t}(s, A, m+1)$ --> non c'e' page fault con $m+1$;
	- $p \notin S_{t}(s, A, m+1)$ --> c'e' page fault con $m+1$.

In questo caso, dalla relazione del sottoinsieme, abbiamo 3 casi:
1. $p \in S_{t}(s, A, m)$ e $p \in S_{t}(s, A, m+1)$ --> non c'e' mai page fault;
2. $p \notin S_{t}(s, A, m)$ e $p \in S_{t}(s, A, m+1)$ --> c'e' page fault solo nel caso $m$;
3. $p$ non c'e' da entrambi --> c'e' page fault su entrambi.

In ogni caso, **con $m+1$ frame non ci puo' essere un numero di page fault superiore al caso con $m$**.

**Qed**.

## Referenze