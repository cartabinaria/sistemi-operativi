---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 24-11-2023 15:24:32
links:
  - "[[lecture-16112023133640|Lecture 16112023133640]]"
  - "[[lecture-21032025091929|Lecture 21032025091929]]"
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# LRU
---
## Introduzione
> L'**LRU** (_Least Recently Used_) è un [[algoritmi-di-paginazione|algoritmo di paginazione]] che _privilegia la rimozione della [[paginazione|pagina]] del working set da più tempo non utilizzata_.

## Implementazione
Il problema di questo algoritmo e' che richiede uno specifico supporto hardware: nella tabella delle pagine dobbiamo registrare un _timestamp_ per ogni pagina, che indichi l'ultimo accesso a quella pagina (deve farlo l'[[mmu|MMU]]).

Questo timestamp puo' essere ridotto a un contatore, che viene incrementato ad ogni accesso in memoria e assegnato alla entry della pagina acceduta. Tuttavia in questo modo e' necessario tenere conto di eventuali overflow! Questo contatore dovrebbe essere di 128 bit per poter sostenere un upperbound del numero di accessi in memoria: troppo costoso.

### Idea
Si potrebbe pensare, allora, di implementarlo attraverso uno [[stack|stack]]: si mantiene uno stack di pagine, e tutte le volte che una pagina viene acceduta torna in cima; la pagina vittima è quella in fondo allo stack.

Tuttavia questo approccio e' pesante: se lo stack e' implementato attraverso una [[lista|lista]] _double-linked_, i puntatori da aggiornare sono 6.

### Realta'
Nella realta' viene usata una forma **approssimata dell'LRU**, usando un _reference bit_: all'inizio ogni pagina ha questo bit a 0; quando vengono accedute mettono il bit a 1. Con il reference bit, quindi, andiamo a _uniformare i tempi di accesso al solo concetto di accesso_: **perdiamo l'informazione dell'ordine di accesso**.

#### Additional-reference-bit-algorithm
Un metodo che si basa sul reference bit e' l'_additional-reference-bit-algorithm_:
- salviamo i reference bit a intervalli regolari (es. ogni 100ms);
- manteniamo in ogni pagina una "storia" di reference bit, tipo 8 bit;
- quando un nuovo bit viene inserito, la storia viene shiftata a destra e il nuovo bit viene inserito come quello piu' significativo;
- a questo punto _la pagina vittima e' quella con valore degli 8 bit minore_.

#### Second-chance
Un caso particolare dell'algoritmo precedente e' il _second-chance-algorithm_, anche detto _algoritmo dell'orologio_.

La dimensione della storia e' di 1 solo bit, e le pagine in memoria sono gestite come una lista circolare. Quindi, a partire dalla posizione successiva all'ultima pagina caricata, si scorre la lista per trovare la pagina vittima:
- se il reference bit e' a 1, allora lo si azzera e si passa alla pagina successiva;
- se il reference bit e' a 0, allora questa pagina viene scelta come vittima.

Quindi, quando si arriva in fondo, essendo una lista circolare, si torna all'inizio e si continua a scorrere fino a trovare una pagina con reference bit a 0.

<u>Nota bene</u>: se tutti i bit sono a 1, allora la prima pagina considerata avra' il bit a 0 e sara' scelta --> l'algoritmo degenera in FIFO.

L'idea e' buona: _se la pagina e' stata acceduta, probabilmente e' ancora utile, quindi gli do una seconda possibilita'_. Inoltre e' _facile da implementare_, e non richiede gran supporto da parte della MMU.

## Teorema
> L'algoritmo LRU e' un [[algoritmo-a-stack|algoritmo a stack]].

Abbastanza ovvio, basta pensare che i frame mantenuti nello stack con $m$ frame sono sempre un sottoinsieme dei frame mantenuti nello stack con $m+1$ frame.

## Referenze
- [[algoritmo-a-stack|Algoritmo a stack]]