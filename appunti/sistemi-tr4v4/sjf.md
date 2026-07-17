---
tags:
  - category/note
  - status/finished
  - topic/algoritmi-e-strutture-dati
  - topic/sistemi-operativi
date: 19-04-2024 12:21:51
links:
  - "[[lecture-15042024091754|Lecture 15042024091754]]"
  - "[[lecture-06032025151956|Lecture 06032025151956]]"
---
# SJF
---
## Introduzione
> Il **SJF** (**Shortest Job First**) e' un [[algoritmo|algoritmo]] di [[scheduling|scheduling]] _non-preemptive_, che prevede che _la [[cpu|CPU]] sia assegnata al processo nella ready queue con la durata minima del CPU burst_.

## Funzionamento
Si sceglie di **eseguire il processo con tempo di esecuzione minore per minimizzare complessivamente il tempo di attesa di tutti i processi**, implementando a tutti gli effetti un [[algoritmi-greedy|algoritmo greedy]].

Si considerino in particolare $n$ _job_ $p_{1}, \cdots, p_{n}$, ognuno dei quali $p_{i}$ ha un tempo di esecuzione $t[i]$. Per minimizzare il tempo medio di attesa è sufficiente eseguire i job in ordine crescente di tempo di esecuzione.

### Dimostrazione di ottimalità
Consideriamo [[regole-di-inferenza-del-raa|per assurdo]] una _soluzione ottimale non greedy_ che esegua un job lungo $A$ prima di uno più corto $B$. Scambiando $A$ con $B$ otteniamo una soluzione con un tempo medio di attesa migliore, ovvero un ottimo globale, in contrasto con l'assunzione iniziale della soluzione ottimale.

**Qed**.

## Realta'
Nonostante la sua ottimalita' rispetto al tempo medio di attesa, **l'SJF e' impossibile da implementare in pratica**: questo perche' _non si e' in grado staticamente di conoscere il CPU burst di ogni processo_!

Inoltre puo' essere soggetto a [[starvation|starvation]].

Possiamo solo stimare quanto tempo impieghera' un processo in CPU, magari basandosi su quelli precedenti. Di solito, questo si fa con la _media esponenziale_ dei CPU burst precedenti.

### Media esponenziale
Si considera $t_{n}$ il tempo _effettivo_ dell'$n$-esimo CPU burst, e $\tau_{n}$ il tempo _previsto_ dell'$n$-esimo CPU burst. Quindi, fissato un $\alpha$, si stima $\tau_{n+1}$ come
$$\tau_{n+1} = \alpha t_{n} + (1 - \alpha)\tau_{n}$$

Questa e' a tutti gli effetti un'[[equazione-di-ricorrenza|equazione di ricorrenza]], che si risolve in:
$$\tau_{n+1} = \sum\limits_{j=0}^{n} \alpha(1 - \alpha)^{j} t_{n-j} + (1-\alpha)^{n+1} \tau_{0}$$

## Referenze