---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/linguaggi-di-programmazione
  - topic/sistemi-operativi
date: 24-11-2023 17:17:21
links:
  - "[[lecture-20112023130829|Lecture 20112023130829]]"
  - "[[lecture-26022025111603|Lecture 26022025111603]]"
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# Frammentazione esterna
---
## Introduzione
> La **frammentazione esterna** è una [[frammentazione|frammentazione]] della [[ram|RAM]] che si verifica a seconda della strategia di [[allocazione|allocazione]] della [[ram|memoria]].

Nel caso dei sistemi operativi, se si ha allocazione a partizioni dinamiche, la memoria viene allocata in blocchi di dimensioni variabili, a seconda delle esigenze del programma. La **frammentazione esterna si verifica quando i blocchi di memoria allocati non sono contigui e ci sono spazi vuoti tra di essi**.

Inoltre, nel caso della [[segmentazione|segmentazione]], lo _swap_ di un segmento dalla memoria secondaria a quella principale non avviene in maniera così banale come per la [[paginazione|paginazione]]. Questo perché i segmenti hanno grandezze distinte. In particolare la frammentazione esterna si verifica quando **un blocco di una certa dimensione viene sostituito da uno di dimensione minore**, lasciando in memoria un piccolo _gap_ che non è riempibile con nessun altro segmento.

Questi gap, sparsi nella memoria, finiscono con l'accumularsi, portando ad una situazione di stallo, in cui _gli spazi rimasti non sono abbastanza grandi da contenere un nuovo segmento_.

Quindi, in una situazione di frammentazione esterna, _ci sarebbe complessivamente lo spazio necessario, ma e' inutilizzabile perche' suddiviso in porzioni di memoria contigua troppo piccole_.

<u>Nota bene</u>: il motivo per cui non possiamo pensare di spezzare il dato nelle porzioni non contigue di memoria, e' perche' **bisogna rispettare le modalita' e quindi i tempi di accesso alle variabili**. Si pensi a un [[array|array]]: _dev'essere memorizzato in modo contiguo perché l'accesso dev'essere tramite un offset_; in realta' anche le stesse variabili non sono accedute tramite il nome, ma da un offset a partire dalla prima dichiarazione (come se fossero elementi di un array).

## Soluzione
Per risolvere, o almeno limitare il più possibile la frammentazione esterna, ci sono tre tecniche:
- [[best-fit|best fit]]
- [[first-fit|first fit]]
- [[defrag|defrag]]

Il metodo però migliore per evitare del tutto la frammentazione esterna consiste nel [[combinazione-segmentazione-paginazione|combinare la segmentazione con la paginazione]].

Un altro sistema consiste nella [[compattazione|compattazione]] della memoria.

## Referenze