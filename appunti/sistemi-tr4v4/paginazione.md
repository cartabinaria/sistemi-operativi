---
tags:
  - category/note
  - status/finished
  - topic/architettura-degli-elaboratori
  - topic/sistemi-operativi
date: 22-10-2023 20:40:01
links:
  - "[[lecture-19102023130600|Lecture 19102023130600]]"
  - "[[lecture-16112023133640|Lecture 16112023133640]]"
  - "[[lecture-20032025151643|Lecture 20032025151643]]"
---
# Paginazione
---
## Introduzione
I meccanismi di [[allocazione|allocazione]] (a partizioni fisse e [[allocazione-dinamica|dinamica]]) visti in precedenza, sono stati superati da un meccanismo più complesso e potente, che consente di utilizzare la memoria in modo più efficiente e flessibile: la **paginazione**.

## Definizione
> La **paginazione** è un meccanismo gestito dal [[sistema-operativo|sistema operativo]] per ridurre la [[frammentazione-interna|frammentazione interna]] ed eliminare quella [[frammentazione-esterna|esterna]][^1].
> Inoltre, consente di implementare con facilita' la [[memoria-virtuale|memoria virtuale]].

<u>Nota bene</u>: necessita' pero' di hardware adeguato, in particolare di una [[mmu|MMU]] di un certo tipo.

Come avviene tra la [[cache|cache]] e la [[ram|RAM]], anche in questo caso _sono necessarie politiche di trasferimento dei dati dalla memoria al disco rigido_.

Gli algoritmi che si occupano di fare questo sono chiamati [[algoritmi-di-paginazione|algoritmi di paginazione]] dal nome dei blocchi di dati trasferiti dal disco alla memoria per ogni occorrenza, per l'appunto detti **pagine**.

## Storia
La paginazione fu ideata negli anni '60 da un gruppo di ricercatori di Manchester, quando _notarono che dei 16 bit usati per indirizzare le locazioni di RAM ne erano necessari solo 12_! Infatti la maggior parte delle architetture era di _word da 2 byte_, ma le memorie arrivavano fino a 4096 locazioni da 16 bit (8KB di spazio). Ciò significava che **gli indirizzi da 4096 a 65535 erano semplicemente inutilizzati**.

L'idea fu quella di implementare, attraverso un _meccanismo di swapping tra memoria principale e memoria secondaria_, una memoria virtuale da 65K locazioni. Secondo questo principio, ogni blocco di 4K locazioni (chiamato _pagina_) veniva salvato permanentemente in memoria di massa, e caricato in RAM qualora un programma ne avesse richiesto l'accesso. Di fatto, attraverso un **meccanismo di traduzione** da _indirizzi virtuali_ a _indirizzi fisici_, un programma avrebbe potuto usufruire in maniera trasparente di ben 64K locazioni di memoria.

## Principio di funzionamento
In linea di principio la _memoria fisica_ viene suddivisa in blocchi chiamati **frame**, mentre la _memoria logica_ in blocchi della stessa dimensione chiamati **pagine**.

Quando un processo viene allocato in memoria, vengono reperiti _ovunque_ in memoria un _numero sufficiente di frame per contenere le pagine del processo_. Questo consente di **non dover necessariamente avere locazioni contigue per ogni processo**, e di **virtualizzare la contiguità**! Infatti, i frame non devono essere necessariamente contigui in RAM.
![[paginazione-1.png]]

A questo punto, si tiene traccia della corrispondenza tra le pagine e i frame in RAM attraverso una **tabella delle pagine**. Questa è una struttura dati che contiene un record per ogni pagina, in cui sono memorizzati gli indirizzi dei frame in RAM che contengono le pagine del processo.
![[paginazione-2.png]]

### Traduzione
Nella pratica, e' la MMU ad occuparsi di tradurre gli [[indirizzo-logico|indirizzi logici]] in [[indirizzo-fisico|indirizzi fisici]].

Ogni indirizzo logico e' composto da:
- _indice_ della pagina;
- _offset_ all'interno della pagina.

Quello fisico, invece, da:
- _indice_ del frame;
- _offset_ all'interno del frame.

La MMU, quindi, **mappera' l'indice della pagina nell'indice del frame, mantenendo invariato l'offset**.
![[paginazione-3.png]]

### Tabella delle pagine
Ma dove viene memorizzata la tabella delle pagine? Potremmo:
- salvarla in registri dedicati, ad alta velocita', all'interno della MMU (o della CPU) --> troppo costoso;
- salvarla tutta in RAM --> il numero di accessi in memoria verrebbe raddoppiato!

Quindi, nei sistemi odierni, si usa una [[tlb|TLB]].

