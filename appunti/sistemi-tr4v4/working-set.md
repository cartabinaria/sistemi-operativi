---
tags:
  - category/note
  - status/finished
  - topic/sistemi-operativi
date: 04-05-2025 17:46:45
links:
  - "[[lecture-04042025092728|Lecture 04042025092728]]"
---
# Working set
---
## Introduzione
> Il **working set** è un concetto utilizzato nella [[gestione-della-memoria|gestione della memoria]] per descrivere l'_insieme di [[paginazione|pagine]] in memoria, quindi frame, che un [[processo|processo]] sta attualmente utilizzando_. Formalmente, si definisce **working set di finestra $\Delta$** l'insieme delle pagine accedute nei piu' recenti $\Delta$ riferimenti della stringa di riferimenti del processo.
> Serve, nella sua essenza, a mitigare il fenomeno del [[trashing|trashing]].

E' una rappresentazione approssimata del concetto di localita' della [[cache|cache]].

## Funzionamento
Fondamentalmente, si calcola attraverso una stima, guardando la stringa dei riferimenti del passato, la _grandezza di $\Delta$ per ogni processo attivo_. Questa indichera' una _stima delle grandezze dei working set di tutti i processi_, ossia di quanti frame ogni processo ha bisogno per poter funzionare senza page fault.

Quindi, **la somma dell'ampiezza di tutti i working set dei processi attivi, affinche' il sistema non vada in trashing dev'essere sempre minore del numero di frame disponibili**.

Di conseguenza, _quando ci sono sufficienti frame disponibili non occupati dai working set dei processi attivi, allora si puo' allocare un nuovo processo_. Se al contrario, _la somma dei working set supera il numero totale dei frame, si puo' decidere di sospendere un processo (o piu') per evitare il trashing_.

### Scelta di $\Delta$
La scelta di $\Delta$ e' determinante:
- se $\Delta$ e' troppo piccolo, si rischia di sottostimare il numero di pagine necessarie per il processo --> falsi negativi di trashing;
- se $\Delta$ e' troppo grande, si rischia di sovrastimare il numero di pagine necessarie per il processo --> falsi positivi di trashing.

## Referenze