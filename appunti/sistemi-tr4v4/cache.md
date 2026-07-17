---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 25-09-2023 15:43:09
links:
  - "[[lecture-25092023130405|Lecture 25092023130405]]"
  - "[[lecture-18102023151217|Lecture 18102023151217]]"
  - "[[lecture-19102023130600|Lecture 19102023130600]]"
  - "[[lecture-21022025091223|Lecture 21022025091223]]"
---
# Cache
---
## Introduzione
> La **cache** è una memoria interna alla [[cpu|CPU]] usata per memorizzare informazioni probabilmente utili al processore nella prossimità presenti in [[ram|RAM]]. Il contenuto della cache sarà sempre e solo un [[definizione-di-essere-sottoinsieme|sottoinsieme]] della RAM.
> Formalmente, _la cache di `x` e' una memoria piu' veloce di `x` che tiene un sottoinsieme dei dati di `x`_.

La RAM è una memoria molto grande; i registri contengono massimo una _word_ (max. 64 bit). La cache è una _via di mezzo_, perché meno capiente della RAM ma più veloce di essa.

Con la cache non si può comunicare in maniera diretta, come per esempio si farebbe con la memoria e con i registri attraverso [[assembly|assembly]]: è _invisibile al software_, funziona "autonomamente".

### Scopo
La CPU accede alla RAM solitamente in locazioni sempre vicine, o meglio una in sequenza all'altra: le istruzioni sono salvate in memoria ed eseguite una in seguito all'altra. Raramente la CPU dovrà accedere a locazioni _lontane_ (`JMP`).

Lo scopo della cache è allora quello di **salvare le informazioni che la CPU ha più probabilità di usare**, così **velocizzare il processo di prelevazione dei dati dalla memoria**.

Infatti _logicamente_ parlando la cache si trova più vicino della memoria.
![[cache-e-memoria.png]]

### Tipologie
In generale all'interno delle moderne architetture degli elaboratori, esistono _3 livelli di cache_:
- _L1_, poco capiente e situata nel chip della CPU (16-64 KB)
- _L2_, mediamente capiente e situata nell'involucro della CPU (512 KB-1 MB)
- _L3_, tanto capiente e situata tra CPU e RAM (alcuni MB)

![[livelli-cache.png]]

## Funzionamento
Cosa determina che cosa la cache debba salvare e cosa non è il cosiddetto **principio di località**:
- _località temporale_ - salva ciò a cui ha appena fatto accesso la CPU perché è molto probabile che nel prossimo futuro ci riaccederà[^1]
	- es. salvo cella 12 perché ci ha fatto l'accesso
- _località spaziale_ - salva ciò che è vicino a ciò a cui ha appena fatto accesso alla CPU perché è molto probabile che nel prossimo futuro ci accederà[^2]
	- es. salvo cella 13, 14, 15 perché ha fatto l'accesso a cella 12

Nella pratica si mettono in cache **blocchi di locazioni contigue** dalla memoria, aumentando la probabilità che la CPU trovi quel che servi lì.

Questo principio, però, **non è infallibile**: non è determinabile con precisione se la cache conterrà ciò che effettivamente serve alla CPU.
Per cui i casi di [[ciclo-di-fetch-decode-execute|fetch]] del processore sono due:
- se la cella `x` è presente in cache allora la preleva da lì
- se la cella `x` non è presente in cache allora la preleva dalla RAM e la copia in cache e nel processore

<u>Da notare</u>: la CPU quindi **accede sempre prima alla cache** e poi alla memoria.

<u>Nota bene</u>: l'indeterminatezza dei tempi di accesso alla memoria da' fastidio ai [[sistema-real-time|sistemi real-time]]!

<u>Nota bene</u>: la cache CPU e' gestita lato hardware; la cache disco ([[memoria-virtuale|memoria virtuale]]) e' gestita invece dal [[sistema-operativo|sistema operativo]].

## Organizzazione
Al livello di [[microarchitettura|microarchitettura]] si definisce il modo in cui la cache è organizzata, ed esistono diverse politiche:
- [[direct-mapped-cache|Direct Mapped Cache]]

## Risparmio
Ovviamente, affinché la cache faccia risparmiare tempo, il guadagno dato dal _fetch_ sulla cache dev'essere superiore al tempo perso per accedere sia alla cache che alla RAM.

Quindi, dati:
- $m$ = tempo di accesso in memoria
- $c$ = tempo di accesso in cache
- $h$ = _hit-ratio_ (quanto è probabile che la cache contenga informazioni utili al processore)

Allora il tempo di _fetch_ in un processore <u>con</u> cache è in media
$$hc + (1-h)(c+m)$$
o più semplicemente
$$c + (1-h)m$$
ovvero **il tempo per accedere in cache più il tempo per accedere in memoria moltiplicato alla probabilità che non ci siano le informazioni in cache** ($1-h$).

### Casi estremi
Nei casi estremi
- $h = 1 \implies$ tempo di accesso sempre e solo $c$
- $h = 0 \implies$ tempo di accesso sempre e solo $c+m$

Da quest'ultimo caso possiamo quindi notare che **se la cache ha un hit-ratio troppo basso risulta dannosa**, dove per "troppo basso" intendiamo un valore abbastanza piccolo da non far guadagnare nessun vantaggio in termini di tempo (o addirittura da causare svantaggi).

## Referenze
[^1]: avviene per esempio con i [[iterazione-for|cicli for]]
[^2]: si presenta il caso con gli [[array|Array]] o con la normale esecuzione sequenziale delle istruzioni