### Memoria virtuale
Nel caso dell'utilizzo della paginazione per memoria virtuale, la RAM viene sempre divisa in **blocchi**, e la memoria virtuale in **pagine**, della _medesima dimensione dei blocchi_. Le pagine sono tutte salvate in memoria di massa, e il numero massimo di pagine contenibili in RAM è ovviamente il suo numero di blocchi. Quando un _programma punta a un indirizzo virtuale, esso viene prima verificato se si trova in RAM o meno, e se si trova viene tradotto in fisico, altrimenti viene caricato in RAM e quindi tradotto in fisico_.

#### Esempio
![[pagina-e-blocchi.png|500]]

Nel caso sopra i $2^{15}$ indirizzi fisici (in RAM) sono suddivisi in 8 blocchi, per cui si hanno:
- 3 bit - _dedicati al blocco_
- 12 bit - _detti di offset_, motivo per cui ogni blocco/pagina è di $2^{12}$ locazioni (4K) ($2^{12}$ locazioni $\times$ $2^{3}$ blocchi $=$ $2^{15}$ indirizzi)

Gli indirizzi virtuali invece sono $2^{16}$, ovvero:
- 4 bit - _dedicati alla pagina_, 1 bit in più rispetto ai blocchi (per cui si ottiene infatti il doppio delle locazioni)
- 12 bit - _lo stesso offset degli indirizzi fisici_

Il meccanismo sta semplicemente nella traduzione da un indirizzo virtuale a un indirizzo fisico. Quando un programma punta a un indirizzo virtuale, il nostro intento è _tradurre i bit della pagina nei bit del blocco corrispondente_. Infatti **l'offset è lo stesso**.
Per tenere traccia della corrispondenza tra pagina e blocchi si ha la **tabella delle pagine**:
![[tabella-delle-pagine.png|200]]

Fondamentalmente, _di un indirizzo virtuale vengono presi i bit della pagina_ (in questo caso 4), che corrispondono a uno specifico indice nella tabella delle pagine, _da cui si ricavano i bit del blocco corrispondente in RAM_. Questo processo di traduzione è gestito da un chip hardware chiamato [[mmu|MMU]] (_Memory Management Unit_).

Ma <u>attenzione</u>: la RAM non può contenere ogni pagina (è quello il punto), per cui non sempre una pagina richiesta è già in RAM. Infatti nella tabella delle pagine, ad ogni record è associato anche un bit che:
- **se a 1** --> significa che la pagina è già in RAM, quindi basta ottenere i bit del blocco associato e si ottiene l'indirizzo fisico
- **se a 0** --> significa che la pagina non è in RAM, si ha il [[trap|trap]] **page fault**, bisogna applicare un [[algoritmi-di-paginazione|algoritmo di paginazione]] che, se non c'è un blocco di RAM disponibile, scelga un blocco di RAM da "sacrificare" e trasferisca al suo posto la pagina salvata in memoria secondaria

<u>Nota bene</u>: le pagine al momento in memoria vengono dette **working set**.

## Considerazioni
### Dimensione delle pagine
Per semplificare la traduzione da indirizzi logici a fisici, la dimensione delle pagine (e quindi anche dei frame) sono scelte come potenze del 2.

Quanto grande devono essere, invece, dipende da un trade-off:
- _pagine/frame piccole_ --> meno frammentazione interna, ma piu' record nella tabella delle pagine;
- _pagine/frame grandi_ --> piu' frammentazione interna, ma meno record nella tabella delle pagine.

Dei valori tipici di pagine sono 1KB, 2KB, 4KB.

### Memoria virtuale
Questo meccanismo, gestito dal sistema operativo, dev'essere realizzato in modo che **un qualsivoglia programma in esecuzione possa accedere a indirizzi virtuali in completa trasparenza**.

E' importante tenere a mente che un **RAM-miss** pesa molto di più di un **cache-miss**: andare a _recuperare i dati in memoria virtuale significa accedere alla memoria di massa, estremamente più lenta della memoria centrale_. Nella progettazione degli algoritmi di paginazione questo aspetto dev'essere tenuto bene in considerazione.

<u>Nota bene</u>: lo spazio dedicato in memoria di massa per la paginazione è chiamato **swap**.

L'utilizzo di memoria virtuale viene usato in concomitanza a quello della cache: l'uno non esclude l'altro. Si va infatti a creare così, [[memorie-classificazione|in accordo con la velocità e capacità delle diverse memorie]], una **vera e propria gerarchia di memorie** che contribuiscono a una migliore performance generale del calcolatore.

## Referenze
- [[combinazione-segmentazione-paginazione|Combinazione segmentazione-paginazione]]

[^1]: in realta' non si elimina del tutto...
