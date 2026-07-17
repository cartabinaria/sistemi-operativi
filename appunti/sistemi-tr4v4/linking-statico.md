---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 24-11-2023 19:13:18
links:
  - "[[lecture-22112023151203|Lecture 22112023151203]]"
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# Linking statico
---
## Introduzione
> Il **linking statico** è un tipo di [[linking|linking]] che prevede che _tutti i moduli oggetto vengano uniti in un unico file eseguibile, prima di essere caricati in memoria_, ossia a _compile-time_ (durante la [[compilazione|compilazione]]).

## Funzionamento
La fase di linking statico prevede una serie di operazioni:
1. _unione dei moduli_
2. _rilocazione dei riferimenti interni_
3. _rilocazione dei riferimenti esterni_

### 1. Unione dei moduli
Per prima cosa, i moduli oggetto vengono uniti in un unico file, secondo un ordine deciso dal linker. Esso si tiene traccia, per ogni modulo, di:
- _lunghezza del modulo_ - ovvero di quante istruzioni è composto
- _indirizzo di inizio nel nuovo spazio di indirizzamento_ - ovvero in quale posizione ("riga") si trova rispetto all'inizio del file

Queste informazioni saranno necessarie ai fini dei passi successivi.

### 2. Rilocazione dei riferimenti interni
Per ogni modulo, ogni indirizzo di _salto interno_ dovrà essere sommato all'_indirizzo di inizio nel nuovo spazio di indirizzamento_ (ricavato al passo precedente)[^1].

### 3. Rilocazione dei riferimenti esterni
Si sfrutta, in questo caso, un prodotto del [[traduttore|traduttore]] (nella fase di compilazione): il **[[modulo-oggetto|modulo oggetto]]**. Esso contiene una serie di informazioni utili al linker:
![[modulo-oggetto.png]]

In particolare si consulta la _tabella dei riferimenti esterni_ per sostituire, per ogni modulo, ad ogni indirizzo di _salto esterno_, il giusto indirizzo del modulo di riferimento (trovabile nella _tabella dei punti di ingresso_).

#### Esempio
Il modulo `A` ha nella _tabella dei riferimenti esterni_ una chiamata di funzione (`CALL`) a una procedura del modulo `B`. Per poter _risolvere l'indirizzo giusto_ basta andare nella _tabella dei punti di ingresso_ di `B` e trovare il corrispondente indirizzo della procedura interessata, da sostituire nella `CALL` di `A`.

### Fase finale
Una volta uniti correttamente i moduli, bisogna ricordare che **gli indirizzi del file eseguibile non sono gli stessi che verranno usati al momento del caricamento del programma in RAM** (a meno che il programma non sia caricato alla cella 0...). Sarà quindi compito del [[loader|loader]] di _sommare, ad ogni indirizzo di salto, l'indirizzo offset della prima locazione in cui viene caricato il programma_.

## Referenze
[^1]: similarmente a quanto avviene nella [[segmentazione-principio-di-funzionamento|segmentazione]], per cui ogni indirizzo di un segmento dovrà essere tradotto in uno fisico, basandosi sull'offset della porzione dedicata al segmento in [[ram|memoria]]