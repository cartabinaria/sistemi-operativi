---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 24-11-2023 19:16:14
links:
  - "[[lecture-22112023151203|Lecture 22112023151203]]"
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# Linking dinamico
---
## Introduzione
A differenza di quanto avviene con il [[linking-statico|linking statico]], ci possono essere casi in cui i moduli oggetto non vengono uniti in [[workflow-di-compilazione|fase di compilazione]], ma _linkati_ al momento dell'esecuzione del programma stesso (in _runtime_): questo è il **linking dinamico**.

## Implementazione
Un metodo di implementazione del linking dinamico è attraverso l'utilizzo di un [[segmentazione|segmento]] che contiene nomi e indirizzi delle librerie, _inizializzati appositamente a indirizzi sbagliati_. Il programma viene appositamente modificato così da contenere, per ogni chiamata di funzione, il collegamento alla rispettiva porzione di quel segmento riservata alla libreria. Così, quando un programma richiama una funzione di libreria, il [[sistema-operativo|sistema operativo]] la ricerca in tale segmento, trovando un indirizzo sbagliato che genera una [[trap|trap]]: il gestore della medesima cerca la libreria, la carica in memoria e scrive il giusto indirizzo nel segmento, così che le future chiamate non generino più trap.

Questa implementazione "a trap" consente di non dover avere sempre in memoria tutte le librerie installate, ma solo quelle di volta in volta invocate.

In poche parole quindi **posticipa il caricamento delle librerie al momento della loro invocazione**. Questo è il motivo per cui il linking dinamico è spesso associato al _[[loading-dinamico|loading dinamico]]_: il sistema operativo carica le librerie solo quando vengono richiamate.

## Considerazioni
### Vantaggi
Questo _velocizza molto il processo di compilazione nel caso in cui la procedura di un modulo esterno venga invocata rare volte_: non avrebbe senso creare, con tutto ciò che esso comporta, un unico modulo per invocazioni sporadiche.

Inoltre, se si modifica una libreria, non è necessario ricompilare il programma che la utilizza. Il codice della libreria, infine, si dice essere _reentrant_: viene caricato in un'area di memoria condivisa, a cui tutti i processi che ne hanno bisogno ci accedono.

### Svantaggi
Puo' causare problemi di _versioning_: se una libreria viene aggiornata, il programma che la utilizza potrebbe non funzionare più. Bisogna fare attenzione all'aggiornamento delle librerie, per evitare di rompere i programmi che le utilizzano.

## Utilizzi
Questo sistema viene usato nei [[dll|DLL]] di [[windows|Windows]]: sarebbe inutile inserire, in tutti gli eseguibili, le stesse librerie; inoltre, in caso di aggiornamento, bisognerebbe ricompilare tutti gli eseguibili che includono tali librerie.

## Referenze